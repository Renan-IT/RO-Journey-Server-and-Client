import discord
from discord.ext import commands
from ..utils.db import Database
from ..config.config import CLASS_NAMES

class StatsCommands(commands.Cog):
    def __init__(self, bot):
        self.bot = bot
        self.db = Database()

    @commands.command(name='online')
    async def show_online_players(self, ctx):
        """Show currently online players"""
        players = self.db.get_online_players()
        if not players:
            await ctx.send("No players are currently online")
            return

        embed = discord.Embed(
            title="Online Players",
            color=discord.Color.green()
        )

        for player in players:
            name, class_id, base_level, job_level = player
            class_name = CLASS_NAMES.get(str(class_id), "Unknown")
            embed.add_field(
                name=name,
                value=f"Class: {class_name}\nBase Level: {base_level}\nJob Level: {job_level}",
                inline=False
            )

        await ctx.send(embed=embed)

    @commands.command(name='woe')
    async def show_woe_stats(self, ctx):
        """Show WoE statistics"""
        stats = self.db.get_woe_stats()
        if not stats:
            await ctx.send("No WoE statistics available")
            return

        embed = discord.Embed(
            title="WoE Statistics",
            color=discord.Color.red()
        )

        for stat in stats:
            name, class_id, damage, received, heal, kills, deaths, skills = stat
            class_name = CLASS_NAMES.get(str(class_id), "Unknown")
            embed.add_field(
                name=name,
                value=f"Class: {class_name}\n"
                      f"Damage Dealt: {damage:,}\n"
                      f"Damage Received: {received:,}\n"
                      f"Healing: {heal:,}\n"
                      f"Kills: {kills}\n"
                      f"Deaths: {deaths}\n"
                      f"Skills Used: {skills}",
                inline=False
            )

        await ctx.send(embed=embed) 