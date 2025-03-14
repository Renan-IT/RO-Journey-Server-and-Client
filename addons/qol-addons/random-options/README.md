# Random Options System

A Quality of Life addon that implements a comprehensive random options system for equipment. This system adds random additional effects to gear when obtained from monsters, boxes, or through specific game mechanics.

## Features

### Core Mechanics
- 2-3 random options per gear piece
- Uses default item drop rates
- Options displayed between item window and card information

### Option Categories

#### Armor/Garment/Shoes Options
- Stats (STR, AGI, VIT, INT, DEX, LUK)
- Defensive (DEF, MDEF, HP, SP)
- Resistances (Elements, Status Effects)
- Combat (Perfect Dodge, Critical, Hit, Flee)
- Race/Size Resistance

#### Weapon Options
- Base Stats Enhancement
- Attack/MATK Bonuses
- Speed Modifiers (ASPD, Cast Time)
- Damage Modifiers (by size, race, element)
- Special Effects (SP Cost, Critical)

## Installation

1. Apply the patches:
   ```bash
   patch src/map/itemdb.c < random-options-core.patch
   patch src/map/mob.c < random-options-drop.patch
   ```

2. Copy the option database:
   ```bash
   cp db/random_options.yml path/to/db/
   ```

3. Recompile and restart server

## Technical Details

### Option Rolling System
1. Option types rolled first (equal chance)
2. Option values rolled second (equal chance within range)
3. Different options available for weapons and armor

### Drop System
- Uses default item drop rates
- Applies to eligible equipment types
- Consistent option ranges for all drops

### Equipment Categories
- Armor: Defense-focused options
- Weapons: Damage and utility options

## Benefits

- **For Players**
  - More diverse equipment choices
  - Enhanced customization
  - Rewarding farming system
  - Natural progression through content

- **For Server**
  - Deeper item system
  - Enhanced player engagement
  - Maintains existing drop rates
  - Simple and balanced system

## Requirements

- rAthena server
- Server compiled with random options patches
- Updated item database

## Compatibility

- Works with all equipment types
- Compatible with existing systems
- No conflicts with other features

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 