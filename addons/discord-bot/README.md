# Ragnarok Online Discord Bot

A feature-rich Discord bot designed to enhance your Ragnarok Online server management and player experience.

## Features

### Account Management
- Create new game accounts
- Reset account passwords
- View account status

### Server Statistics
- Real-time player count
- Online player list with details
- Server status monitoring

## Installation

### Prerequisites
- **Python 3.8 or higher**: Ensure Python is installed on your system. You can install it using the following command:
  ```bash
  sudo apt update
  sudo apt install python3 python3-pip
  ```
- MySQL/MariaDB database
- Discord Bot Token

### Setup Instructions

1. **Navigate to the rAthena Directory**
   ```bash
   cd /home/rathena
   ```

2. **Download Required Files**
   - Use `wget` to download the necessary files:
     ```bash
      mkdir -p addons/discord-bot
      wget -P addons/discord-bot https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/discord-bot/requirements.txt
      mkdir -p addons/discord-bot/config
      wget -P addons/discord-bot/config https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/discord-bot/config/config.py
      mkdir -p addons/discord-bot
      wget -P addons/discord-bot https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/discord-bot/bot.py
      mkdir -p addons/discord-bot/sql
      wget -P addons/discord-bot/sql https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/discord-bot/sql/discord_bot.sql
     ```

3. **Install Dependencies**
   ```bash
   pip install -r addons/discord-bot/requirements.txt
   ```

4. **Database Setup**
   - Import the database schema:
     ```bash
     mysql -u $DB_USER -p $DB_NAME < addons/discord-bot/sql/discord_bot.sql
     ```

5. **Run the Bot**
   ```bash
   python addons/discord-bot/bot.py
   ```

## Available Commands

### Account Management
- `!accreate <username> <password> <gender>` - Create a new account
  - Example: `!accreate player123 password123 M`
  - Gender must be 'M' or 'F'
- `!passrenew <new_password>` - Reset your account password
  - Example: `!passrenew newpassword123`

### Server Information
- `!online` - Show currently online players
  - Displays player name, class, base level, and job level
- `!status` - Show server status and player count

## Project Structure
```
discord-bot/
├── config/
│   └── config.py         # Configuration settings
├── utils/
│   └── db.py            # Database utilities
├── commands/
│   ├── account.py       # Account-related commands
│   └── stats.py         # Statistics commands
├── sql/
│   └── discord_bot.sql  # Database schema
├── bot.py               # Main bot file
├── requirements.txt     # Python dependencies
└── README.md           # Documentation
```

## Database Structure
- `woe_data`: Player statistics during WoE
- `woe_sessions`: WoE event session tracking
- `woe_participation`: Player participation records

## Security Considerations
- Keep your Discord bot token secure
- Use strong passwords for all accounts
- Regularly update dependencies for security patches
- Implement rate limiting for commands
- Validate all user inputs

## Troubleshooting

### Bot Won't Start
- Check if configuration in `config.py` is correct
- Verify Discord bot token is valid
- Ensure all dependencies are installed
- Check Python version compatibility

### Database Connection Issues
- Verify database credentials in `config.py`
- Check if database server is running
- Ensure database user has proper permissions
- Check network connectivity

### Commands Not Working
- Check bot permissions in Discord server
- Verify command prefix in `config.py`
- Ensure bot is online and responding
- Check command syntax

## Contributing
Contributions are welcome! Please feel free to submit pull requests.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
