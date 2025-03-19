# Bowling Bash Pre-Renewal Configuration

This configuration guide provides details on adjusting the area of effect for the Bowling Bash skill in pre-renewal mode on the `rAthena` server. This setting allows you to control the size of the area affected by the Bowling Bash chain reaction.

## Configuration Option

### Bowling Bash Area
- **File**: `rathena/conf/import/skill.conf`
- **Setting**: `bowling_bash_area`
- **Description**:
```
  Area of Bowling Bash chain reaction (pre-renewal only)
  0: Use official gutter line system
  1: Gutter line system without demi gutter bug
  2-20: Area around caster (2 = 5x5, 3 = 7x7, 4 = 9x9, ..., 20 = 41x41)
  Note: If you knock the target out of the area it will only be hit once and won't do splash damage
```
- add this line : 
`bowling_bash_area: 1`
