# Enhanced Weapon Endow System

A Quality of Life addon that improves the weapon endow mechanics for a better gameplay experience.

## Features

- **Improved Off-hand Weapon Handling**
  - Assassins can switch off-hand weapons without losing their endow effect
  - Preserves the endow effect on dual-wielding setups
  
- **Selective Endow Removal**
  - Endow effects are only removed when switching right-hand (main) weapons
  - Left-hand (off-hand) weapon changes do not affect endow status
  - Maintains balance while improving quality of life

## Installation

1. Apply the patch to your server:
   ```bash
   patch battle.c < improved-endow.patch
   ```

2. Recompile your server and restart

## Technical Details

- Modifies the weapon endow check system in battle.c
- Only triggers endow removal on main-hand weapon changes
- Preserves endow status during off-hand equipment changes
- Compatible with all weapon types and endow skills
- No performance impact on server

## Benefits

- **For Assassins**
  - Freely switch katar/dagger in off-hand
  - Maintain endow effects while optimizing equipment
  - Improved dual-wielding experience

- **For All Classes**
  - More reliable weapon endow system
  - Reduced frustration from accidental endow removal
  - Better equipment management

## Requirements

- rAthena server
- Server compiled with the endow patch

## Compatibility

- Works with all standard weapon endow skills
- Compatible with custom endow systems
- No conflicts with other weapon-related modifications

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 