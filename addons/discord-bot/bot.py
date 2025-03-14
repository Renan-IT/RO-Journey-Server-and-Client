import discord
from discord.ext import commands
import hashlib
import random
import string
import mysql.connector
from mysql.connector import Error

# Configuration
DB_CONFIG = {
    'host': '$SQL_IP',
    'user': '$SQL_USER',
    'password': 'SQL_PASS',
    'database': '$SQL_DB'
}

DISCORD_TOKEN = 'Discord_Bot_Token'
COMMAND_PREFIX = '!'

# Database Utility
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

# Define intents
intents = discord.Intents.default()
intents.message_content = True

# Bot Setup
bot = commands.Bot(command_prefix=COMMAND_PREFIX, intents=intents)

# Account Commands
@bot.command(name='accreate')
async def create_account(ctx, username: str, password: str, gender: str):
    """Create a new game account"""
    db = Database()
    if gender.upper() not in ['M', 'F']:
        await ctx.send("❌ Gender must be 'M' or 'F'")
        return

    if db.check_username_exists(username):
        await ctx.send("❌ Username already exists")
        return

    if db.check_user_exists(str(ctx.author.id)):
        await ctx.send("❌ You already have an account")
        return

    hashed_password = hashlib.sha1(password.encode()).hexdigest()
    account_id = ''.join(random.choices(string.digits, k=10))
    
    if db.create_account(account_id, username, hashed_password, gender, str(ctx.author.id)):
        await ctx.send(f"✅ Account created successfully!\nUsername: {username}\nPassword: {password}")
    else:
        await ctx.send("❌ Failed to create account")

@bot.command(name='passrenew')
async def renew_password(ctx, new_password: str):
    """Renew your account password"""
    db = Database()
    if not db.check_user_exists(str(ctx.author.id)):
        await ctx.send("❌ You don't have an account")
        return

    hashed_password = hashlib.sha1(new_password.encode()).hexdigest()
    if db.reset_password(str(ctx.author.id), hashed_password):
        await ctx.send(f"✅ Password renewed successfully!\nNew password: {new_password}")
    else:
        await ctx.send("❌ Failed to renew password")

# Stats Commands
@bot.command(name='online')
async def show_online_players(ctx):
    """Show currently online players"""
    db = Database()
    players = db.get_online_players()
    if not players:
        await ctx.send("No players are currently online")
        return

    embed = discord.Embed(
        title="Online Players",
        color=discord.Color.green()
    )

    for player in players:
        name, class_id, base_level, job_level = player
        class_name = "Unknown"  # Replace with actual class name lookup if needed
        embed.add_field(
            name=name,
            value=f"Class: {class_name}\nBase Level: {base_level}\nJob Level: {job_level}",
            inline=False
        )

    await ctx.send(embed=embed)

# Run the Bot
bot.run(DISCORD_TOKEN) 
