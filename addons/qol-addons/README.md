# Quality of Life Addons

A collection of improvements to make your RO-Journey server more player-friendly.

## Quick Start

1. **Installation**
   - Copy the addon files to your server
   - Apply the patches
   - Add scripts to your server configuration
   - Recompile your server

2. **Usage**
   - Most features work automatically
   - Use `@autofeed` for pet feeding
   - Use `@ws` and `@wb` for vendors
   - No additional configuration needed

## Available Features

### Pet System Improvements
- **Autofeed**: Type `@autofeed` to automatically feed your pets and homunculus
- **Better Pet Growth**: 
  - Pets get closer to you 2x faster
  - Pets get hungry 2x slower

### Character Improvements
- **More Inventory Space**: Carry up to 70% of your max weight (was 50%)
- **Better Resting**: Recover 1% HP/SP per second while sitting
- **Faster Skills**: No waiting for skill animations
- **Improved Food Buffs**: 
  - Food buffs last 30 minutes
  - Buffs persist through death
- **Better Endow**: 
  - Assassins can switch off-hand weapons without losing endow
  - Endow only removed on right-hand weapon swap

### Gameplay Improvements
- **Easy Job Selection**: Direct job selection menu for new characters
- **Safe Card Removal**: Remove cards without risk of destruction
- **Better Buffs**: AoE versions of Bless and Agi for priests
- **Same-Sex Marriage**: Marry any character regardless of gender
- **MVP Tombstones**: 
  - Shows who killed the MVP and when
  - Tombs spawn where the MVP died
  - Currently works for Baphomet, Dark Lord, and Golden Bug

### Trading Improvements
- **Quick Vendors**: Use `@ws` to sell and `@wb` to buy items
- **HD Ore Exchange**: Exchange regular ores for HD ores in Prontera
- **Better Party EXP**: Increased experience rates for party play:
  - 1 member: 100% EXP
  - 2 members: 150% EXP (75% each)
  - 3 members: 200% EXP (66.7% each)
  - 4 members: 250% EXP (62.5% each)
  - 5 members: 300% EXP (60% each)
  - 6 members: 350% EXP (58.34% each)
  - 7 members: 400% EXP (57.14% each)
  - 8 members: 450% EXP (56.25% each)
  - 9 members: 500% EXP (55.55% each)
  - 10 members: 550% EXP (55% each)
  - 11 members: 600% EXP (54.54% each)
  - 12 members: 650% EXP (54.17% each)

## Installation Guide

1. **Server Files**
   ```bash
   # Apply patches
   patch battle.c < overweight.patch
   patch pet.c < pet_rates.patch
   patch battle.c < party_exp.patch
   patch battle.c < mvp_tomb.patch
   patch battle.c < food_buffs.patch
   patch battle.c < endow.patch
   ```

2. **Scripts**
   ```conf
   # Add to scripts_custom.conf
   npc: npc/custom/autofeed.txt
   npc: npc/custom/vendors.txt
   npc: npc/custom/hd_ore.txt
   ```

3. **Database**
   - Run any SQL files in the addon's directory
   - Restart your server

## Requirements
- rAthena server
- MySQL/MariaDB database

## Need Help?
1. Check the addon's README for specific instructions
2. Look for error messages in your server logs
3. Make sure all files are in the correct locations
4. Verify database changes were applied

## Adding New Features
Want to add your own improvements?
1. Create a new folder for your addon
2. Include a README with clear instructions
3. Add any necessary SQL files
4. Submit your changes

## License
MIT License - Feel free to use and modify these addons. 