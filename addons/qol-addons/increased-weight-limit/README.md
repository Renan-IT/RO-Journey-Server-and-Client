# Increased Weight Limit Configuration

This configuration guide provides details on adjusting the weight limit for characters in the `rAthena` server. This setting allows you to control the maximum weight a character can carry before they stop healing naturally.

## Configuration Option

### Natural Heal Weight Rate
- **File**: `rathena/conf/battle/player.conf`
- **Setting**: `natural_heal_weight_rate`
- **Description**: This setting determines the maximum weight percentage a character can carry before natural healing stops. The default value is `50%`. For renewal servers, the setting `natural_heal_weight_rate_renewal` is used, with a default value of `70%`. Note that for renewal, a client version of `20171025` or newer is required to display this properly.