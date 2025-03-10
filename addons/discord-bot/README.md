# Ragnarok Online Discord Bot

A Discord bot for managing Ragnarok Online server accounts and displaying player statistics.

## Features

- Account creation and management
- Password renewal
- Online player list
- WoE statistics display

## Prerequisites

- Python 3.8 or higher
- MySQL/MariaDB database
- Discord Bot Token

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
