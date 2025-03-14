# Break Songs on Weapon Switch Configuration

This configuration guide provides details on adjusting the behavior of songs when switching weapons in the `rAthena` server. This setting allows you to control whether songs are canceled when a player switches weapons.

## Configuration Option

### Dancing Weapon Switch Fix
- **File**: `rathena/conf/battle/skill.conf`
- **Setting**: `dancing_weaponswitch_fix`
- **Description**: This setting determines whether the switching of weapons cancels songs. On official servers, a fix is in place to prevent this behavior. The default value is `yes`, which means the fix is applied. Setting this to `no` will allow songs to be canceled when weapons are switched.