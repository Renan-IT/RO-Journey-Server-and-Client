# WhoSell and Buy Commands

A Quality of Life addon that adds convenient commands to find items in player vending shops across the game.

## Features

- **WhoSell Command**
  - Search for items across all player vending shops
  - Shows which players are selling specific items
  - Displays item prices and shop locations
  - Supports partial item name matching
  - Case-insensitive search
  - Real-time shop information

- **WhoBuy Command**
  - Search for items across all buying stores
  - Shows which players are buying specific items
  - Displays offered prices and locations
  - Supports partial item name matching
  - Case-insensitive search
  - Real-time shop information

## Installation

1. Copy the script file:
   ```bash
   cp whosell-buy-commands.txt /path/to/rathena/npc/custom/
   ```

2. Add to your `conf/import/npc.conf`:
   ```conf
   npc: npc/custom/whosell-buy-commands.txt
   ```

3. Restart your server

## Usage

- To find who sells an item:
  ```
  @whosell <item_name>
  ```
  Example: `@whosell +7 Muramasa [2]`

- To find who buys an item:
  ```
  @whobuy <item_name>
  ```
  Example: `@whobuy \"Wing of Butterfly\"`

## Technical Details

- Scans all active player vending shops
- Real-time price and stock information
- Maintains normal vending restrictions
- Respects item trading restrictions
- Updates dynamically as shops open/close
- Works with all vendable items

## Benefits

- **For Players**
  - Easy price comparison across all vendors
  - Save time finding specific items
  - No more searching through multiple maps
  - Quick access to rare items
  - Efficient market research

- **For Sellers**
  - Increased shop visibility
  - Better item exposure
  - More potential customers
  - Maintains normal vending mechanics

## Configuration

Edit `whosell-buy-commands.txt` to customize:
- Command aliases
- Search parameters
- Display format
- Result sorting (by price, quantity, etc.)

## Requirements

- rAthena server
- Basic scripting support
- Command manager system
- Merchant vending system enabled

## Compatibility

- Works with all vendable items
- Compatible with modified vending systems
- No conflicts with other shop systems
- Works alongside other QoL improvements
- Supports custom item types

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 