# No MVP Map Memo

A Quality of Life addon that prevents the use of /memo command on MVP maps to maintain fair competition and prevent camping.

## Features

- **MVP Map Protection**
  - Blocks /memo command on all MVP spawn maps
  - Prevents unfair MVP camping
  - Maintains competitive MVP hunting
  - Includes all standard MVP maps

- **Protected Maps**
  - gld_dun03 (Amon Ra)
  - abbey02 (Fallen Bishop)
  - abbey03 (Beelzebub)
  - thor_v03 (Storm Knight)
  - moc_pryd04 (Osiris)
  - moc_fild17 (Phreeoni)
  - prt_maze03 (Baphomet)
  - gef_dun02 (Doppelganger)
  - treasure02 (Drake)
  - pay_fild11 (Eddga)
  - xmas_fild01 (Garm)
  - prt_sewb4 (Golden Thief Bug)
  - mosk_dun03 (Gopinich)
  - kh_dun02 (Kiel D-01)
  - ant_hell02 (Maya)
  - mjolnir_04 (Mistress)
  - pay_dun04 (Moonlight Flower)
  - gef_fild03 (Orc Hero)
  - gef_fild10 (Orc Lord)
  - in_sphinx5 (Pharaoh)
  - beach_dun (Tao Gunka)
  - than_dun2 (Thanatos)
  - jupe_core (Vesper)

## Installation

1. Apply the patch to your server:
   ```bash
   patch skill.c < no-mvp-memo.patch
   ```

2. Recompile your server and restart

## Technical Details

- Modifies the memo skill check in skill.c
- Adds MVP map verification
- Only affects the /memo command
- No impact on other teleportation methods
- Simple and efficient implementation

## Benefits

- **For MVP Hunters**
  - Fair competition for MVPs
  - No unfair advantages
  - More dynamic hunting experience
  - Rewards active searching

- **For Server**
  - Better MVP hunting balance
  - Reduced MVP camping
  - More active community
  - Enhanced gameplay fairness

## Requirements

- rAthena server
- Server compiled with the MVP memo patch

## Compatibility

- Works with all MVP systems
- Compatible with custom MVP maps
- No conflicts with other teleport systems
- Works alongside other QoL improvements

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 