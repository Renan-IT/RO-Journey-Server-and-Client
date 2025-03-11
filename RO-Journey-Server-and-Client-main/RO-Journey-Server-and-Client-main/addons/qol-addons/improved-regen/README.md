# Increased Sitting HP/SP Regen

This addon improves HP and SP regeneration while sitting, making it more efficient and convenient.

## Features

- 1% HP regeneration per second while sitting
- 1% SP regeneration per second while sitting
- Works with all character classes
- Maintains existing regen bonuses
- Compatible with other regen modifiers

## Installation

1. Apply the battle system patch:
   ```bash
   cd /path/to/rathena
   patch -p1 < addons/qol-addons/improved-regen/improved-regen.patch
   ```

2. Recompile the server:
   ```bash
   make clean
   make server
   ```

3. Restart your server

## Configuration

Edit `improved-regen.patch` to customize:
- Regeneration rates
- Sitting conditions
- Class-specific modifiers
- Additional requirements

## Requirements

- rAthena server
- Server recompilation
- Proper permissions for file modifications

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 