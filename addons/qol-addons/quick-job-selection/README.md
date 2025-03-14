# Job Change Teleporter

This addon provides a convenient teleportation service to help new players reach their desired job change locations quickly and easily.

## Features

- Friendly NPC interface for selecting desired job
- Teleports players to the correct city for their job change
- Supports all first job changes:
  - Swordsman (Izlude)
  - Mage (Geffen)
  - Archer (Payon)
  - Merchant (Alberta)
  - Thief (Morroc)
  - Acolyte (Prontera Church)
  - Gunslinger (Einbroch)
  - TaeKwon (Comodo)
  - Ninja (Amatsu)
  - Super Novice (Izlude)
- Maintains level requirements
- Preserves existing job change quest requirements

## Installation

1. Copy the script file:
   ```bash
   cp job_selection.txt /path/to/rathena/npc/custom/
   ```

2. Add to your `conf/import/npc.conf`:
   ```conf
   npc: npc/custom/job_selection.txt
   ```

3. Restart your server

## Configuration

Edit `job_selection.txt` to customize:
- Required level for teleportation
- Available job destinations
- Teleport costs (if any)
- Additional requirements or restrictions

## Requirements

- rAthena server
- Level 10+ Novice
- Base level requirements for each job
- Players must still complete the job change quests at their destinations

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 