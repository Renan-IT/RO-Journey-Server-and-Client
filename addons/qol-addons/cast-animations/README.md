# Cast Animations Removed

This addon removes cast animations from various skills to improve party play experience and reduce interruptions.

## Features

- Removes cast animations from:
  - High Priest AoE buffs
  - Wind Walk
  - Other party support skills
- Improves party play experience
- Reduces skill casting interruptions
- Maintains skill effects and benefits

## Installation

1. Apply the battle system patch:
   ```bash
   cd /path/to/rathena
   patch -p1 < addons/qol-addons/cast-animations/battle.patch
   ```

2. Recompile the server:
   ```bash
   make clean
   make server
   ```

3. Restart your server

## Configuration

Edit `battle.patch` to customize:
- Which skills have animations removed
- Animation removal conditions
- Party-only restrictions

## Requirements

- rAthena server
- Server recompilation
- Proper permissions for file modifications

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 