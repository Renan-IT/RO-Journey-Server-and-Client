# HD Ore Exchange System

A Quality of Life addon that adds an NPC in Prontera allowing players to exchange regular ores for their HD (High-Density) variants.

## Features

- **Convenient Exchange Location**
  - NPC located in Prontera
  - Easy access for all players
  - Clear interface for ore exchanges

- **Supported Ore Types**
  - Oridecon → HD Oridecon
  - Elunium → HD Elunium
  - All standard refinement ores

- **Fair Exchange Rates**
  - Standard conversion rates
  - No additional fees
  - Bulk exchange options

## Installation

1. Copy the NPC script to your server:
   ```bash
   cp hd_ore.txt /path/to/rathena/npc/custom/
   ```

2. Add to your `conf/import/npc.conf`:
   ```conf
   npc: npc/custom/hd_ore.txt
   ```

3. Restart your server or reload scripts

## Technical Details

- Adds a new NPC to Prontera
- Uses standard item IDs for ores
- Simple menu-based interface
- Automatic item verification
- Secure exchange process

## Benefits

- **For Players**
  - Save time traveling between cities
  - Convenient ore management
  - Simplified refinement preparation
  - Reduced inventory management

- **For Server**
  - No economy impact
  - Uses existing game mechanics
  - Maintains item value balance
  - Improves player experience

## Configuration

The following can be customized in the script:
- NPC location
- Exchange rates
- Bulk exchange limits

## Requirements

- rAthena server
- Standard refinement ores in your item database
- HD ores in your item database

## Compatibility

- Works with all standard refinement ores
- Compatible with custom ore types
- No conflicts with other NPCs or systems
- Works alongside other refining systems

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 