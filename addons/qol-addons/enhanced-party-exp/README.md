# Enhanced Party Experience System

A Quality of Life addon that increases experience rates for party play, encouraging group activities and cooperation.

## Features

- **Progressive Party Bonus**
  - Experience rates increase with party size
  - Fair distribution among party members
  - Encourages group play and socialization

- **Experience Rates**
  - 1 member: 100% EXP (base rate)
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

## Installation

1. Apply the patch to your server:
   ```bash
   patch battle.c < enhanced-party-exp.patch
   ```

2. Recompile your server and restart

## Technical Details

- Modifies party experience calculation in battle.c
- Scales total experience based on party size
- Maintains fair distribution among members
- No performance impact on server
- Automatic calculation for all party sizes

## Benefits

- **For Players**
  - Better rewards for group play
  - Encourages social interaction
  - Makes party leveling viable
  - Supports different party sizes

- **For Server**
  - Promotes community building
  - Balances solo vs party play
  - Encourages map exploration
  - Supports various playstyles

## Requirements

- rAthena server
- Server compiled with the party exp patch

## Compatibility

- Works with all experience sources
- Compatible with custom exp rates
- No conflicts with other exp modifiers
- Works alongside other party systems

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 