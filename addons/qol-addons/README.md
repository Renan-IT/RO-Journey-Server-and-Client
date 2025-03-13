# Quality of Life (QoL) Addons

This directory contains various Quality of Life improvements for your rAthena server. Each addon is contained in its own subdirectory with specific documentation.

## Available Features

- AoE versions of Bless and Agi for Priests
- Auto pet feeding system
- Break songs on weapon change for Bards/Dancers
- Enhanced mass brewing system for Alchemists
- Enhanced party experience rates
- Extended food buff duration (30 minutes)
- Faster HP/SP recovery while sitting (1% per second)
- Food buffs persist through death
- HD ore exchange system
- Improved Endow skill for Assassins
- Improved pet intimacy gain rates
- Increased weight capacity (70% instead of 50%)
- MVP tomb system with kill information
- No MVP teleport memo
- No skill animations
- Quick job selection menu for new characters
- Random item options system
- Reduced wedding visual effects
- Safe card removal system
- Same-sex marriage option
- Streamer-specific benefits and protections
- Whosell and buy commands (`@ws` and `@wb`)
- WoE improvements

## Installation

Each addon has its own installation instructions in its respective directory. Generally, the process involves:

1. Copy the addon files to your server
2. Apply any necessary patches
3. Recompile the server

For specific installation instructions, please check the README file in each addon's directory.

## Patch Management

### Applying Patches

To apply a patch to your rAthena server:

1. Navigate to your rAthena source directory:
   ```bash
   cd /path/to/rathena
   ```

2. Apply the patch using git:
   ```bash
   git apply /path/to/patch.patch
   ```
   Or using patch command:
   ```bash
   patch -p1 < /path/to/patch.patch
   ```

3. If you encounter any conflicts, resolve them manually and then:
   ```bash
   git add .
   git commit -m "Applied patch: patch-name"
   ```

### Reverting Patches

To revert a patch:

1. If you used git to apply the patch:
   ```bash
   git reset --hard HEAD~1  # Reverts the last commit
   ```
   Or to revert to a specific commit:
   ```bash
   git reset --hard <commit-hash>
   ```

2. If you used the patch command:
   ```bash
   patch -R -p1 < /path/to/patch.patch
   ```

3. If you need to manually revert changes:
   - Keep a backup of your original files before applying patches
   - Restore from backup if needed
   - Or use your version control system's revert functionality

### Best Practices

1. Always backup your source code before applying patches
2. Use version control (like git) to track changes
3. Test patches in a development environment first
4. Keep track of which patches you've applied
5. Document any manual changes made during patch application 