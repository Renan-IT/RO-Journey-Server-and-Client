# Enhanced Mass Brewing System

This addon improves the mass brewing system for Alchemists by adding a selection menu and configurable success rates for different potions.

## Features

- Selection menu for different mass brewing skills (AM_TWILIGHT1, AM_TWILIGHT2, AM_TWILIGHT3)
- Configurable success rates for each potion type
- Automatic quantity setting (200 items per successful brew)
- Skill level bonus for success rates

## Available Potions

### AM_TWILIGHT1
- White Potion
- Blue Potion

### AM_TWILIGHT2
- Condensed White Potion
- Acid Bottle
- Bottle Grenade

### AM_TWILIGHT3
- Alcohol
- Glistening Coat

## Success Rates

Success rates can be configured in `battle_config` for each potion type:
- `mass_brew_white_potion_rate`
- `mass_brew_blue_potion_rate`
- `mass_brew_slim_white_potion_rate`
- `mass_brew_acid_bottle_rate`
- `mass_brew_bottle_grenade_rate`
- `mass_brew_alcohol_rate`
- `mass_brew_glistening_coat_rate`

Additional bonus: +5% success rate per Pharmacy skill level above 10.

## Installation

1. Apply the patch file:
```bash
patch -p1 < addons/qol-addons/enhanced-mass-brew/enhanced-mass-brew.patch
```

2. Recompile your server

## Notes

- The success rates are capped between 1% and 100%
- Each successful brew produces 200 items
- Failed attempts will display a skill failure message

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
