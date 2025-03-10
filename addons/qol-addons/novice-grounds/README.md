# Novice Grounds Job Selection

This addon replaces the traditional job quiz in the Novice Grounds with a direct job selection menu, including additional job options.

## Features

- Direct job selection instead of quiz
- Additional job options:
  - Gunslinger
  - TaeKwon
  - Ninja
  - Super Novice
- Maintains level requirements
- Preserves existing job restrictions

## Installation

1. Copy the script file:
   ```bash
   cp job_selection.txt /path/to/rathena/npc/custom/
   ```

2. Add to your `conf/import/npc.conf`:
   ```conf
   npc: npc/custom/job_selection.txt
   ```

3. Restart your server

## Configuration

Edit `job_selection.txt` to customize:
- Required level for job change
- Available job options
- Job change costs
- Additional requirements

## Requirements

- rAthena server
- Level 10+ Novice
- Base level requirements for each job

## Known Issues

None reported.

## Support

For issues or suggestions, please create an issue in the repository. 