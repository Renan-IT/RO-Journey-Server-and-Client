# MVP Tomb System

A Quality of Life addon that creates visible tombstones at MVP kill locations with detailed kill information.

## Features

- **MVP Kill Markers**
  - Spawns a visible tombstone at the exact location where MVP died
  - Shows the name of the player who defeated the MVP
  - Displays the time when the MVP was killed
  - Helps track MVP respawn times

- **Supported MVPs and Respawn Times**
  - Amon Ra (gld_dun03) - 60~70 minutes
  - Atroce (ra_fild03, ra_fild04, ve_fild01, ve_fild02) - 240~250 minutes
  - Baphomet (prt_maze03) - 120~130 minutes
  - Beelzebub (abbey03) - 720~730 minutes
  - Dark Lord (gl_chyard) - 60~70 minutes
  - Doppelganger (gef_dun02) - 120~130 minutes
  - Dracula (gef_dun01) - 60~70 minutes
  - Drake (treasure02) - 120~130 minutes
  - Eddga (pay_fild11) - 120~130 minutes
  - Evil Snake Lord (gon_dun03) - 94~104 minutes
  - Fallen Bishop (abbey02) - 120~130 minutes
  - Garm (xmas_fild01) - 120~130 minutes
  - Golden Thief Bug (prt_sewb4) - 60~70 minutes
  - Gopinich (mosk_dun03) - 120~130 minutes
  - Stormy Knight (xmas_dun02) - 60~70 minutes
  - Turtle General (tur_dun04) - 60~70 minutes
  - Kiel D-01 (kh_dun02) - 120~130 minutes
  - Lord of Death (niflheim) - 133~143 minutes
  - Maya (ant_hell02) - 120~130 minutes
  - Mistress (mjolnir_04) - 120~130 minutes
  - Moonlight Flower (pay_dun04) - 60~70 minutes
  - Orc Hero (gef_fild03) - 60~70 minutes
  - Orc Lord (gef_fild10) - 120~130 minutes
  - Osiris (moc_pryd04) - 60~70 minutes
  - Pharaoh (in_sphinx5) - 60~70 minutes
  - Phreeoni (moc_fild17) - 120~130 minutes
  - RSX-0806 (ein_dun02) - 125~135 minutes
  - Tao Gunka (beach_dun) - 300~310 minutes
  - Thanatos (than_dun2) - 120~130 minutes
  - Vesper (jupe_core) - 120~130 minutes

- **Information Display**
  - Clear and visible tombstone sprite
  - Clickable for detailed information
  - Shows time remaining until respawn
  - Displays killer's name and class
  - Shows exact spawn map location

## Installation

1. Apply the patch to your server:
   ```bash
   patch battle.c < mvp-tombstone.patch
   ```

2. Recompile your server and restart

## Technical Details

- Modifies MVP death handling in battle.c
- Creates temporary NPC objects for tombstones
- Automatically removes tombstones when MVP respawns
- Minimal server resource usage
- Uses existing game assets

## Benefits

- **For MVP Hunters**
  - Easy tracking of MVP kills
  - Accurate respawn time management
  - Clear visual indicators
  - Historical kill information
  - Complete coverage of all natural MVP spawns

- **For Server**
  - Improved MVP hunting experience
  - Better community engagement
  - No performance impact
  - Enhanced gameplay feedback

## Configuration

The following can be configured in the patch:
- Custom MVP additions
- Tombstone duration
- Display format
- Information shown

## Requirements

- rAthena server
- Server compiled with the MVP tomb patch

## Compatibility

- Works with all standard MVPs
- Compatible with custom MVP monsters
- No conflicts with other MVP systems
- Works alongside other MVP-related modifications

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 