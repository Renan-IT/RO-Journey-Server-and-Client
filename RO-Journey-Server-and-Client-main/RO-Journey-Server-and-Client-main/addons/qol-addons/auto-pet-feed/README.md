# Autofeed System

A Quality of Life addon that automatically feeds your pets and homunculus when they're hungry.

## Features

- Automatic feeding of pets when hunger level exceeds 80%
- Automatic feeding of homunculus when hunger level exceeds 80%
- Simple toggle command (`@autofeed`) to enable/disable the system
- Checks hunger levels every 30 seconds
- Uses the correct food type automatically
- Works with all pet types
- No manual configuration needed

## Installation

1. Copy `auto-pet-feed.txt` to your `npc/custom/` directory
2. Add the following line to your `scripts_custom.conf`:
   ```conf
   npc: npc/custom/auto-pet-feed.txt
   ```
3. Restart your server or reload scripts

## Usage

1. In game, type `@autofeed` to toggle the system on/off
2. When enabled, you'll see a message: "Autofeed enabled. Your pets and homunculus will be fed automatically when hungry."
3. When disabled, you'll see a message: "Autofeed disabled."

## Technical Details

- Script checks pet and homunculus hunger levels every 30 seconds
- Uses built-in rAthena functions for feeding
- Automatically selects appropriate food items from inventory
- Minimal server resource usage
- Permission level: Available to all players (level 0-99)

## Requirements

- rAthena server
- Appropriate food items in player inventory
- Pet or homunculus must be active

## Troubleshooting

If autofeed isn't working:
1. Make sure you have the correct food items in your inventory
2. Verify that your pet/homunculus is active
3. Check if the system is enabled using `@autofeed`
4. Look for any error messages in your server logs

## License

This addon is part of the RO-Journey QoL improvements collection.
MIT License - Feel free to use and modify. 