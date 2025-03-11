# Enhanced Pet System

A Quality of Life addon that improves pet mechanics by adjusting growth and hunger rates for a better pet ownership experience.

## Features

- **Improved Pet Growth**
  - Pets get closer to you 2x faster
  - More rapid intimacy gain
  - Quicker loyalty development
  - Faster pet evolution progress

- **Better Hunger Management**
  - Pets get hungry 2x slower
  - Reduced feeding frequency
  - More efficient food usage
  - Less maintenance required

## Installation

1. Apply the patch to your server:
   ```bash
   patch pet.c < improved-pet-intimacy.patch
   ```

2. Recompile your server and restart

## Technical Details

- Modifies pet intimacy gain rates in pet.c
- Adjusts hunger decrease timers
- Changes apply to all pet types
- No performance impact on server
- Maintains pet system balance

## Benefits

- **For Pet Owners**
  - Less time spent on pet maintenance
  - Faster pet training results
  - More enjoyable pet system
  - Reduced food costs

- **For Server**
  - More active pet usage
  - Better pet system engagement
  - Balanced quality of life improvement
  - Enhanced player satisfaction

## Configuration

Default modifications:
- Intimacy gain rate: 2x faster
- Hunger decrease rate: 2x slower

These values can be adjusted by:
1. Editing the patch file
2. Changing the multipliers
3. Reapplying the patch

## Requirements

- rAthena server
- Server compiled with the pet rates patch

## Compatibility

- Works with all pet types
- Compatible with custom pets
- No conflicts with other pet systems
- Works alongside autofeed system

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 