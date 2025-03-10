# Same-Sex Marriage

This addon enables marriage between characters of the same gender, promoting inclusivity in the game.

## Features

- Marriage between characters of any gender
- Maintains all existing marriage benefits
- Updated marriage ceremony dialogue
- Preserves marriage system mechanics

## Installation

1. Copy the script file:
   ```bash
   cp marriage.txt /path/to/rathena/npc/custom/
   ```

2. Add to your `conf/import/npc.conf`:
   ```conf
   npc: npc/custom/marriage.txt
   ```

3. Apply the SQL changes:
   ```bash
   mysql -u YOUR_DATABASE_USER -p YOUR_DATABASE_NAME < marriage.sql
   ```

4. Restart your server

## Configuration

Edit `marriage.txt` to customize:
- Marriage requirements
- Ceremony costs
- Marriage benefits
- Dialogue text

## Requirements

- rAthena server
- Level 30+ characters
- 50,000 zeny per character
- Wedding Ring (x2)

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 