import discord
from discord.ext import commands
from config.config import DISCORD_TOKEN, COMMAND_PREFIX
from commands.account import AccountCommands
from commands.stats import StatsCommands

class RagnarokBot(commands.Bot):
    def __init__(self):
        intents = discord.Intents.default()
        intents.message_content = True
        super().__init__(
            command_prefix=COMMAND_PREFIX,
            intents=intents,
            help_command=None
        )

    async def setup_hook(self):
        # Load command cogs
        await self.add_cog(AccountCommands(self))
        await self.add_cog(StatsCommands(self))

    async def on_ready(self):
        print(f'Logged in as {self.user.name} ({self.user.id})')
        print('------')

def main():
    bot = RagnarokBot()
    bot.run(DISCORD_TOKEN)

if __name__ == '__main__':
    main() 