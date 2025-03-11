import mysql.connector
from mysql.connector import Error
from ..config.config import DB_CONFIG

class Database:
    def __init__(self):
        self.config = DB_CONFIG
        self.connection = None
        self.cursor = None

    def connect(self):
        try:
            self.connection = mysql.connector.connect(**self.config)
            self.cursor = self.connection.cursor()
            return True
        except Error as e:
            print(f"Error connecting to MySQL: {e}")
            return False

    def disconnect(self):
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()

    def execute_query(self, query, params=None):
        try:
            if not self.connection or not self.connection.is_connected():
                self.connect()
            
            self.cursor.execute(query, params or ())
            self.connection.commit()
            return self.cursor.fetchall()
        except Error as e:
            print(f"Error executing query: {e}")
            return None
        finally:
            self.disconnect()

    def check_user_exists(self, discord_id):
        query = "SELECT * FROM login WHERE email = %s"
        result = self.execute_query(query, (discord_id,))
        return bool(result)

    def check_username_exists(self, username):
        query = "SELECT * FROM login WHERE userid = %s"
        result = self.execute_query(query, (username,))
        return bool(result)

    def create_account(self, account_id, username, password, gender, discord_id):
        query = """
        INSERT INTO login (
            account_id, userid, user_pass, sex, email, group_id, 
            state, unban_time, expiration_time, logincount, 
            lastlogin, last_ip, birthdate, character_slots, 
            pincode, pincode_change, vip_time, old_group, discord_id
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = (
            str(account_id), username, password, gender, discord_id,
            '0', '0', '0', '0', '0', '2022-02-20 00:00:00', '',
            '2022-02-20', '9', '', '0', '0', '0', discord_id
        )
        return self.execute_query(query, values)

    def reset_password(self, discord_id, new_password):
        query = "UPDATE login SET user_pass = %s WHERE email = %s"
        return self.execute_query(query, (new_password, discord_id))

    def get_online_players(self):
        query = "SELECT `name`, `class`, `base_level`, `job_level` FROM `char` WHERE `online` = '1'"
        return self.execute_query(query)

    def get_woe_stats(self):
        query = """
        SELECT w.`player_name`, p.`class`, w.`damage_amount`, 
               w.`damage_received`, w.`heal_amount`, w.`kill_count`, 
               w.`death_count`, w.`skill_count` 
        FROM `woe_data` w 
        INNER JOIN `char` p ON w.`player_name` = p.`name`
        """
        return self.execute_query(query) 