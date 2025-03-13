import discord
from discord.ext import commands
import hashlib
import random
import string
from ..utils.db import Database
from ..config.config import CLASS_NAMES

class AccountCommands(commands.Cog):
    def __init__(self, bot):
        self.bot = bot
        self.db = Database()

    @commands.command(name='accreate')
    async def create_account(self, ctx, username: str, password: str, gender: str):
        """Create a new game account"""
        if not self._validate_gender(gender):
            await ctx.send("❌ Gender must be 'M' or 'F'")
            return

        if self.db.check_username_exists(username):
            await ctx.send("❌ Username already exists")
            return

        if self.db.check_user_exists(str(ctx.author.id)):
            await ctx.send("❌ You already have an account")
            return

        hashed_password = self._hash_password(password)
        account_id = self._generate_account_id()
        
        if self.db.create_account(account_id, username, hashed_password, gender, str(ctx.author.id)):
            await ctx.send(f"✅ Account created successfully!\nUsername: {username}\nPassword: {password}")
        else:
            await ctx.send("❌ Failed to create account")

    @commands.command(name='passrenew')
    async def renew_password(self, ctx, new_password: str):
        """Renew your account password"""
        if not self.db.check_user_exists(str(ctx.author.id)):
            await ctx.send("❌ You don't have an account")
            return

        hashed_password = self._hash_password(new_password)
        if self.db.reset_password(str(ctx.author.id), hashed_password):
            await ctx.send(f"✅ Password renewed successfully!\nNew password: {new_password}")
        else:
            await ctx.send("❌ Failed to renew password")

    def _validate_gender(self, gender):
        return gender.upper() in ['M', 'F']

    def _hash_password(self, password):
        return hashlib.sha1(password.encode()).hexdigest()

    def _generate_account_id(self):
        return ''.join(random.choices(string.digits, k=10)) 