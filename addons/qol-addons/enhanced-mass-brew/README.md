# Enhanced Mass Brew

A Quality of Life addon that enhances the Alchemist's Twilight Pharmacy skill by adding more craftable items to the mass production system.

## Features

### New Mass Production Items
- **Blue Potions**
  - Heal SP recovery
  - Essential for long battles
  - Perfect for party support

- **Acid Bottles**
  - Key ingredient for acid demonstrations
  - Useful for PvP/WoE
  - Efficient mass production

- **Bottle Grenades**
  - Powerful offensive item
  - Great for crowd control
  - Cost-effective production

- **Glistening Coats**
  - Essential for advanced potions
  - Improved production rate
  - Resource efficient

### Benefits
- Faster production of essential items
- More efficient use of materials
- Reduced production costs
- Enhanced Alchemist utility

## Installation

1. Apply the patch to your server:
   ```bash
   patch src/map/skill.c < enhanced-mass-brew.patch
   ```

2. Add the following to your `conf/battle/skill.conf`:
   ```conf
   // Enhanced Mass Brew Settings
   mass_brew_blue_potion_rate: 100
   mass_brew_acid_bottle_rate: 100
   mass_brew_bottle_grenade_rate: 100
   mass_brew_glistening_coat_rate: 100
   ```

3. Recompile your server and restart

## Technical Details

### Production Rates
- Blue Potion: 100% base success rate
- Acid Bottle: 100% base success rate
- Bottle Grenade: 100% base success rate
- Glistening Coat: 100% base success rate

### Material Requirements
- **Blue Potion**
  - 1 Empty Bottle
  - 1 Crystal Blue
  - 1 Scell

- **Acid Bottle**
  - 1 Empty Bottle
  - 1 Acid Poison
  - 1 Poison Spore

- **Bottle Grenade**
  - 1 Empty Bottle
  - 1 Oil
  - 1 Drosera Tentacle

- **Glistening Coat**
  - 1 Empty Bottle
  - 1 Coating Poison
  - 1 Poison Toad Skin

## Benefits

- **For Alchemists**
  - More efficient item production
  - Expanded crafting options
  - Better resource management
  - Enhanced utility role

- **For Parties**
  - Better access to consumables
  - More strategic options
  - Improved support capabilities
  - Cost-effective item supply

## Requirements

- rAthena server
- Server compiled with enhanced mass brew patch
- Alchemist class with Twilight Pharmacy skill

## Compatibility

- Works with all Alchemist skills
- Compatible with existing crafting systems
- No conflicts with other class features
- Works alongside other QoL improvements

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 