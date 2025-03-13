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
- Python 3.8 or higher
- MySQL/MariaDB database
- Discord Bot Token

### Database Setup
```bash
mysql -u YOUR_DATABASE_USER -p YOUR_DATABASE_NAME < sql/discord_bot.sql
```

### WoE Tracker Setup
1. **Copy Source Files**
   ```bash
   cp woe-tracker/woe_tracker.c src/map/
   cp woe-tracker/woe_tracker.h src/map/
   ```

2. **Apply Patches**
   ```bash
   cd rAthena
   patch -p1 < addons/woe-tracker/battle.patch
   ```

3. **Add Scripts**
   ```bash
   cp woe-tracker/woe_tracker.txt conf/script/
   ```

4. **Update Configuration**
   Add to `conf/script.conf`:
   ```conf
   script: conf/script/woe_tracker.txt
   ```

5. **Recompile Server**
   ```bash
   make clean
   make server
   ```

### Bot Setup

1. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

2. **Configure the Bot**
   Edit `config/config.py`:
   ```python
   # Database configuration
   DB_CONFIG = {
       'host': 'localhost',
       'user': 'ragnarok',     # Your database user
       'password': 'ragnarok', # Your database password
       'database': 'ragnarok'  # Your database name
   }

   # Discord configuration
   DISCORD_TOKEN = 'your_discord_bot_token'  # Your bot token
   COMMAND_PREFIX = '!'
   ```

3. **Run the Bot**
   ```bash
   python bot.py
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
