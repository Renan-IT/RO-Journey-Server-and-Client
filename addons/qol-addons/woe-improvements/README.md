# WoE Improvements

A Quality of Life addon that enhances War of Emperium (WoE) gameplay by adding a convenient warper NPC and implementing castle member limits for better balance.

## Features

### WoE Warper NPC
- Quick access to all WoE castles
- Available only during WoE times
- Configurable access restrictions
- Clear castle status information

### Castle Member Limit System
- Configurable maximum number of guild members per castle
- Prevents overcrowding in castles
- Auto-kicks excess members when limit is reached
- Prioritizes guild leadership/officers

## Installation

1. Copy the NPC script to your `npc/custom/` directory:
   ```bash
   cp woe-warper.txt path/to/npc/custom/
   ```

2. Apply the castle limit patch:
   ```bash
   patch src/map/guild.c < castle-limit.patch
   ```

3. Add the following to your `conf/battle/guild.conf`:
   ```conf
   // Maximum number of guild members allowed in a castle (0: disabled)
   castle_member_limit: 80
   ```

4. Recompile your server and restart

## Configuration

### WoE Warper Settings
```conf
// Time when warper is available (in minutes before WoE start)
woe_warper_prebuffer: 15

// Minimum base level to use warper
woe_warper_min_level: 85

// Whether to show castle ownership info
woe_warper_show_info: true
```

### Castle Member Settings
```conf
// Maximum members per castle (default: 80)
castle_member_limit: 80

// Grace period before kicking excess members (in seconds)
castle_limit_grace_period: 10

// Whether to prioritize guild leadership
castle_limit_protect_leaders: true
```

## Technical Details

### WoE Warper
- Custom NPC script with built-in castle information
- Automatic availability during WoE times
- Real-time castle ownership display
- Efficient warp handling

### Castle Member Limit
- Real-time member counting
- Efficient member management
- Priority-based member removal
- Automatic notification system

## Benefits

- **For Players**
  - Convenient castle access
  - Clear WoE participation rules
  - Better balanced castle defense
  - Fair competition

- **For Server**
  - Improved WoE balance
  - Reduced castle overcrowding
  - Better resource management
  - Enhanced competitive gameplay

## Requirements

- rAthena server
- Server compiled with castle limit patch
- Custom NPC support enabled

## Compatibility

- Works with all WoE systems
- Compatible with custom WoE modifications
- No conflicts with other WoE features
- Works alongside other QoL improvements

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 