#include "map.h"
#include "battle.h"
#include "clif.h"
#include "guild.h"
#include "script.h"
#include "timer.h"
#include "malloc.h"
#include "nullpo.h"
#include "showmsg.h"
#include "strlib.h"
#include "db.h"
#include "mapreg.h"
#include "woe_tracker.h"

struct woe_tracker_data {
    int session_id;
    int castle_id;
    int guild_id;
    char guild_name[24];
    struct {
        int64 damage_amount;
        int64 damage_received;
        int64 heal_amount;
        int kill_count;
        int death_count;
        int skill_count;
    } stats[MAX_PARTY];
};

static struct woe_tracker_data woe_data[MAX_WOE_SESSIONS];
static int current_session = -1;

// Initialize WoE tracking
void woe_tracker_init(void) {
    memset(woe_data, 0, sizeof(woe_data));
    current_session = -1;
}

// Start a new WoE session
int woe_tracker_start_session(int castle_id, int guild_id, const char* guild_name) {
    int i;
    
    // Find free slot
    for (i = 0; i < MAX_WOE_SESSIONS; i++) {
        if (woe_data[i].session_id == 0) {
            current_session = i;
            woe_data[i].session_id = i + 1;
            woe_data[i].castle_id = castle_id;
            woe_data[i].guild_id = guild_id;
            strncpy(woe_data[i].guild_name, guild_name, 23);
            woe_data[i].guild_name[23] = '\0';
            
            // Insert into database
            if (SQL_ERROR == SQL->QueryStr(SQL->handle,
                "INSERT INTO woe_sessions (castle_id, guild_id, guild_name) VALUES (%d, %d, '%s')",
                castle_id, guild_id, guild_name)) {
                ShowError("woe_tracker_start_session: Failed to insert session\n");
                return -1;
            }
            
            return i + 1;
        }
    }
    return -1;
}

// End WoE session
void woe_tracker_end_session(int session_id) {
    int i;
    
    for (i = 0; i < MAX_WOE_SESSIONS; i++) {
        if (woe_data[i].session_id == session_id) {
            // Update database
            if (SQL_ERROR == SQL->QueryStr(SQL->handle,
                "UPDATE woe_sessions SET end_time = NOW(), status = 'completed' WHERE id = %d",
                session_id)) {
                ShowError("woe_tracker_end_session: Failed to update session\n");
            }
            
            // Clear data
            memset(&woe_data[i], 0, sizeof(struct woe_tracker_data));
            if (current_session == i)
                current_session = -1;
            break;
        }
    }
}

// Track player damage
void woe_tracker_damage(struct map_session_data* sd, int64 damage) {
    if (current_session < 0) return;
    
    woe_data[current_session].stats[sd->bl.id].damage_amount += damage;
    
    // Update database
    if (SQL_ERROR == SQL->QueryStr(SQL->handle,
        "INSERT INTO woe_data (player_name, damage_amount) VALUES ('%s', %lld) "
        "ON DUPLICATE KEY UPDATE damage_amount = damage_amount + %lld",
        sd->status.name, damage, damage)) {
        ShowError("woe_tracker_damage: Failed to update damage\n");
    }
}

// Track player damage received
void woe_tracker_damage_received(struct map_session_data* sd, int64 damage) {
    if (current_session < 0) return;
    
    woe_data[current_session].stats[sd->bl.id].damage_received += damage;
    
    // Update database
    if (SQL_ERROR == SQL->QueryStr(SQL->handle,
        "INSERT INTO woe_data (player_name, damage_received) VALUES ('%s', %lld) "
        "ON DUPLICATE KEY UPDATE damage_received = damage_received + %lld",
        sd->status.name, damage, damage)) {
        ShowError("woe_tracker_damage_received: Failed to update damage received\n");
    }
}

// Track player healing
void woe_tracker_heal(struct map_session_data* sd, int64 heal) {
    if (current_session < 0) return;
    
    woe_data[current_session].stats[sd->bl.id].heal_amount += heal;
    
    // Update database
    if (SQL_ERROR == SQL->QueryStr(SQL->handle,
        "INSERT INTO woe_data (player_name, heal_amount) VALUES ('%s', %lld) "
        "ON DUPLICATE KEY UPDATE heal_amount = heal_amount + %lld",
        sd->status.name, heal, heal)) {
        ShowError("woe_tracker_heal: Failed to update healing\n");
    }
}

// Track player kills
void woe_tracker_kill(struct map_session_data* sd) {
    if (current_session < 0) return;
    
    woe_data[current_session].stats[sd->bl.id].kill_count++;
    
    // Update database
    if (SQL_ERROR == SQL->QueryStr(SQL->handle,
        "INSERT INTO woe_data (player_name, kill_count) VALUES ('%s', 1) "
        "ON DUPLICATE KEY UPDATE kill_count = kill_count + 1",
        sd->status.name)) {
        ShowError("woe_tracker_kill: Failed to update kills\n");
    }
}

// Track player deaths
void woe_tracker_death(struct map_session_data* sd) {
    if (current_session < 0) return;
    
    woe_data[current_session].stats[sd->bl.id].death_count++;
    
    // Update database
    if (SQL_ERROR == SQL->QueryStr(SQL->handle,
        "INSERT INTO woe_data (player_name, death_count) VALUES ('%s', 1) "
        "ON DUPLICATE KEY UPDATE death_count = death_count + 1",
        sd->status.name)) {
        ShowError("woe_tracker_death: Failed to update deaths\n");
    }
}

// Track skill usage
void woe_tracker_skill(struct map_session_data* sd) {
    if (current_session < 0) return;
    
    woe_data[current_session].stats[sd->bl.id].skill_count++;
    
    // Update database
    if (SQL_ERROR == SQL->QueryStr(SQL->handle,
        "INSERT INTO woe_data (player_name, skill_count) VALUES ('%s', 1) "
        "ON DUPLICATE KEY UPDATE skill_count = skill_count + 1",
        sd->status.name)) {
        ShowError("woe_tracker_skill: Failed to update skills\n");
    }
}

// Track player participation
void woe_tracker_participation(struct map_session_data* sd) {
    if (current_session < 0) return;
    
    // Insert into database
    if (SQL_ERROR == SQL->QueryStr(SQL->handle,
        "INSERT INTO woe_participation (session_id, player_name, guild_id, guild_name) "
        "VALUES (%d, '%s', %d, '%s')",
        woe_data[current_session].session_id,
        sd->status.name,
        sd->guild ? sd->guild->guild_id : 0,
        sd->guild ? sd->guild->name : "")) {
        ShowError("woe_tracker_participation: Failed to insert participation\n");
    }
} 