import discord
import random
import string
import mysql.connector
import asyncio
import table2ascii

from discord.ext import commands

# Initialize the bot with intents
# Use default intents

intents = discord.Intents.default()
intents.message_content = True

bot = commands.Bot(command_prefix='!', intents=intents)


# Database configuration
db_config = {
    'host': '$SERVER_IP',  # Database host address
    'user': '$DB_USER',  # Database username
    'password': '$DB_PASS',  # Database password
    'database': '$DB_NAME'  # Database name
}

class_names = {
    0: 'Novice',
    1: 'Swordsman',
    2: 'Mage',
    3: 'Archer',
    4: 'Acolyte',
    5: 'Merchant',
    6: 'Thief',
    7: 'Knight',
    8: 'Priest',
    9: 'Wizard',
    10: 'Blacksmith',
    11: 'Hunter',
    12: 'Assassin',
    13: 'Knight (Mounted)',
    14: 'Crusader',
    15: 'Monk',
    16: 'Sage',
    17: 'Rogue',
    18: 'Alchemist',
    19: 'Bard',
    20: 'Dancer',
    21: 'Crusader (Mounted)',
    22: 'Wedding',
    23: 'Super Novice',
    24: 'Gunslinger',
    25: 'Ninja',
    26: 'Xmas',
    27: 'Summer',
    28: 'Hanbok',
    29: 'Oktoberfest',
    4001: 'High Novice',
    4002: 'High Swordsman',
    4003: 'High Mage',
    4004: 'High Archer',
    4005: 'High Acolyte',
    4006: 'High Merchant',
    4007: 'High Thief',
    4008: 'Lord Knight',
    4009: 'High Priest',
    4010: 'High Wizard',
    4011: 'Whitesmith',
   4012: 'Sniper',
    4013: 'Assassin Cross',
    4014: 'Lord Knight (Mounted)',
    4015: 'Paladin',
    4016: 'Champion',
    4017: 'Professor',
    4018: 'Stalker',
    4019: 'Creator',
    4020: 'Clown',
    4021: 'Gypsy',
    4022: 'Paladin (Mounted)',
    4023: 'Baby',
    4024: 'Baby Swordsman',
    4025: 'Baby Mage',
    4026: 'Baby Archer',
    4027: 'Baby Acolyte',
    4028: 'Baby Merchant',
    4029: 'Baby Thief',
    4030: 'Baby Knight',
    4031: 'Baby Priest',
    4032: 'Baby Wizard',
    4033: 'Baby Blacksmith',
    4034: 'Baby Hunter',
    4035: 'Baby Assassin',
    4036: 'Baby Knight (Mounted)',
    4037: 'Baby Crusader',
    4038: 'Baby Monk',
    4039: 'Baby Sage',
    4040: 'Baby Rogue',
    4041: 'Baby Alchemist',
    4042: 'Baby Bard',
    4043: 'Baby Dancer',
    4044: 'Baby Crusader (Mounted)',
    4045: 'Super Baby',
    4046: 'Taekwon',
    4047: 'Star Gladiator',
    4048: 'Star Gladiator (Flying)',
    4049: 'Soul Linker'
}


async def clear_channel(channel):
    async for message in channel.history(limit=None):
        await message.delete()

# Connection event
@bot.event
async def on_ready():
    print(f'Connected as {bot.user.name} ({bot.user.id})')

#-----------------------------------------------
# Command !accreate
@bot.command()
async def accreate(ctx, *, args=None):
    # Retrieve the user's Discord ID
    discord_id = ctx.author.id
    if args is None:
        await ctx.send(f"Oh dear, {ctx.author.mention}! You got a bit mixed up, didn't you? To create an account, use the correct command: `!accreate user:<username>,gender:<M or F>`. Let's try again!")
        return

    try:
        # Parse the arguments to extract the username and gender
        user_args = args.split(',')
        username = user_args[0].split(':')[1].strip()  # Extract the username
        gender = user_args[1].split(':')[1].strip()  # Extract the gender (M or F)

        # Check that the username contains only letters and numbers
        if not username.isalnum():
            await ctx.send(f"Ah, usernames! They need to be as simple and elegant as my dance steps. No special characters, just letters and numbers. Try again, {ctx.author.mention}!")
            return

        # Check that the gender is either 'M' (male) or 'F' (female)
        if gender not in ('M', 'F'):
            await ctx.send(f"Of course, of course! Gender is important, just like choosing the right potion before a battle. `M` for male and `F` for female. Make your choice, brave {ctx.author.mention}!")
            return

        # Check if the user already exists in the database
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        query = "SELECT * FROM azurerath.login WHERE email = %s"
        cursor.execute(query, (discord_id,))
        existing_user = cursor.fetchone()

        if existing_user:
            await ctx.send(f"Ah, this {ctx.author.mention} is already registered in our great book of heroes! No need to create another account. But if you've forgotten your password, I can help you reset it!")
            return

        # Check if the user already exists
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        query = "SELECT * FROM azurerath.login WHERE userid = %s"
        cursor.execute(query, (username,))
        existing_user = cursor.fetchone()

        if existing_user:
            await ctx.send(f"Oh dear, it smells like a duplicate! This user is already in our system. Maybe they have an evil twin somewhere... or just another account. Try another name, {ctx.author.mention}!")
            return
            # You can add other actions here in case of an existing user
    except IndexError:
        await ctx.send(f"Oh dear, {ctx.author.mention}! You got a bit mixed up, didn't you? To create an account, use the correct command: `!accreate user:<username>,gender:<M or F>`. Let's try again!")
        return

    # Generate a random password
    password = generate_random_password()

    # Retrieve the user's Discord ID
    discord_id = ctx.author.id

    # Establish the database connection
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # Execute the SQL query to add the user
        # Get the last inserted account_id
        cursor.execute("SELECT MAX(account_id) FROM azurerath.login")
        last_account_id = cursor.fetchone()[0] or 20000000  # Default to 20000000 if no records exist
        new_account_id = last_account_id + 1

        # Insert the user into the database
        insert_query = "INSERT INTO azurerath.login (account_id, userid, user_pass, sex, email, group_id, state, unban_time, expiration_time, logincount, lastlogin, last_ip, birthdate, character_slots, pincode, pincode_change, vip_time, old_group, discord_id) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        values = (str(new_account_id), username, password, gender, discord_id, '0', '0', '0', '0', '0', '2022-02-20 00:00:00', '', '2022-02-20', '9', '', '0', '0', '0', discord_id)
        cursor.execute(insert_query, values)
        conn.commit()
        await ctx.send(f"Congratulations, {ctx.author.mention}! Your account is ready! I'll send you the details via DM!")
        await ctx.author.send(f"Congratulations, {ctx.author.mention}! Your account is ready! Here are the details:\nUsername: {username}\nPassword: {password}\nKeep them safe, like a treasure in a chest!")

    except mysql.connector.Error as err:
        print(f"Error adding user: {err}")

    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals():
            conn.close()


