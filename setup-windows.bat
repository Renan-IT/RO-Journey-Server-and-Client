@echo off
REM Automated setup script for rAthena on Windows

REM Check for administrator privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running as administrator.
) else (
    echo This script must be run as administrator.
    pause
    exit /b 1
)

REM Update system (open Windows Update, but can't automate fully)
echo Please ensure Windows is updated via Settings > Update & Security > Windows Update.
pause

REM Assume dependencies are installed; provide links if not
echo Ensure the following are installed:
echo - Visual Studio Community: https://visualstudio.microsoft.com/free-developer-offers/
echo - MySQL Community Server: https://dev.mysql.com/downloads/mysql/
echo - Git for Windows: https://gitforwindows.org/
echo - Notepad++ or VS Code
echo Press any key when ready...
pause

REM Prompt for user inputs
set /p DB_NAME="Database name (default: ragnarok): "
if "%DB_NAME%"=="" set DB_NAME=ragnarok
set /p DB_USER="MySQL username (default: ragnarok): "
if "%DB_USER%"=="" set DB_USER=ragnarok
set /p DB_PASS="MySQL password (default: ragnarok): "
if "%DB_PASS%"=="" set DB_PASS=ragnarok
set /p SERVER_NAME="Server name (default: MyRO): "
if "%SERVER_NAME%"=="" set SERVER_NAME=MyRO
set /p SERVER_IP="Server's public IP: "
set /p ADMIN_USER="Admin username (default: admin): "
if "%ADMIN_USER%"=="" set ADMIN_USER=admin
set /p ADMIN_PASS="Admin password (default: admin): "
if "%ADMIN_PASS%"=="" set ADMIN_PASS=admin
set /p SERVER_COM_USER="Server communication username (default: s1): "
if "%SERVER_COM_USER%"=="" set SERVER_COM_USER=s1
set /p SERVER_COM_PASS="Server communication password (default: p1): "
if "%SERVER_COM_PASS%"=="" set SERVER_COM_PASS=p1
set /p PACKETVER="Packet version (default: 20220406): "
if "%PACKETVER%"=="" set PACKETVER=20220406

REM Verify MySQL service
sc query MySQL | find "RUNNING" >nul
if %errorLevel% neq 0 (
    echo MySQL service is not running. Please start MySQL and rerun the script.
    pause
    exit /b 1
)

REM Set up MySQL database
echo Setting up MySQL database...
mysql -e "CREATE DATABASE %DB_NAME%;"
mysql -e "CREATE USER '%DB_USER%'@'localhost' IDENTIFIED BY '%DB_PASS%';"
mysql -e "CREATE USER '%DB_USER%'@'%%' IDENTIFIED BY '%DB_PASS%';"
mysql -e "GRANT ALL PRIVILEGES ON %DB_NAME%.* TO '%DB_USER%'@'localhost' WITH GRANT OPTION;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '%DB_USER%'@'%%' WITH GRANT OPTION;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '%DB_USER%'@'localhost' WITH GRANT OPTION;"
mysql -e "CREATE DATABASE log;"
mysql -e "GRANT ALL ON log.* TO '%DB_USER%'@'localhost';"

REM Import SQL files
echo Importing SQL files...
cd C:\rAthena

REM Import main database tables
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\main.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\web.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\roulette_default_data.sql
mysql -u %DB_USER% -p%DB_PASS% log < sql-files\logs.sql

REM Pre-Renewal
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\item_db.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\item_db_equip.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\item_db_etc.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\item_db_usable.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\item_db2.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\mob_db.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\mob_db2.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\mob_skill_db.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\mob_skill_db2.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\compatibility\item_db_compat.sql
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\compatibility\item_db2_compat.sql

REM Common files
mysql -u %DB_USER% -p%DB_PASS% %DB_NAME% < sql-files\tools\convert_engine_innodb.sql

REM Create admin account
echo Creating admin account...
mysql -e "INSERT INTO `%DB_NAME%`.`login` (`account_id`, `userid`, `user_pass`, `sex`, `email`, `group_id`, `state`, `unban_time`, `expiration_time`, `logincount`, `lastlogin`, `last_ip`, `birthdate`, `character_slots`, `pincode`, `pincode_change`, `vip_time`, `old_group`) VALUES ('20000000', '%ADMIN_USER%', '%ADMIN_PASS%', 'M', 'admin@email.com', '99', '0', '0', '0', '0', '2022-02-20 00:00:00', '', '2022-02-20', '9', '', '0', '0', '0');"

REM Clone rAthena (assume already done, or add git clone)
if not exist C:\rAthena (
    git clone https://github.com/rathena/rathena.git C:\rAthena
    cd C:\rAthena
    git pull
) else (
    cd C:\rAthena
    git pull
)

REM Create import directory
if not exist conf\import mkdir conf\import

REM Configure files
echo Configuring char_conf.txt...
(
echo // Server Communication username and password.
echo userid: %SERVER_COM_USER%
echo passwd: %SERVER_COM_PASS%
echo // Server name
echo server_name: %SERVER_NAME%
echo // Login Server IP
echo login_ip: %SERVER_IP%
echo // Character Server IP
echo char_ip: %SERVER_IP%
) > conf\import\char_conf.txt

echo Configuring inter_conf.txt...
(
echo // MySQL Login server
echo login_server_ip: localhost
echo login_server_port: 3306
echo login_server_id: %DB_USER%
echo login_server_pw: %DB_PASS%
echo login_server_db: %DB_NAME%
echo login_codepage:
echo login_case_sensitive: yes
echo.
echo ipban_db_ip: localhost
echo ipban_db_port: 3306
echo ipban_db_id: %DB_USER%
echo ipban_db_pw: %DB_PASS%
echo ipban_db_db: %DB_NAME%
echo ipban_codepage:
echo.
echo // MySQL Character server
echo char_server_ip: localhost
echo char_server_port: 3306
echo char_server_id: %DB_USER%
echo char_server_pw: %DB_PASS%
echo char_server_db: %DB_NAME%
echo.
echo // MySQL Map Server
echo map_server_ip: localhost
echo map_server_port: 3306
echo map_server_id: %DB_USER%
echo map_server_pw: %DB_PASS%
echo map_server_db: %DB_NAME%
echo.
echo // MySQL Web Server
echo web_server_ip: localhost
echo web_server_port: 3306
echo web_server_id: %DB_USER%
echo web_server_pw: %DB_PASS%
echo web_server_db: %DB_NAME%
echo.
echo // MySQL Log Database
echo log_db_ip: localhost
echo log_db_port: 3306
echo log_db_id: %DB_USER%
echo log_db_pw: %DB_PASS%
echo log_db_db: log
echo log_codepage:
echo log_login_db: loginlog
) > conf\import\inter_conf.txt

echo Configuring map_conf.txt...
(
echo userid: %SERVER_COM_USER%
echo passwd: %SERVER_COM_PASS%
echo char_ip: %SERVER_IP%
echo char_port: 6121
echo map_ip: %SERVER_IP%
echo map_port: 5121
) > conf\import\map_conf.txt

REM Update login table
mysql -u %DB_USER% -p%DB_PASS% -D %DB_NAME% -e "UPDATE login SET userid='%SERVER_COM_USER%', user_pass='%SERVER_COM_PASS%' WHERE account_id=1;"

REM Compile (assume Visual Studio Developer Command Prompt is used)
echo Compiling the server...
REM Note: This assumes the script is run in VS Developer CMD
configure.bat --enable-packetver=%PACKETVER% --enable-prere=yes --enable-vip=no --enable-64bit=yes --enable-debug=no
nmake clean
nmake server

REM Start server
echo Starting the server...
athena-start start

echo Setup complete! Your rAthena server is now running.
pause
