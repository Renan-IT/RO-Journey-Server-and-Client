# Break Songs on Weapon Switch

A Quality of Life addon that automatically cancels songs and dances when Bards, Dancers, Clowns, or Gypsies switch their weapons. This prevents potential exploits and ensures more balanced gameplay.

## Features

- **Automatic Song/Dance Cancellation**
  - Songs and dances are cancelled when switching weapons
  - Affects Bards, Dancers, Clowns, and Gypsies
  - Prevents exploits involving weapon switching while maintaining songs
  - Makes gameplay more balanced and fair

## Installation

1. Apply the patch to your server:
   ```bash
   patch src/map/status.c < break-songs-on-weapon.patch
   ```

2. Recompile your server and restart

## Technical Details

- Modifies the status change system
- Checks for weapon changes on these specific classes
- Automatically cancels active songs/dances
- Clean and efficient implementation

## Benefits

- **For Players**
  - More balanced gameplay
  - Clear and consistent mechanics
  - No more weapon switching exploits
  - Fair competition in PvP/WoE

- **For Server**
  - Better game balance
  - Reduced exploit potential
  - Clearer gameplay mechanics
  - Enhanced competitive integrity

## Requirements

- rAthena server
- Server compiled with the break songs patch

## Compatibility

- Works with all song/dance systems
- Compatible with custom classes based on Bard/Dancer
- No conflicts with other skill systems
- Works alongside other QoL improvements

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 