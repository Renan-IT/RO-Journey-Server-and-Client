# Setting up a functional rAthena server and client on Windows (2026)

> **Disclaimer**: This guide has not been tested and is an adaptation of the Linux guide for Windows created via AI. Use at your own risk and verify steps manually.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Server Setup](#server)
  - [Quick Setup (Automated)](#quick-setup-automated)
  - [Manual Setup](#manual-setup)
- [Client Setup](#client)
- [Troubleshooting](#troubleshooting)
- [Security Considerations](#security-considerations)
- [Maintenance](#maintenance)
- [Additional Setup for Running the Server](#additional-setup-for-running-the-server)
  - [Installing XAMPP](#installing-xampp)
  - [Running the Server as a Service](#running-the-server-as-a-service)
  - [Optional: Installing phpMyAdmin](#optional-installing-phpmyadmin)

## Prerequisites
Before starting, ensure you have:
- Windows 10/11 or later
- At least 4GB RAM (8GB recommended)
- 2GB free disk space
- A stable internet connection
- Basic knowledge of Windows commands (CMD or PowerShell)
- A public IP address (if hosting for external access)

## Server

### Quick Setup (Automated)
You can use the provided setup script to automate most of the setup process (note: the script is adapted for Windows; download it from the repo).

1. **Download the setup script**:
   ```bash
   wget https://raw.githubusercontent.com/Renan-IT/RO-Journey-Server-and-Client/main/setup-windows.bat
   ```

2. **Make the script executable**:
   ```
   # Not necessary on Windows, but ensure .bat extensions are allowed.
   ```

3. **Run the script**:
   ```
   setup-windows.bat
   ```

4. **Follow the prompts**:
   - Enter your database name (default: ragnarok)
   - Enter your MySQL username (default: ragnarok)
   - Enter your MySQL password (default: ragnarok)
   - Enter your server name (default: MyRO)
   - Enter your server's public IP
   - Enter your admin username (default: admin)
   - Enter your admin password (default: admin)
   - Enter server communication username (default: s1)
   - Enter server communication password (default: p1)

The script will:
- Update your system (via Windows Update if necessary)
- Install required dependencies
- Set up MySQL database
- Import necessary SQL files
- Configure server files
- Compile the server

> **Note**: The script requires administrator privileges to install software.

### Manual Setup
If you prefer to set up manually, follow these steps:

1. **Update and Upgrade**:
   - Open Windows Update and install available updates.

2. **Install Essential Dependencies**:
   - Download and install:
     - [Visual Studio Community](https://visualstudio.microsoft.com/free-developer-offers/) (free, select "Desktop development with C++")
     - [MySQL Community Server](https://dev.mysql.com/downloads/mysql/) (free)
     - [Git for Windows](https://gitforwindows.org/) (includes Git Bash)
     - [Notepad++](https://notepad-plus-plus.org/) or VS Code (text editor)

3. **Clone the rAthena Repository**:
   - Open Git Bash or CMD:
     ```
     git clone https://github.com/rathena/rathena.git C:\rAthena
     cd C:\rAthena
     git pull
     ```

4. **Set Up the MySQL Database**:
   - Open MySQL Workbench or the MySQL command line (usually in `C:\Program Files\MySQL\MySQL Server X.X\bin\mysql.exe`).
   - Create the database and users:
     ```
     CREATE DATABASE ragnarok;
     CREATE USER 'rathena'@'localhost' IDENTIFIED BY 'password';
     CREATE USER 'rathena'@'%' IDENTIFIED BY 'password';
     GRANT ALL PRIVILEGES ON ragnarok.* TO 'rathena'@'localhost' WITH GRANT OPTION;
     GRANT ALL PRIVILEGES ON *.* TO 'rathena'@'%' WITH GRANT OPTION;
     GRANT ALL PRIVILEGES ON *.* TO 'rathena'@'localhost' WITH GRANT OPTION;
     CREATE DATABASE log;
     GRANT ALL ON log.* TO 'rathena'@'localhost';
     ```
   - Import SQL files in this specific order (use MySQL Workbench to import .sql files or command line):
     ```
     # Import main database tables
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\main.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\web.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\roulette_default_data.sql
     mysql -u rathena -p log < C:\rAthena\sql-files\logs.sql
     # Pre-Renewal - Import only for Pre-renewal Server
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\item_db.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\item_db_equip.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\item_db_etc.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\item_db_usable.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\item_db2.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\mob_db.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\mob_db2.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\mob_skill_db.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\mob_skill_db2.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\compatibility\item_db_compat.sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\compatibility\item_db2_compat.sql
     # Renewal - Import only for Renewal Server (skip for Pre-Renewal)
     # mysql -u rathena -p ragnarok < C:\rAthena\sql-files\item_db_re.sql
     # ... (similar for other _re files)
     # Common required files
     # Replace (date).sql with the most recent upgrade file, e.g., 2023-01-01.sql
     # mysql -u rathena -p ragnarok < C:\rAthena\sql-files\upgrades\(date).sql
     mysql -u rathena -p ragnarok < C:\rAthena\sql-files\tools\convert_engine_innodb.sql
     ```
   - Note: Files with `_re` suffix are for Renewal mode. Skip them for Pre-Renewal.
   - Create your first admin account:
     ```
     mysql -e "INSERT INTO \`ragnarok\`.\`login\` (\`account_id\`, \`userid\`, \`user_pass\`, \`sex\`, \`email\`, \`group_id\`, \`state\`, \`unban_time\`, \`expiration_time\`, \`logincount\`, \`lastlogin\`, \`last_ip\`, \`birthdate\`, \`character_slots\`, \`pincode\`, \`pincode_change\`, \`vip_time\`, \`old_group\`) VALUES ('20000000', 'admin', 'adminpass', 'M', 'admin@email.com', '99', '0', '0', '0', '0', '2022-02-20 00:00:00', '', '2022-02-20', '9', '', '0', '0', '0');"
     ```
   - You can manage your MySQL database using MySQL Workbench or command line.

5. **Configure rAthena Files**:
   - Create or edit files in `C:\rAthena\conf\import\` (use Notepad++ or VS Code):
     - `char_conf.txt`:
       ```
       // Server Communication username and password.
       userid: s1
       passwd: p1
       // Server name, use alternative character such as ASCII 160 for spaces.
       server_name: MyRO
       // Login Server IP
       login_ip: your_public_ip
       // Character Server IP
       char_ip: your_public_ip
       ```
     - `inter_conf.txt`:
       ```
       // MySQL Login server
       login_server_ip: localhost
       login_server_port: 3306
       login_server_id: rathena
       login_server_pw: password
       login_server_db: ragnarok
       login_codepage:
       login_case_sensitive: yes

       ipban_db_ip: localhost
       ipban_db_port: 3306
       ipban_db_id: rathena
       ipban_db_pw: password
       ipban_db_db: ragnarok
       ipban_codepage:

       // MySQL Character server
       char_server_ip: localhost
       char_server_port: 3306
       char_server_id: rathena
       char_server_pw: password
       char_server_db: ragnarok

       // MySQL Map Server
       map_server_ip: localhost
       map_server_port: 3306
       map_server_id: rathena
       map_server_pw: password
       map_server_db: ragnarok

       // MySQL Web Server
       web_server_ip: localhost
       web_server_port: 3306
       web_server_id: rathena
       web_server_pw: password
       web_server_db: ragnarok

       // MySQL Log Database
       log_db_ip: localhost
       log_db_port: 3306
       log_db_id: rathena
       log_db_pw: password
       log_db_db: log
       log_codepage:
       log_login_db: loginlog
       ```
     - `map_conf.txt`:
       ```
       userid: s1
       passwd: p1
       char_ip: your_public_ip
       char_port: 6121
       map_ip: your_public_ip
       map_port: 5121
       ```
   - Update the login table for server communication:
     ```
     mysql -u rathena -p -D ragnarok -e "UPDATE login SET userid='s1', user_pass='p1' WHERE account_id=1;"
     ```

6. **Compile & Run the Emulator**:
   - Open Visual Studio Developer Command Prompt (search for it in Start menu).
   - Define the packet version (our example is 20220406):
     ```
     cd C:\rAthena
     configure.bat --enable-packetver=20220406 --enable-prere=yes --enable-vip=no --enable-64bit=yes --enable-debug=no
     ```
     - Explanation:
       - `--enable-prere=yes` for Pre-Renewal mode
       - `--enable-vip=no` to disable VIP
       - `--enable-64bit=yes` for 64-bit
       - `--enable-debug=no` to disable debug
   - Clean and compile:
     ```
     nmake clean
     nmake server
     ```
   - Start the server:
     ```
     athena-start start
     ```
   - Other options:
     - `athena-start stop` to stop
     - `athena-start restart` to restart
     - `athena-start status` to check status

## Client Setup

### 1. Requirements

- **Download the following files:**
  - [WARP](https://github.com/Neo-Mind/WARP)
  - [Ragexe Client](http://nemo.herc.ws/clients/) - Use `2022-04-06_Ragexe_1648707856`
  - [kRO Full Client 2023-04-04](https://rathena.org/board/topic/106413-kro-full-client-2023-04-04-includes-bgm-rsu/)
  - [ROenglishRE](https://github.com/llchrisll/ROenglishRE)
  - [GRF Editor](https://rathena.org/board/files/file/2766-grf-editor/) (optional)

### 2. Extracting Archives

- **Unzip the following archives:**
  - `kRO_FullClient_20230404.zip`
  - `ROenglishRE-master.zip`
  - WARP archive
- **Install** the GRF Editor (optional).

### 3. File Organization

- **Create the following folder structure:**
  ```
  fullclient
  ├─ client (contents from kRO_FullClient_20230404.zip)
  ├─ ROenglishRE-master (contents from ROenglishRE-master.zip)
  ├─ WARP (contents from the WARP archive)
  ├─ ragexe (your ragexe file)
  └─ archives (all other archives)
  ```

### 4. File Copying

- **Navigate to** `ROenglishRE-master/Tools` and execute the following scripts:
  - `ClientGenerator.bat`: Select `re (0)` and `2022-04-06 (11)` then exit
  - `ClientGenerator.bat`: Select `prere (1)` and `2022-04-06 (11)`
  - `AdditionsGenerator.bat`: Enter `20220406`
  - `option (1)` and add every "all in one" package (1), Back (0)
  - `option (2)` and add every "all in one" package (1), Back (0)
  - `option (3)` and add every "all in one" package (1), Back (0)
  - `option (6)` Exit
  - `CLSGenerator.bat`: Select all "all in one" packages
- **Open** the newly created `Client/` folder.
- **Copy** all files to the `fullclient\kro` folder.

### 5. Client Configuration

- **Edit** the `clientinfo.xml` file in the `data` folder to specify your client's name and change the IP address to your server's public IP.

### 6. Patching the Ragexe

- **Execute** `.\WARP\win32\WARP.exe`.
- **Load** `.\ragexe\2022-04-06_Ragexe_1648707856.exe` as the source in WARP.
- **Load Patches**
- **Use** the top-left menu to load the WARP session and select `.\ROenglishRE\Addons\WARP SESSIONS\2019-06_Translation.yml`.
- **Click** `Select Recommended` and apply the patches.
- Ensure **Game Guard** is **Disabled**
- **Disable MessageBoxes**
- **Enable Read data Folder First**
- **Copy** the patched ragexe to the `client` folder.

## Troubleshooting
Common issues and solutions:

1. **Server won't start**
   - Check if all ports are open (6900, 6121, 5121) using `netstat -an | find "LISTEN"`
   - Verify MySQL is running via Windows Services (services.msc)
   - Check server logs in `C:\rAthena\log\` directory

2. **Database connection issues**
   - Verify MySQL credentials in `inter_conf.txt`
   - Ensure MySQL service is running
   - Check Windows Firewall settings

3. **Client connection problems**
   - Verify packet version matches client (20220406)
   - Check server IP configuration in clientinfo.xml
   - Ensure client files are properly patched

## Security Considerations
1. **Firewall Configuration**
   - Open Windows Firewall and allow inbound rules for ports:
     - 6900 (TCP) for Login Server
     - 6121 (TCP) for Char Server
     - 5121 (TCP) for Map Server
     - 3306 (TCP) for MySQL (if needed externally)

2. **Database Security**
   - Use strong passwords for MySQL users
   - Limit MySQL access to localhost when possible
   - Regularly backup your database

3. **Server Security**
   - Keep Windows and software updated
   - Use secure passwords for all accounts
   - Regularly check server logs for suspicious activity

## Maintenance
1. **Regular Backups**
   ```
   # Backup database
   mysqldump -u rathena -p ragnarok > backup.sql
   
   # Backup server files
   # Use 7-Zip or PowerShell to compress C:\rAthena to rathena_backup.zip
   ```

2. **Server Updates**
   ```
   cd C:\rAthena
   git pull
   nmake clean
   nmake server
   ```

3. **Log Management**
   - Regularly check and delete old logs in `C:\rAthena\log\` directory
   - Monitor error logs for issues

## Additional Setup for Running the Server

To run the rAthena server persistently, you can set it up as a Windows service or use a batch script.

### Installing XAMPP
XAMPP is a free bundle including Apache, MySQL, PHP, etc.
1. Download from [apachefriends.org](https://www.apachefriends.org/).
2. Install and start Apache/MySQL via the XAMPP control panel.

### Running the Server as a Service
- Create a batch file `start_server.bat`:
  ```
  @echo off
  cd C:\rAthena
  athena-start start
  pause
  ```
- To run as a service, use `sc create rAthena binPath= "C:\rAthena\athena-start.exe start"` (requires testing).

### Optional: Installing phpMyAdmin
1. Download phpMyAdmin from [phpmyadmin.net](https://www.phpmyadmin.net/).
2. Extract to `C:\xampp\htdocs\phpmyadmin`.
3. Access via `http://localhost/phpmyadmin`.
4. Log in with your MySQL username and password.

> **Note**: Ensure firewall allows HTTP (port 80) if accessing remotely. For security, use HTTPS.

## Additional Section

### Discord Bot Integration
This server comes with a Discord bot that provides various features to help manage your server and enhance player experience. The bot includes account management, WoE statistics tracking, and server status monitoring.

For detailed information about the bot's features, setup instructions, and configuration, please refer to the [Discord Bot README](addons/discord-bot/README.md).

### Quality of Life Addons
This server comes with various Quality of Life (QoL) improvements to enhance the player experience. These addons are located in the `addons/qol-addons/` directory, where you can find detailed documentation for each feature.

To learn more about available QoL features and their installation, please refer to the [QoL Addons README](addons/qol-addons/README.md).
