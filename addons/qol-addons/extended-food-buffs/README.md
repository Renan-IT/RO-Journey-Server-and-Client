# Enhanced Food Buffs System

A Quality of Life addon that improves the food buff system by extending duration and maintaining buffs through death.

## Features

- **Extended Duration**
  - Food buff effects last for 30 minutes
  - Significantly longer than vanilla duration
  - Reduces the need for frequent rebuffing

- **Death Persistence**
  - Food buffs remain active after character death
  - No need to reapply buffs after dying
  - Saves time and resources

## Installation

1. Apply the patch to your server:
   ```bash
   patch battle.c < extended-food-buffs.patch
   ```

2. Recompile your server and restart

## Technical Details

- Modifies the food buff duration system in battle.c
- Changes buff persistence behavior on death
- Affects all food-type consumables
- No performance impact on server
- Maintains game balance while improving convenience

## Benefits

- **Quality of Life**
  - Less time spent rebuffing
  - Reduced food item consumption
  - More time for actual gameplay

- **Resource Efficiency**
  - Lower food item costs
  - Fewer inventory slots needed for food
  - More economical for players

## Requirements

- rAthena server
- Server compiled with the food buffs patch

## Compatibility

- Works with all standard food items
- Compatible with custom food items
- No conflicts with other buff-related modifications
- Works alongside other QoL improvements

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 