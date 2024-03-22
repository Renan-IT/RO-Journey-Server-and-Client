# main.py
import discord
from discord.ext import commands
from config import * # Load config.py

bot = commands.Bot(command_prefix=PREFIX)

# ...

bot.load_extension("commands.accreate")  # Load accreate_commands.py
bot.load_extension("commands.passrenew")  # Load passrenew_commands.py
bot.load_extension("commands.cchanel")  # Load cchanel_commands.py

# ...

bot.run(TOKEN)
