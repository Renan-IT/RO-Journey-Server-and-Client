# Ragnarok Online Discord Bot

A Discord bot for managing Ragnarok Online server accounts and displaying player statistics.

## Features

- Account creation and management
- Password renewal
- Online player list
- WoE statistics display
  - Damage dealt/received
  - Healing amounts
  - Kill/death counts
  - Skill usage
  - Player participation
  - Guild performance

## Prerequisites

- Python 3.8 or higher
- MySQL/MariaDB database
- Discord Bot Token
- rAthena server with WoE tracking system installed

## Database Setup

The bot requires some modifications to your rAthena database. Run the following SQL script to add the necessary tables and columns:

```bash
mysql -u YOUR_DATABASE_USER -p YOUR_DATABASE_NAME < sql/discord_bot.sql
```

This will:
1. Add a `discord_id` column to the `login` table
2. Create tables for WoE statistics tracking:
   - `woe_data`: Stores player statistics
   - `woe_sessions`: Tracks WoE event sessions
   - `woe_participation`: Records player participation
3. Create necessary indexes for performance
4. Create a view for easy access to WoE statistics

### Database Structure

#### woe_data Table
- `player_name`: Character name
- `damage_amount`: Total damage dealt
- `damage_received`: Total damage received
- `heal_amount`: Total healing provided
- `kill_count`: Number of kills
- `death_count`: Number of deaths
- `skill_count`: Number of skills used
- `last_update`: Last update timestamp

#### woe_sessions Table
- `start_time`: Session start time
- `end_time`: Session end time
- `castle_id`: Castle ID
- `guild_id`: Guild ID
- `guild_name`: Guild name
- `status`: Session status (active/completed/cancelled)

#### woe_participation Table
- `session_id`: Reference to woe_sessions
- `player_name`: Character name
- `guild_id`: Guild ID
- `guild_name`: Guild name
- `join_time`: Join timestamp
- `leave_time`: Leave timestamp

## Setup

1. Clone the repository
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Configure the bot:
   - Copy `.env.template` to `.env`:
     ```bash
     cp .env.template .env
     ```
   - Edit `.env` with your configuration:
     ```
     DISCORD_TOKEN=your_actual_discord_token
     COMMAND_PREFIX=!
     DB_HOST=your_database_host
     DB_USER=your_database_user
     DB_PASS=your_database_password
     DB_NAME=your_database_name
     ```

4. Run the bot:
   ```bash
   python bot.py
   ```

## Commands

- `!accreate <username> <password> <gender>`: Create a new account
  - Example: `!accreate player123 password123 M`
  - Gender must be 'M' or 'F'

- `!passrenew <new_password>`: Reset your account password
  - Example: `!passrenew newpassword123`

- `!online`: Show currently online players
  - Displays player name, class, base level, and job level

- `!woe`: Show WoE statistics
  - Displays damage dealt, damage received, healing, kills, deaths, and skills used
  - Format: `!woe [player_name]` (optional player name for specific player stats)

- `!woe guild <guild_name>`: Show guild WoE statistics
  - Displays guild performance in WoE
  - Includes total damage, kills, and participation

## Security Notes

- Never commit your `.env` file or any files containing sensitive information
- Keep your Discord bot token and database credentials secure
- Use strong passwords for all accounts
- Regularly update your dependencies for security patches

## Troubleshooting

1. **Bot won't start**
   - Check if your `.env` file is properly configured
   - Verify your Discord bot token is valid
   - Ensure all dependencies are installed

2. **Database connection issues**
   - Verify database credentials in `.env`
   - Check if the database server is running
   - Ensure the database user has proper permissions

3. **Commands not working**
   - Check if the bot has proper permissions in your Discord server
   - Verify the command prefix in `.env`
   - Ensure the bot is online and responding

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
