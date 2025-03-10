import os
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Database configuration
DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'user': os.getenv('DB_USER', 'your_db_user'),
    'password': os.getenv('DB_PASS', 'your_db_password'),
    'database': os.getenv('DB_NAME', 'your_db_name')
}

# Discord configuration
DISCORD_TOKEN = os.getenv('DISCORD_TOKEN', 'your_discord_bot_token')
COMMAND_PREFIX = os.getenv('COMMAND_PREFIX', '!')

# Class names mapping
CLASS_NAMES = {
    '0': 'Novice',
    '1': 'Swordman',
    '2': 'Hunter',
    '3': 'Priest',
    '4': 'Wizard',
    '5': 'Blacksmith',
    '6': 'Knight',
    '7': 'Assassin',
    '8': 'Crusader',
    '9': 'Monk',
    '10': 'Sage',
    '11': 'Rogue',
    '12': 'Alchemist',
    '13': 'Bard',
    '14': 'Dancer',
    '15': 'Super Novice',
    '16': 'Gunslinger',
    '17': 'Ninja',
    '18': 'Taekwon',
    '19': 'Star Gladiator',
    '20': 'Soul Linker',
    '21': 'Baby Novice',
    '22': 'Baby Swordman',
    '23': 'Baby Hunter',
    '24': 'Baby Priest',
    '25': 'Baby Wizard',
    '26': 'Baby Blacksmith',
    '27': 'Baby Knight',
    '28': 'Baby Assassin',
    '29': 'Baby Crusader',
    '30': 'Baby Monk',
    '31': 'Baby Sage',
    '32': 'Baby Rogue',
    '33': 'Baby Alchemist',
    '34': 'Baby Bard',
    '35': 'Baby Dancer',
    '36': 'Baby Super Novice',
    '37': 'Baby Gunslinger',
    '38': 'Baby Ninja',
    '39': 'Baby Taekwon',
    '40': 'Baby Star Gladiator',
    '41': 'Baby Soul Linker'
} 