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
    if ! sudo apt install -y $1; then
        echo "Failed to install $1. Exiting."
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
install_dependency phpmyadmin
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
for pkg in build-essential zlib1g-dev libpcre3-dev libmariadb-dev libmariadb-dev-compat software-properties-common php phpmyadmin mysql-server mysql-client nano git make gcc g++ libmysqlclient-dev libssl-dev screen; do
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
if [ ! -d "$RATHENA_DIR/import" ]; then
    mkdir "$RATHENA_DIR/import"
fi

# Configure server files using the import directory
echo "Configuring server files using the import directory..."
cd "$RATHENA_DIR/import"

# Create or modify configuration files
touch char_athena.conf inter_athena.conf map_athena.conf

# Configure each file
echo "Configuring char_athena.conf..."
echo "userid: $SERVER_COM_USER" > char_athena.conf
echo "passwd: $SERVER_COM_PASS" >> char_athena.conf
echo "server_name: $SERVER_NAME" >> char_athena.conf
echo "login_ip: $SERVER_IP" >> char_athena.conf
echo "char_ip: $SERVER_IP" >> char_athena.conf

echo "Configuring inter_athena.conf..."
echo "login_server_ip: localhost" > inter_athena.conf
echo "login_server_port: 3306" >> inter_athena.conf
echo "login_server_id: $DB_USER" >> inter_athena.conf
echo "login_server_pw: $DB_PASS" >> inter_athena.conf
echo "login_server_db: $DB_NAME" >> inter_athena.conf
echo "char_server_ip: localhost" >> inter_athena.conf
echo "char_server_port: 3306" >> inter_athena.conf
echo "char_server_id: $DB_USER" >> inter_athena.conf
echo "char_server_pw: $DB_PASS" >> inter_athena.conf
echo "char_server_db: $DB_NAME" >> inter_athena.conf
echo "map_server_ip: localhost" >> inter_athena.conf
echo "map_server_port: 3306" >> inter_athena.conf
echo "map_server_id: $DB_USER" >> inter_athena.conf
echo "map_server_pw: $DB_PASS" >> inter_athena.conf
echo "map_server_db: $DB_NAME" >> inter_athena.conf
echo "log_db_ip: localhost" >> inter_athena.conf
echo "log_db_port: 3306" >> inter_athena.conf
echo "log_db_id: $DB_USER" >> inter_athena.conf
echo "log_db_pw: $DB_PASS" >> inter_athena.conf
echo "log_db_db: log" >> inter_athena.conf

echo "Configuring map_athena.conf..."
echo "userid: $SERVER_COM_USER" > map_athena.conf
echo "passwd: $SERVER_COM_PASS" >> map_athena.conf
echo "char_ip: $SERVER_IP" >> map_athena.conf
echo "char_port: 6121" >> map_athena.conf
echo "map_ip: $SERVER_IP" >> map_athena.conf
echo "map_port: 5121" >> map_athena.conf

# Compile the server
echo "Compiling the server..."
cd "$RATHENA_DIR"
./configure --enable-prere=yes --enable-vip=no --enable-64bit=yes --enable-debug=no
make clean
make server

# Set execute permissions
echo "Setting execute permissions..."
sudo chmod a+x login-server char-server map-server

# Start the server in a screen session
echo "Starting the server in a screen session..."
screen -dmS rathena_server ./athena-start start

echo "Setup complete! Your rAthena server is now running in a screen session named 'rathena_server'."
