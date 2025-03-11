# Enhanced Weight Capacity System

A Quality of Life addon that increases the maximum weight capacity from 50% to 70%, allowing players to carry more items before becoming overweight.

## Features

- **Increased Weight Limit**
  - Maximum weight capacity increased to 70% (up from 50%)
  - Allows carrying more items before movement speed penalty
  - Maintains game balance while improving convenience

- **Benefits**
  - More inventory space for looting
  - Fewer trips to storage
  - Better farming efficiency
  - Improved quality of life for all classes

## Installation

1. Apply the patch to your server:
   ```bash
   patch battle.c < increased-weight-limit.patch
   ```

2. Recompile your server and restart

## Technical Details

- Modifies the weight penalty threshold in battle.c
- Changes only affect the overweight movement penalty
- Does not affect other weight-based mechanics
- No performance impact on server
- Simple and clean implementation

## Configuration

The weight limit is hardcoded to 70%. If you want to change this value:
1. Edit the patch file
2. Change the value in the `status_calc_weight()` function
3. Reapply the patch and recompile

## Requirements

- rAthena server
- Server compiled with the overweight patch

## Compatibility

- Works with all character classes
- Compatible with custom items
- No conflicts with other weight-related systems
- Works alongside other QoL improvements

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 