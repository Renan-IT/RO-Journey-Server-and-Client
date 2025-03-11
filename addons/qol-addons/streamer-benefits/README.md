# Streamer Benefits System

A Quality of Life addon that implements special features and benefits for streamers to enhance their streaming experience and engage with their viewers.

## Features

### Streamer Management
- Admin-only NPC to register/remove streamer status
- Account-based streamer flag system
- Easy management interface

### Streamer Benefits
- Starter Pack for new streamers:
  - 10x Battle Manual
  - 10x Bubble Gum
  - 10x Old Card Album
  - 500k Zeny
- Automatic Redeem Code System:
  - Codes appear randomly every 15-30 minutes
  - Codes display on streamer's screen
  - Visual effects to notify streamer of new codes
  - Customizable prize amounts
  - Codes remain active until claimed
- Server-wide Bonuses when online:
  - +25% Experience Rate
  - +25% Drop Rate
  - Automatic announcement system

## Installation

1. Copy the `npc` folder to your `npc` directory
2. Add these lines to your `npc-custom.conf`:
   ```conf
   npc: npc/custom/streamer-benefits/streamer_manager.txt
   npc: npc/custom/streamer-benefits/streamer_benefits.txt
   npc: npc/custom/streamer-benefits/redeem_code.txt
   npc: npc/custom/streamer-benefits/streamer_bonus.txt
   ```
3. Restart your server

## Usage

### For Administrators
1. Talk to the Streamer Manager NPC in Prontera (155,185)
2. Use the interface to register or remove streamer accounts
3. Enter the account ID of the streamer

### For Streamers
1. Talk to the Streamer Benefits NPC in Prontera (153,185)
2. Claim your starter pack (one-time)
3. Enable automatic code generation
4. Set your preferred prize amount
5. Watch for codes appearing on your screen
6. Your online presence automatically activates bonus rates

### For Players
1. Watch streamer's broadcast for redeem codes
2. Be the first to claim the code at the Redeem Code NPC
3. Enjoy bonus rates when streamers are online

## Technical Details

### Account Flags
- Uses account registry to store streamer status
- Flag: `#STREAMER` (1 = active, 0 = inactive)

### Redeem Code System
- Automatic generation every 15-30 minutes
- 6-character alphanumeric codes
- Visual notification system for streamers
- One-time use codes
- Configurable prize amounts (1,000 to 1,000,000 zeny)

### Rate Bonuses
- Automatically managed through battleflags
- Stacks with server's base rates
- Reverts when streamer logs out

## Support

For issues or suggestions, please create an issue in the repository. 