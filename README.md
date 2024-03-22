

# Setting up a functional rAthena server and client in `2024`
Let’s break down the journey to hosting a **Ragnarok Online rAthena server emulator** on **Ubuntu Minimal 20.04 LTS** as well as your own **Fullclient**

## Server
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
        sudo apt install build-essential zlib1g-dev libpcre3-dev -y
        sudo apt install libmariadb-dev libmariadb-dev-compat -y
        sudo add-apt-repository ppa:ondrej/php -y
        sudo apt install php phpmyadmin mysql-server mysql-client -y
        sudo apt install nano
        sudo apt install git make gcc g++ -y
        ```
        
    -   Explanation:
        -   `build-essential`: Installs essential tools (like compilers) needed for building software from source code.
        -   `zlib1g-dev`: Provides development files for the zlib compression library.
        -   `libpcre3-dev`: Installs development files for the PCRE (Perl Compatible Regular Expressions) library.
        -   `libmariadb-dev`  and  `libmariadb-dev-compat`: These packages provide development files and compatibility libraries for MariaDB (a MySQL fork).
        -   Ondřej Surý PHP repository provides PHP packages not available in the default Ubuntu repositories.
        -   `php`: Installs PHP, a server-side scripting language.
        -   `phpmyadmin`: A web-based interface for managing MySQL databases.
        -   `mysql-server`  and  `mysql-client`: Installs MySQL server and client components.
        -  `nano`: A lightweight and user-friendly text editor
        -  `git`: Installs the Git version control system. Git is widely used for managing source code repositories
        -  `make` `gcc` `g++`: Install essential development tools for compiling and building software

    -   Notes:
        After installing phpMyAdmin, you’ll be prompted to configure a database. Follow these instructions:

        -   When prompted, type  **“yes”**  to configure the database.
        -   Set up a password for the database user.
        -   Select  **“1”**  (for  **apache2**) when asked to choose a web server.

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

	-   First, Access the MySQL shell as the root user.
		```bash
		sudo mysql -u root
		```
	-   Inside the MySQL shell, we need to perform the following actions:
		
		-   Create a new database (replace  `YOURDATABASENAME`  with your desired database name).
		-   Create two users (one for localhost and one for any host) with specified passwords.
		(Replace  `YOURMYSQLUSER`  & `YOURMYSQLUSERPASS`with your user and password)
		-   Grant privileges to these users on the database.
		-   Create an additional database named  `log`  and grant privileges for it.
	-   Commands :
		```sql
		CREATE DATABASE YOURDATABASENAME; 
		CREATE USER 'YOURMYSQLUSER'@'localhost' IDENTIFIED BY 'YOURMYSQLUSERPASS';
		CREATE USER 'YOURMYSQLUSER'@'%' IDENTIFIED BY 'YOURMYSQLUSERPASS';
		GRANT ALL PRIVILEGES ON YOURDATABASENAME. * TO 'YOURMYSQLUSER'@'localhost' WITH GRANT OPTION;
		GRANT ALL PRIVILEGES ON * . * TO 'YOURMYSQLUSER'@'%' WITH GRANT OPTION;
		GRANT ALL PRIVILEGES ON * . * TO 'YOURMYSQLUSER'@'localhost' WITH GRANT OPTION;
		CREATE DATABASE log;
		GRANT ALL ON log.* TO YOURMYSQLUSER@localhost;
		QUIT
		```
	-   Now you can import the rAthena .sql files using the specified `YOURMYSQLUSER`  & `YOURDATABASENAME`
	-   Commands :
		```bash
		mysql -u YOURMYSQLUSER -p YOURDATABASENAME < ./sql-files/main.sql
		mysql -u YOURMYSQLUSER -p log < ./sql-files/logs.sql
		```
		- Enter your MySQL user pass `YOURMYSQLUSERPASS` when prompted.

	-   Finish creating the first account directly on the database
		```bash
		sudo mysql -u YOURMYSQLUSER -p
		```
		Make sure to replace : `IGADMINUSER` & `IGADMINPASS` with your user and password
		(This can be edited later directly onto the phpMyAdmin UI)
		```sql
		INSERT INTO `YOURDATABASENAME`.`login` (`account_id`, `userid`, `user_pass`, `sex`, `email`, `group_id`, `state`, `unban_time`, `expiration_time`, `logincount`, `lastlogin`, `last_ip`, `birthdate`, `character_slots`, `pincode`, `pincode_change`, `vip_time`, `old_group`) VALUES ('20000000', 'IGADMINUSER', 'IGADMINPASS', 'M', 'admin@email.com', '99', '0', '0', '0', '0', '2022-02-20 00:00:00', '', '2022-02-20', '9', '', '0', '0', '0');
		QUIT
		```
		
	-   You can now any time login to your MySQL Database using your phpMyAdmin hosted website.

		-  Using : http://yourip/phpmyadmin/
		-  Login with : `YOURMYSQLUSER` & `YOURMYSQLUSERPASS`

5.  **Customize the  rAthena configuration Files**:

	-   Edit the rAthena configuration files located in `rAthena/conf/` using `nano` or any text editor.
		```bash
		nano ./conf/char_athena.conf
		```
	- look for and replace `s1` `p1` with any user and password of your choice:
		```
		// Server Communication username and password.
		userid: s1
		passwd: p1
		```
		Exemple :
		```
		// Server Communication username and password.
		userid: YOURSERVERCOMUSER
		passwd: SERVERCOMUSERPASS
		```

		next :
		```
		// Server name, use alternative character such as ASCII 160 for spaces.
		// NOTE: Do not use spaces or any of these characters which are not allowed in
		//       Windows filenames \/:*?"<>|
		//       ... or else guild emblems won't work client-side!
		server_name: YOURSERVERNAME
		// Login Server IP
		// The character server connects to the login server using this IP address.
		// NOTE: This is useful when you are running behind a firewall or are on
		// a machine with multiple interfaces.
		login_ip: YOUR.WAN.IP
		// Character Server IP 
		// The IP address which clients will use to connect. 
		// Set this to what your server's public IP address is. 
		char_ip: YOUR.WAN.IP
		```
		- Exit the editor pressing `Ctrl+X` key , Submitting `Y` to save.

	- Now that you've edited the Server Communication username and password you have to update it from the MySQL Database `Login` table.
		-  Using : http://yourip/phpmyadmin/
		-  Login with : `YOURMYSQLUSER` & `YOURMYSQLUSERPASS`
		- Expand your `YOURDATABASENAME`
		- Select `Login` table
		- Edit the user with `id account_id` = `1`
		- Replace 
			- userid: `s1` with `YOURSERVERCOMUSER` 
			- user_pass: `p1` with `SERVERCOMUSERPASS`
		
	-   Next edit the `inter_athena.conf` so the server will be able to read your MySQL Database.
	(Make sure to use the `YOURMYSQLUSER` , `YOURMYSQLUSERPASS` & `YOURDATABASENAME` you made earlier)
		```bash
		nano ./conf/inter_athena.conf
		```

		```
		// MySQL Login server
		login_server_ip: 127.0.0.1
		login_server_port: 3306
		login_server_id: YOURMYSQLUSER
		login_server_pw: YOURMYSQLUSERPASS
		login_server_db: YOURDATABASENAME
		login_codepage:
		login_case_sensitive: yes

		ipban_db_ip: 127.0.0.1
		ipban_db_port: 3306
		ipban_db_id: YOURMYSQLUSER
		ipban_db_pw: YOURMYSQLUSERPASS
		ipban_db_db: YOURDATABASENAME
		ipban_codepage:

		// MySQL Character server
		char_server_ip: 127.0.0.1
		char_server_port: 3306
		char_server_id: YOURMYSQLUSER
		char_server_pw: YOURMYSQLUSERPASS
		char_server_db: YOURDATABASENAME

		// MySQL Map Server
		map_server_ip: 127.0.0.1
		map_server_port: 3306
		map_server_id: YOURMYSQLUSER
		map_server_pw: YOURMYSQLUSERPASS
		map_server_db: YOURDATABASENAME

		// MySQL Web Server
		web_server_ip: 127.0.0.1
		web_server_port: 3306
		web_server_id: YOURMYSQLUSER
		web_server_pw: YOURMYSQLUSERPASS
		web_server_db: YOURDATABASENAME

		// MySQL Log Database
		log_db_ip: 127.0.0.1
		log_db_port: 3306
		log_db_id: YOURMYSQLUSER
		log_db_pw: YOURMYSQLUSERPASS
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
		userid: YOURSERVERCOMUSER
		passwd: SERVERCOMUSERPASS
		```

		Uncomment the following lines (Removing the `//`)
		```
		char_ip: YOUR.WAN.IP
		char_port: 6121
		map_ip: YOUR.WAN.IP
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
		./configure --enable-packetver=20220406 --enable-prere=yes --enable-vip=no
		```
    -   Explanation:
	    - `--enable-prere=yes ` to yes if you want pre-renewal mode
	    - `--enable-vip=no` if you want to disable the VIP feature

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
	- Also unzip the `ROenglishRE-master.zip` archive.
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

