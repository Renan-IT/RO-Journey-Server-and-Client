# Break Songs on Weapon Switch Configuration

This configuration guide provides details on adjusting the behavior of songs when switching weapons in the `rAthena` server. This setting allows you to control whether songs are canceled when a player switches weapons.

## Configuration Option

### Dancing Weapon Switch Fix
- **File**: `rathena/conf/battle/skill.conf`
- **Setting**: `dancing_weaponswitch_fix`
- **Description**:
```
  Dancing Weapon Switch
  On official servers, a fix is in place that prevents the switching of weapons to cancel songs.
  Default: yes
```
add this line :
`dancing_weaponswitch_fix: no`
