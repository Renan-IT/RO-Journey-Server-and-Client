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

### WoE (War of Emperium) System
The bot includes a comprehensive WoE tracking system that monitors:
- Player damage dealt and received
- Healing amounts
- Kill and death counts
- Skill usage statistics
- Player participation rates
- Guild performance metrics

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
     wget -P addons/discord-bot https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/discord-bot/requirements.txt
     wget -P addons/discord-bot https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/discord-bot/config/config.py
     wget -P addons/discord-bot https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/discord-bot/bot.py
     wget -P addons/discord-bot https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/discord-bot/sql/discord_bot.sql
     wget -P addons/woe-tracker https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/woe-tracker/woe_tracker.c
     wget -P addons/woe-tracker https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/woe-tracker/woe_tracker.h
     wget -P addons/woe-tracker https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/woe-tracker/woe_tracker.txt
     wget -P addons/woe-tracker https://github.com/Renan-IT/RO-Journey-Server-and-Client/raw/main/addons/woe-tracker/battle.patch
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

5. **WoE Tracker Setup**
   - Copy source files:
     ```bash
     cp addons/woe-tracker/woe_tracker.c src/map/
     cp addons/woe-tracker/woe_tracker.h src/map/
     ```
   - Apply patches:
     ```bash
     cd /home/rathena
     patch -p1 < addons/woe-tracker/battle.patch
     ```
   - Add scripts:
     ```bash
     cp addons/woe-tracker/woe_tracker.txt conf/script/
     ```
   - Update configuration:
     - Append the following line to `conf/import/script.conf`:
       ```bash
       echo "script: conf/script/woe_tracker.txt" >> conf/import/script.conf
       ```
   - Recompile the server:
     ```bash
     make clean
     make server
     ```

6. **Configure the Bot**
   - Edit `addons/discord-bot/config/config.py` with your database and Discord bot details:
     ```python
     # Database configuration
     DB_CONFIG = {
         'host': 'localhost',
         'user': '$DB_USER',     # Your database user
         'password': '$DB_PASS', # Your database password
         'database': '$DB_NAME'  # Your database name
     }

     # Discord configuration
     DISCORD_TOKEN = 'your_discord_bot_token'  # Your bot token
     COMMAND_PREFIX = '!'
     ```

7. **Run the Bot**
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

### WoE Statistics
- `!woe` - Show WoE statistics
  - Displays damage dealt/received, healing, kills, deaths, and skills used
- `!woetop` - Show top performers in current WoE
- `!guild <guild_name>` - Show guild WoE statistics

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
