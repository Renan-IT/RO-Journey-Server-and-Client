#ifndef WOE_TRACKER_H
#define WOE_TRACKER_H

#include "map.h"

#define MAX_WOE_SESSIONS 10
#define MAX_PARTY 100

// Function declarations
void woe_tracker_init(void);
int woe_tracker_start_session(int castle_id, int guild_id, const char* guild_name);
void woe_tracker_end_session(int session_id);
void woe_tracker_damage(struct map_session_data* sd, int64 damage);
void woe_tracker_damage_received(struct map_session_data* sd, int64 damage);
void woe_tracker_heal(struct map_session_data* sd, int64 heal);
void woe_tracker_kill(struct map_session_data* sd);
void woe_tracker_death(struct map_session_data* sd);
void woe_tracker_skill(struct map_session_data* sd);
void woe_tracker_participation(struct map_session_data* sd);

#endif /* WOE_TRACKER_H */ 