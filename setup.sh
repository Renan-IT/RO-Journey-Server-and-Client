#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install essential dependencies
install_dependency() {
    PACKAGE=$1
    echo "Installing $PACKAGE..."
    if ! sudo apt install -y $PACKAGE; then
        echo "Failed to install $PACKAGE. Exiting."
        exit 1
    fi
}

# Install each dependency separately with verification
install_dependency build-essential
install_dependency zlib1g-dev
install_dependency libpcre3-dev
install_dependency libmariadb-dev
install_dependency libmariadb-dev-compat
install_dependency software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
install_dependency php
# install_dependency phpmyadmin  # Commented out as per guide
install_dependency mysql-server
install_dependency mysql-client
install_dependency nano
install_dependency git
install_dependency make
install_dependency gcc
install_dependency g++
install_dependency libmysqlclient-dev
install_dependency libssl-dev
install_dependency screen

sudo apt autoremove -y
sudo apt clean

# Verify installation of essential dependencies
echo "Verifying installation of essential dependencies..."
for pkg in build-essential zlib1g-dev libpcre3-dev libmariadb-dev libmariadb-dev-compat software-properties-common php mysql-server mysql-client nano git make gcc g++ libmysqlclient-dev libssl-dev screen; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
        echo "Error: $pkg is not installed. Exiting setup."
        exit 1
    fi
done
echo "All dependencies installed successfully."

# Prompt for user inputs
echo "Please enter the following details:"
read -p "Database name (default: ragnarok): " DB_NAME
DB_NAME=${DB_NAME:-ragnarok}
read -p "MySQL username (default: ragnarok): " DB_USER
DB_USER=${DB_USER:-ragnarok}
read -p "MySQL password (default: ragnarok): " DB_PASS
DB_PASS=${DB_PASS:-ragnarok}
read -p "Server name (default: MyRO): " SERVER_NAME
SERVER_NAME=${SERVER_NAME:-MyRO}
read -p "Server's public IP: " SERVER_IP
read -p "Admin username (default: admin): " ADMIN_USER
ADMIN_USER=${ADMIN_USER:-admin}
read -p "Admin password (default: admin): " ADMIN_PASS
ADMIN_PASS=${ADMIN_PASS:-admin}
read -p "Server communication username (default: s1): " SERVER_COM_USER
SERVER_COM_USER=${SERVER_COM_USER:-s1}
read -p "Server communication password (default: p1): " SERVER_COM_PASS
SERVER_COM_PASS=${SERVER_COM_PASS:-p1}
read -p "Packet version (default: 20220406): " PACKETVER
PACKETVER=${PACKETVER:-20220406}

# Verify MySQL service is running
echo "Verifying MySQL service status..."
systemctl is-active --quiet mysql || { echo "MySQL service is not running. Please start MySQL and rerun the script."; exit 1; }

# Setting Up the MySQL Database
echo "Setting up MySQL database..."
mysql -e "CREATE DATABASE $DB_NAME;"
mysql -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
mysql -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;"
mysql -e "CREATE DATABASE log;"
mysql -e "GRANT ALL ON log.* TO '$DB_USER'@'localhost';"

# Import SQL files
echo "Importing SQL files..."
cd ~/rAthena

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

# Common required files
# Note: Replace (date).sql with the most recent upgrade file, e.g., 2023-01-01.sql
# For now, assuming a placeholder; user should check for the latest
# mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/upgrades/(date).sql
mysql -u $DB_USER -p$DB_PASS $DB_NAME < sql-files/tools/convert_engine_innodb.sql

# Create admin account
echo "Creating admin account..."
mysql -e "INSERT INTO \`$DB_NAME\`.\`login\` (\`account_id\`, \`userid\`, \`user_pass\`, \`sex\`, \`email\`, \`group_id\`, \`state\`, \`unban_time\`, \`expiration_time\`, \`logincount\`, \`lastlogin\`, \`last_ip\`, \`birthdate\`, \`character_slots\`, \`pincode\`, \`pincode_change\`, \`vip_time\`, \`old_group\`) VALUES ('20000000', '$ADMIN_USER', '$ADMIN_PASS', 'M', 'admin@email.com', '99', '0', '0', '0', '0', '2022-02-20 00:00:00', '', '2022-02-20', '9', '', '0', '0', '0');"

# Clone the rAthena Repository
echo "Cloning the rAthena repository..."
USER_HOME="/home/$(logname)"
RATHENA_DIR="$USER_HOME/rAthena"
if [ -d "$RATHENA_DIR" ]; then
    echo "Removing existing rAthena directory..."
    rm -rf "$RATHENA_DIR"
fi
git clone https://github.com/rathena/rathena.git "$RATHENA_DIR"
cd "$RATHENA_DIR"
git pull

# Create import directory if it doesn't exist
if [ ! -d "$RATHENA_DIR/conf/import" ]; then
    mkdir -p "$RATHENA_DIR/conf/import"
fi

# Configure server files using the import directory
echo "Configuring server files using the import directory..."
cd "$RATHENA_DIR/conf/import"

# Create or modify configuration files
touch char_conf.txt inter_conf.txt map_conf.txt

# Configure each file
echo "Configuring char_conf.txt..."
cat > char_conf.txt << EOF
// Server Communication username and password.
userid: $SERVER_COM_USER
passwd: $SERVER_COM_PASS
// Server name, use alternative character such as ASCII 160 for spaces.
server_name: $SERVER_NAME
// Login Server IP
login_ip: $SERVER_IP
// Character Server IP
char_ip: $SERVER_IP
EOF

echo "Configuring inter_conf.txt..."
cat > inter_conf.txt << EOF
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
EOF

echo "Configuring map_conf.txt..."
cat > map_conf.txt << EOF
userid: $SERVER_COM_USER
passwd: $SERVER_COM_PASS
char_ip: $SERVER_IP
char_port: 6121
map_ip: $SERVER_IP
map_port: 5121
EOF

# Update the login table for server communication
echo "Updating login table for server communication..."
mysql -u $DB_USER -p$DB_PASS -D $DB_NAME -e "UPDATE login SET userid='$SERVER_COM_USER', user_pass='$SERVER_COM_PASS' WHERE account_id=1;"

# Compile the server
echo "Compiling the server..."
cd "$RATHENA_DIR"
./configure --enable-packetver=$PACKETVER --enable-prere=yes --enable-vip=no --enable-64bit=yes --enable-debug=no
make clean
make server

# Set execute permissions
echo "Setting execute permissions..."
sudo chmod a+x login-server char-server map-server

# Start the server in a screen session
echo "Starting the server in a screen session..."
screen -dmS rathena_server ./athena-start start

echo "Setup complete! Your rAthena server is now running in a screen session named 'rathena_server'."