#-----------------------------------------------
# Command !passrenew
@bot.command()
async def passrenew(ctx):
    # Retrieve the user's Discord ID
    discord_id = ctx.author.id

	# Check if the user already exists in the database
		conn = mysql.connector.connect(**db_config)
		cursor = conn.cursor()
		query = "SELECT * FROM azurerath.login WHERE email = %s"
		cursor.execute(query, (discord_id,))
		existing_user = cursor.fetchone()

		if existing_user:
			# Generate a new random password
			new_password = generate_random_password()

			# Update the password in the database
			update_query = "UPDATE azurerath.login SET user_pass = %s WHERE email = %s"
			cursor.execute(update_query, (new_password, discord_id))
			conn.commit()
			await ctx.send(f"Whoops, that's private! {ctx.author.mention}, I'll send you a DM!")
			await ctx.author.send(f"Ah, a fresh start! Your password has been reset, {ctx.author.mention}. \nHere is the new one: New password: {new_password} \nDon't forget to note it down somewhere safe!")
		else:
			await ctx.send(f"No worries, {ctx.author.mention}! Sometimes even the bravest lose their way. If you want to create an account, follow my instructions and we'll guide you to adventure!")

		cursor.close()
		conn.close()

# Function to generate a random password
def generate_random_password(length=8):
    characters = string.ascii_letters + string.digits
    return ''.join(random.choice(characters) for _ in range(length))

@bot.command()
async def blossom(ctx):
    help_message = f"""
    Hi, {ctx.author.mention}! I'm Blossom, the dedicated Kafra who watches over your needs. Here are the services I offer:

- 🌟 **Create an account**:
Use the command `!accreate user:<username>,gender:<M or F>` to register in our log. Whether you're a proud warrior or a daring magician, I welcome you with joy!

- 🔑 **Reset password**:
If you've misplaced your precious passwords, don't worry! Simply use `!passrenew` and I'll provide you with a brand new password. Don't forget to note it down somewhere safe!

Feel free to reach out if you need additional help. Let the adventure continue! 🌟🗡️
    """
    await ctx.send(help_message)


#-----------------------------------------------
@bot.command()
async def create_channel(ctx):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        login_query = "SELECT `name`, `class`, `base_level`, `job_level` FROM `char` WHERE `online` = '1'"
        cursor.execute(login_query)
        results = cursor.fetchall()  # Read all results
        player_count = len(results)  # Count the number of connected players
        
        print(f"players-connected-{player_count}")

        # Search for an existing channel whose name matches the pattern
        guild = ctx.guild
        model_name = f"players-connected-"
        existing_channel = None
        for channel in guild.text_channels:
            if channel.name.startswith(model_name):
                existing_channel = channel
                break

        if existing_channel:
            # Rename the existing channel
            new_name = f"players-connected-{player_count}"
            await existing_channel.edit(name=new_name)
            print(f"Channel renamed: {new_name}")
            
            # Create a list to store the table lines
            table_lines = []
            
            # Add the table header
            header = ["UserName", "Class", "BaseLvl", "JobLvl"]

            # Iterate through the results and add each line to the table
            for row in results:
                name, char_class, base_level, job_level = row
                class_name = class_names.get(char_class, "Unknown")
                # Use str() to convert integers to strings
                table_line = [str(name), str(class_name), str(base_level), str(job_level)]
                table_lines.append(table_line)

            # Convert the list of lists to ASCII text
            ascii_table = table2ascii.table2ascii(header=header, body=table_lines, first_col_heading=True)

            await clear_channel(existing_channel)
            await existing_channel.send(f"Connected players:\n```\n{ascii_table}\n```")
        else:
            await ctx.send("No existing channel to rename.")
            # Create a text channel with the number of connected players here (if necessary)
            channel_name = f"players-connected-{player_count}"
            await guild.create_text_channel(channel_name)
            print(f"Channel created: {channel_name}")

    except mysql.connector.Error as e:
        print(f"Error executing query: {e}")

    finally:
        cursor.close()
        conn.close()
    await asyncio.sleep(600)  # Wait 60 seconds before re-executing
    await create_channel(ctx)  # Recursive call

# Run the bot with your token
bot.run('$DISCORD_TOKEN')
