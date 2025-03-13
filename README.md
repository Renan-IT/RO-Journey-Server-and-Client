# Setting up a functional rAthena server and client in `2025`

## Table of Contents
- [Prerequisites](#prerequisites)
- [Server Setup](#server)
  - [Quick Setup (Automated)](#quick-setup-automated)
  - [Manual Setup](#manual-setup)
- [Client Setup](#client)
- [Discord Bot Integration](#discord-bot-integration)
- [Quality of Life Addons](#quality-of-life-addons)
- [Troubleshooting](#troubleshooting)
- [Security Considerations](#security-considerations)
- [Maintenance](#maintenance)
- [Additional Setup for Running the Server](#additional-setup-for-running-the-server)
  - [Installing Screen](#installing-screen)
  - [Running the Server in a Screen Session](#running-the-server-in-a-screen-session)

## Prerequisites
Before starting, ensure you have:
- Ubuntu Minimal 20.04 LTS or later
- At least 2GB RAM (4GB recommended)
- 20GB free disk space
- A stable internet connection
- Basic knowledge of Linux commands
- A public IP address (if hosting for external access)

## Server

### Quick Setup (Automated)
You can use the provided setup script to automate the entire server setup process:

1. **Download the setup script**:
   ```bash
   wget https://raw.githubusercontent.com/Renan-IT/RO-Journey-Server-and-Client/main/setup.sh
   ```

2. **Make the script executable**:
   ```bash
   chmod +x setup.sh
   ```

3. **Run the script**:
   ```bash
   sudo ./setup.sh
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
- Update your system
- Install all required dependencies
- Set up MySQL database
- Import all necessary SQL files
- Configure server files
- Compile the server

> **Note**: The script requires sudo privileges to install packages and configure the system.

### Manual Setup
If you prefer to set up the server manually, follow these steps:

1.  **Updating and Upgrading**:
    
    -   Start by updating and upgrading your system. This is a good practice to ensure you have the latest security patches and software updates.
    -   Commands :
        
        ```bash
        sudo apt update && sudo apt upgrade -y
		```
        
    -   Explanation:
        -   `apt update`: Refreshes the package index to fetch the latest information about available packages.
        -   `apt upgrade -y`: Installs the latest versions of packages already installed on your system. 
        - The  `-y`  flag automatically confirms any prompts during the upgrade process.

2.  **Installing Essential Dependencies**:
    
    -   Next, you need to install some essential dependencies required for running the server emulator.
    -   Commands :
        
        ```bash
        sudo apt install build-essential -y
        sudo apt install zlib1g-dev -y
        sudo apt install libpcre3-dev -y
        sudo apt install libmariadb-dev -y
        sudo apt install libmariadb-dev-compat -y
        sudo add-apt-repository ppa:ondrej/php -y
        sudo apt install php -y
        sudo apt install phpmyadmin -y
        sudo apt install mysql-server -y
        sudo apt install mysql-client -y
        sudo apt install nano -y
        sudo apt install git -y
        sudo apt install make -y
        sudo apt install gcc -y
        sudo apt install g++ -y
        sudo apt install libmysqlclient-dev -y
        sudo apt install libssl-dev -y
        sudo apt autoremove -y
        sudo apt clean
        ```
        
    -   Explanation:
        -  `build-essential`: Installs essential tools (like compilers) needed for building software from source code.
        -  `zlib1g-dev`: Provides development files for the zlib compression library.
        -  `libpcre3-dev`: Installs development files for the PCRE (Perl Compatible Regular Expressions) library.
        -  `libmariadb-dev`  and  `libmariadb-dev-compat`: These packages provide development files and compatibility libraries for MariaDB (a MySQL fork).
        -   Ondřej Surý PHP repository provides PHP packages not available in the default Ubuntu repositories.
        -  `php`: Installs PHP, a server-side scripting language.
        -  `phpmyadmin`: A web-based interface for managing MySQL databases.
        -  `mysql-server`  and  `mysql-client`: Installs MySQL server and client components.
        -  `nano`: A lightweight and user-friendly text editor
        -  `git`: Installs the Git version control system. Git is widely used for managing source code repositories
        -  `make` `gcc` `g++`: Install essential development tools for compiling and building software
        -  `libmysqlclient-dev`: Provides development files for the MySQL client library
        -  `libssl-dev`: Provides development files for the OpenSSL library

    -   Notes:
        After installing phpMyAdmin, you'll be prompted to configure a database. Follow these instructions:

        -   When prompted, type  **"yes"**  to configure the database.
        -   Set up a password for the database user.
        -   Select  **"1"**  (for  **apache2**) when asked to choose a web server.

3.  **Clone the rAthena Repository**:

	-   Next, you need to clone the rAthena repository from GitHub into your home directory.
	    
	-   Commands :
		Make sure you are in your user home directory using : `pwd`
		Otherwise use : `cd /home/yourusername`
		```bash
		git clone https://github.com/rathena/rathena.git ~/rAthena
		cd rAthena/
		git pull
		```
	-   Explanation:
		-   `git pull`: Keep your local copy up to date by pulling any updates from the remote repository

4.  **Setting Up the MySQL Database**:

	-   Inside the MySQL shell, we need to perform the following actions:
		
		-   Create a new database (replace  `$DB_NAME`  with your desired database name).
		-   Create two users (one for localhost and one for any host) with specified passwords.
		(Replace  `$DB_USER`  & `$DB_PASS`with your user and password)
		-   Grant privileges to these users on the database.
		-   Create an additional database named  `log`  and grant privileges for it.
	-   Commands :
		```bash
		mysql -e "CREATE DATABASE $DB_NAME;"
		mysql -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
		mysql -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
		mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;"
		mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
		mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;"
		mysql -e "CREATE DATABASE log;"
		mysql -e "GRANT ALL ON log.* TO '$DB_USER'@'localhost';"
		```
	-   Now you need to import all the necessary SQL files in the correct order. Make sure you're in the rAthena directory:
		```bash
		cd ~/rAthena
		```

	-   Import the SQL files in this specific order:
		```bash
		# Import main database tables
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/main.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/web.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/roulette_default_data.sql
			mysql -u $DB_USER -p$DB_PASS log < sql-files/logs.sql
			# Pre-Renewal - Import only for Pre-renewal Server
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/item_db.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/item_db_equip.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/item_db_etc.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/item_db_usable.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/item_db2.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/mob_db.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/mob_db2.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/mob_skill_db.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/mob_skill_db2.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/compatibility/item_db_compat.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/compatibility/item_db2_compat.sql
		    # Renewal- Import only for Renewal Server
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/item_db_re.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/item_db_re_equip.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/item_db_re_etc.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/item_db_re_usable.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/item_db2_re.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/mob_db_re.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/mob_db2_re.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/mob_skill_db_re.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/mob_skill_db2_re.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/compatibility/item_db_re_compat.sql
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/compatibility/item_db2_re_compat.sql
			# 4. Common required files
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/upgrades/(date).sql # Replace with the most recent upgrade file
			mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/tools/convert_engine_innodb.sql # Recommended
		```

	-   Note: Files with `_re` suffix are for Renewal mode. If you're using Pre-Renewal mode, you can skip those files.

	-   After importing all SQL files, create your first admin account:
	
		Make sure to replace : `$ADMIN_USER` & `$ADMIN_PASS` with your user and password
		(This can be edited later directly onto the phpMyAdmin UI)
		```bash
		mysql -e "INSERT INTO \`$DB_NAME\`.\`login\` (\`account_id\`, \`userid\`, \`user_pass\`, \`sex\`, \`email\`, \`group_id\`, \`state\`, \`unban_time\`, \`expiration_time\`, \`logincount\`, \`lastlogin\`, \`last_ip\`, \`birthdate\`, \`character_slots\`, \`pincode\`, \`pincode_change\`, \`vip_time\`, \`old_group\`) VALUES ('20000000', '$ADMIN_USER', '$ADMIN_PASS', 'M', 'admin@email.com', '99', '0', '0', '0', '0', '2022-02-20 00:00:00', '', '2022-02-20', '9', '', '0', '0', '0');"
		```
		
	-   You can now any time login to your MySQL Database using your phpMyAdmin hosted website.

		-  Using : http://yourip/phpmyadmin/
		-  Login with : `$DB_USER` & `$DB_PASS`

5.  **Customize the  rAthena configuration Files**:

	-   Edit the rAthena configuration files located in `rAthena/conf/` using `nano` or any text editor.
		```bash
		nano ./conf/char_athena.conf
		```
	- look for and replace `ragnarok` `ragnarok` with any user and password of your choice:
		```
		// Server Communication username and password.
		userid: ragnarok
		passwd: ragnarok
		```
		Exemple :
		```
		// Server Communication username and password.
		userid: $SERVER_COM_USER
		passwd: $SERVER_COM_PASS
		```

		next :
		```
		// Server name, use alternative character such as ASCII 160 for spaces.
		// NOTE: Do not use spaces or any of these characters which are not allowed in
		//       Windows filenames \/:*?"<>|
		//       ... or else guild emblems won't work client-side!
		server_name: $SERVER_NAME
		// Login Server IP
		// The character server connects to the login server using this IP address.
		// NOTE: This is useful when you are running behind a firewall or are on
		// a machine with multiple interfaces.
		login_ip: $SERVER_IP
		// Character Server IP 
		// The IP address which clients will use to connect. 
		// Set this to what your server's public IP address is. 
		char_ip: $SERVER_IP
		```
		- Exit the editor pressing `Ctrl+X` key , Submitting `Y` to save.

	- Now that you've edited the Server Communication username and password you have to update it from the MySQL Database `Login` table.
		```bash
	 	mysql -u $DB_USER -p$DB_PASS -D $DB_NAME -e "UPDATE login SET userid='$SERVER_COM_USER', user_pass='$SERVER_COM_PASS' WHERE account_id=1;"	
		```
	-   Next edit the `inter_athena.conf` so the server will be able to read your MySQL Database.
	(Make sure to use the `$DB_USER` , `$DB_PASS` & `$DB_NAME` you made earlier)
		```bash
		nano ./conf/inter_athena.conf
		```

		```
		// MySQL Login server
		login_server_ip: localhost
		login_server_port: 3306
		login_server_id: $DB_USER
		login_server_pw: $DB_PASS
		login_server_db: $DB_NAME
		login_codepage:
		login_case_sensitive: yes

		ipban_db_ip: localhost
		ipban_db_port: 3306
		ipban_db_id: $DB_USER
		ipban_db_pw: $DB_PASS
		ipban_db_db: $DB_NAME
		ipban_codepage:

		// MySQL Character server
		char_server_ip: localhost
		char_server_port: 3306
		char_server_id: $DB_USER
		char_server_pw: $DB_PASS
		char_server_db: $DB_NAME

		// MySQL Map Server
		map_server_ip: localhost
		map_server_port: 3306
		map_server_id: $DB_USER
		map_server_pw: $DB_PASS
		map_server_db: $DB_NAME

		// MySQL Web Server
		web_server_ip: localhost
		web_server_port: 3306
		web_server_id: $DB_USER
		web_server_pw: $DB_PASS
		web_server_db: $DB_NAME

		// MySQL Log Database
		log_db_ip: localhost
		log_db_port: 3306
		log_db_id: $DB_USER
		log_db_pw: $DB_PASS
		log_db_db: log
		log_codepage:
		log_login_db: loginlog
		```
		- Exit the editor pressing `Ctrl+X` key , Submitting `Y` to save.
	-   The last file you need to edit is : `map_athena.txt`
		```bash
		nano ./conf/map_athena.conf
		```
		change `s1` `p1` to the you set up earlier :
		```
		userid: $SERVER_COM_USER
		passwd: $SERVER_COM_PASS
		```

		Uncomment the following lines (Removing the `//`)
		```
		char_ip: $SERVER_IP
		char_port: 6121
		map_ip: $SERVER_IP
		map_port: 5121
		```
		- Exit the editor pressing `Ctrl+X` key , Submitting `Y` to save.

	- Give the execution acces to the files
		```bash
		sudo chmod a+x ./configure
		```

6.  **Compile & Run the Emulator**:

	- In this step you will need to define the Packet version in order to match the client you'll be using
	(this will be explained in more detail later)
Our example client version is going to be **20220406** formated as `YYYMMDD`:
		```bash
		./configure --enable-packetver=20220406 --enable-prere=yes --enable-vip=no --enable-64bit=yes --enable-debug=no
		```
    -   Explanation:
	    - `--enable-prere=yes ` to yes if you want pre-renewal mode
	    - `--enable-vip=no` if you want to disable the VIP feature
	    - `--enable-64bit=yes` if you want to compile for 64-bit architecture
	    - `--enable-debug=no` if you want to compile without debugging information

	- Compilation Steps

		- Clean Up
    Run  `make clean`  to remove any existing build artifacts.
		- Compile the Server
    Execute  `make server`  to compile the rAthena server.
		- Set Execute Permissions:
		This command grants execute permission to all users (owner, group, and others) for these server components.
        ```bash
        sudo chmod a+x login-server char-server map-server
        ```
		
	- Start the server :
		``` bash
		./athena-start start
		```
	- Other options :

		`./athena-start stop` to stop the server

		`./athena-start restart` to restart the server

		`./athena-start status` to check the server status

## Client
1.  **Requierements**:

	- Download links :
		- https://github.com/Neo-Mind/WARP
		- http://nemo.herc.ws/clients/ - `2022-04-06_Ragexe_1648707856` Will be used
		- https://rathena.org/board/topic/106413-kro-full-client-2023-04-04-includes-bgm-rsu/
		- https://github.com/llchrisll/ROenglishRE
		- https://rathena.org/board/files/file/2766-grf-editor/

2.  **Extracting Archives**:

	- Unzip the full client archive `kRO_FullClient_20230404.zip`.
	- Unzip the `ROenglishRE-master.zip` archive.
	- Unzip the WARP archive.
	- Install GRF Editor.

3.  **File Organization**:

	- Create the following folder structure:
		```
		fullclient 
		├─ client (contents from kRO_FullClient_20230404.zip) 
		├─ ROenglishRE-master (contents from ROenglishRE-master.zip)
		├─ WARP (contents from the WARP archive) 
		├─ ragexe (your ragexe file) 
		├─ archives (all other archives) 
		└── endata
		```
		
4.  **File Copying**:
	- Copy files from the `ROenglishRE-master` folder to the `endata` folder. Maintain the order.
	- Overwrite existing files if necessary.
		- Copy all files from `ROenglishRE/Translation/Renewal/` and `ROenglishRE/Translation/Pre-Renewal/`.
		- Copy all files from `ROenglishRE/Additions/`.
		- For each folder in `ROenglishRE/Translation/Compatibility/YYYY-MM-DD/`, copy files from oldest to newest into the `endata` folder.
		(Subfolders `Renewal/` and `PreRenewal/` you should always start with `Renewal/`.)

5.  **Client Configuration**:

	- In the `endata` folder, edit the `clientinfo.xml` file to specify your client's name and change the IP address.

6.  **Creating the traduction GRF**:
	- Open GRF Editor, create a new GRF file, and add all files from the `endata` folder.
	- Save the GRF as `endata.grf`.
	- Copy the `endata.grf` file to the `client` folder.
	- Also copy all files from the `endata` folder to the `client` folder.

7.  **Editing DATA.ini**:
	- In the `client` folder, edit the `DATA.ini` file.
	- Add the line `0=endata.grf` above `1=rdata.grf` and save the changes.

8.  **Patching the Ragexe**:
	- Execute `./WARP/win32/WARP.exe`.
	- Load `./ragexe/2022-04-06_Ragexe_1648707856.exe` as the source in WARP.
	- Use the top-left menu to load the WARP session and select `./ROenglishRE/Addons/2020_Translation.yml`.
	- Apply the patches.
	- Copy the patched ragexe to the `client` folder.

## Discord Bot Integration
This server comes with a Discord bot that provides various features to help manage your server and enhance player experience. The bot includes account management, WoE statistics tracking, and server status monitoring.

For detailed information about the bot's features, setup instructions, and configuration, please refer to the [Discord Bot README](addons/discord-bot/README.md).

## Quality of Life Addons
This server comes with various Quality of Life (QoL) improvements to enhance the player experience. These addons are located in the `addons/qol-addons/` directory, where you can find detailed documentation for each feature.

To learn more about available QoL features and their installation, please refer to the [QoL Addons README](addons/qol-addons/README.md).

## Troubleshooting
Common issues and solutions:

1. **Server won't start**
   - Check if all ports are open (6900, 6121, 5121)
   - Verify MySQL is running: `sudo systemctl status mysql`
   - Check server logs in `log/` directory

2. **Database connection issues**
   - Verify MySQL credentials in `inter_athena.conf`
   - Ensure MySQL service is running
   - Check firewall settings

3. **Client connection problems**
   - Verify packet version matches client
   - Check server IP configuration
   - Ensure client files are properly patched

## Security Considerations
1. **Firewall Configuration**
   ```bash
   sudo ufw allow 6900/tcp  # Login Server
   sudo ufw allow 6121/tcp  # Char Server
   sudo ufw allow 5121/tcp  # Map Server
   sudo ufw allow 3306/tcp  # MySQL (if needed)
   ```

2. **Database Security**
   - connect with : mysql -u$DB_USER  -p
   - Use strong passwords
   - Limit MySQL access to localhost when possible
   - Regularly backup your database

3. **Server Security**
   - Keep system and packages updated
   - Use secure passwords for all accounts
   - Regularly check server logs for suspicious activity

## Maintenance
1. **Regular Backups**
   ```bash
   # Backup database
   mysqldump -u $DB_USER -p $DB_NAME > backup.sql
   
   # Backup server files
   tar -czf rathena_backup.tar.gz ~/rAthena/
   ```

2. **Server Updates**
   ```bash
   cd ~/rAthena
   git pull
   make clean
   make server
   ```

3. **Log Management**
   - Regularly check and rotate logs in `log/` directory
   - Monitor error logs for issues

## Additional Setup for Running the Server

To run the rAthena server in a separate session, we use `screen`. This allows the server to run independently of your terminal session, so it continues running even if you disconnect.

### Installing Screen

The setup script will automatically install `screen` for you. If you need to install it manually, use the following command:

```bash
sudo apt install screen -y
```

### Running the Server in a Screen Session

The setup script starts the server in a `screen` session named `rathena_server`. You can manage this session using the following commands:

- **Attach to the session**: To view the server output or interact with it, attach to the session using:
  ```bash
  screen -r rathena_server
  ```

- **Detach from the session**: To leave the session running in the background, press `Ctrl + A`, then `D`.

- **List all screen sessions**: To see all active screen sessions, use:
  ```bash
  screen -ls
  ```

- **Terminate the session**: To stop the server and terminate the session, attach to it and then stop the server using the appropriate command, or simply close the session with `Ctrl + D`.
