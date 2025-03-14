# Reduced Wedding Costume Effect

A Quality of Life addon that reduces the wedding costume effect duration from 1 hour to 5 minutes for better convenience.

## Features

- **Shorter Effect Duration**
  - Reduces wedding costume effect from 60 minutes to 5 minutes
  - Maintains all visual effects and mechanics
  - Less waiting time after marriage ceremony
  - Same functionality with shorter duration

## Installation

1. Apply the patch to your server:
   ```bash
   patch status.c < reduced-wedding-effect.patch
   ```

2. Recompile your server and restart

## Technical Details

- Modifies the wedding costume status duration in status.c
- Only affects the costume effect duration
- Does not modify any other wedding-related features
- No performance impact on server
- Simple and clean implementation

## Benefits

- **For Players**
  - Less waiting time after marriage
  - Quicker return to normal gameplay
  - Same marriage experience
  - No functionality loss

- **For Server**
  - Maintains wedding system integrity
  - No impact on other features
  - Better player experience
  - Reduced status effect management

## Requirements

- rAthena server
- Server compiled with the wedding effect patch

## Compatibility

- Works with all wedding systems
- Compatible with custom marriage features
- No conflicts with other status effects
- Works alongside other QoL improvements

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 