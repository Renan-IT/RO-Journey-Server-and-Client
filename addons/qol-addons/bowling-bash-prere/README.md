# Bowling Bash Pre-Renewal Configuration

This configuration guide provides details on adjusting the area of effect for the Bowling Bash skill in pre-renewal mode on the `rAthena` server. This setting allows you to control the size of the area affected by the Bowling Bash chain reaction.

## Configuration Option

### Bowling Bash Area
- **File**: `rathena/conf/import/skill.conf`
- **Setting**: `bowling_bash_area`
- **Description**: This setting determines the area of effect for the Bowling Bash chain reaction. The default value is `1`, which uses the gutter line system without the demi gutter bug. You can set this value between `2` and `20` to define the area around the caster, where `2` represents a 5x5 area, `3` a 7x7 area, and so on, up to `20` for a 41x41 area. Note that if you knock the target out of the area, it will only be hit once and won't do splash damage.

- add this line : 
`bowling_bash_area: 0`
