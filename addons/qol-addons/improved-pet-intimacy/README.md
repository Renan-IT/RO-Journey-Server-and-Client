# Improved Pet Intimacy Configuration

This configuration guide provides details on adjusting pet intimacy settings in the `rAthena` server. These settings allow you to control how pets interact with players, including their friendliness and hunger rates.

## Configuration Options

### Pet Friendliness Rate
- **File**: `rathena/conf/battle/pet.conf`
- **Setting**: `pet_friendly_rate`
- **Description**: This setting determines the rate at which a pet becomes friendly when fed. The default value is `100`. Increasing this value will make pets become friendly faster when fed.

### Pet Hunger Rate
- **File**: `rathena/conf/battle/pet.conf`
- **Setting**: `pet_hungry_delay_rate`
- **Description**: This setting controls how quickly a pet becomes hungry. The default value is `100`. Lowering this value will make pets get hungry more slowly.

### Pet Restrictions During Guild Wars
- **File**: `rathena/conf/battle/pet.conf`
- **Setting**: `pet_disable_in_gvg`
- **Description**: This setting determines whether pets are disabled during Guild Wars. If set to `yes`, pets will automatically return to their egg form when entering castles during War of Emperium (WoE) times, and hatching is not allowed within the castles.

## Homunculus Friendliness Rate
- **File**: `rathena/conf/battle/homunc.conf`
- **Setting**: `homunculus_friendly_rate`
- **Description**: Similar to pets, this setting controls the rate at which a homunculus becomes friendly when fed. The default value is `100`.