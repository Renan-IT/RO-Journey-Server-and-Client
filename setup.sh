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

# Remove existing directory if it exists to avoid conflicts
if [ -d "$RATHENA_DIR" ]; then
    echo "Removing existing rAthena directory..."
    rm -rf "$RATHENA_DIR"
fi

git clone https://github.com/rathena/rathena.git "$RATHENA_DIR"
cd "$RATHENA_DIR"
git pull

# Configure server files
echo "Configuring server files..."
sed -i "s/^userid:.*$/userid: $SERVER_COM_USER/" conf/char_athena.conf
sed -i "s/^passwd:.*$/passwd: $SERVER_COM_PASS/" conf/char_athena.conf
sed -i "s/^server_name:.*$/server_name: $SERVER_NAME/" conf/char_athena.conf
sed -i "s/^login_ip:.*$/login_ip: $SERVER_IP/" conf/char_athena.conf
sed -i "s/^char_ip:.*$/char_ip: $SERVER_IP/" conf/char_athena.conf
sed -i "s/^map_ip:.*$/map_ip: $SERVER_IP/" conf/char_athena.conf

# Configure inter_athena.conf
echo "Configuring inter_athena.conf..."
sed -i "s/login_server_ip: 127.0.0.1/login_server_ip: localhost/" conf/inter_athena.conf
sed -i "s/login_server_port: 3306/login_server_port: 3306/" conf/inter_athena.conf
sed -i "s/login_server_id: ragnarok/login_server_id: $DB_USER/" conf/inter_athena.conf
sed -i "s/login_server_pw: ragnarok/login_server_pw: $DB_PASS/" conf/inter_athena.conf
sed -i "s/login_server_db: ragnarok/login_server_db: $DB_NAME/" conf/inter_athena.conf

sed -i "s/ipban_db_ip: 127.0.0.1/ipban_db_ip: localhost/" conf/inter_athena.conf
sed -i "s/ipban_db_port: 3306/ipban_db_port: 3306/" conf/inter_athena.conf
sed -i "s/ipban_db_id: ragnarok/ipban_db_id: $DB_USER/" conf/inter_athena.conf
sed -i "s/ipban_db_pw: ragnarok/ipban_db_pw: $DB_PASS/" conf/inter_athena.conf
sed -i "s/ipban_db_db: ragnarok/ipban_db_db: $DB_NAME/" conf/inter_athena.conf

sed -i "s/char_server_ip: 127.0.0.1/char_server_ip: localhost/" conf/inter_athena.conf
sed -i "s/char_server_port: 3306/char_server_port: 3306/" conf/inter_athena.conf
sed -i "s/char_server_id: ragnarok/char_server_id: $DB_USER/" conf/inter_athena.conf
sed -i "s/char_server_pw: ragnarok/char_server_pw: $DB_PASS/" conf/inter_athena.conf
sed -i "s/char_server_db: ragnarok/char_server_db: $DB_NAME/" conf/inter_athena.conf

sed -i "s/map_server_ip: 127.0.0.1/map_server_ip: localhost/" conf/inter_athena.conf
sed -i "s/map_server_port: 3306/map_server_port: 3306/" conf/inter_athena.conf
sed -i "s/map_server_id: ragnarok/map_server_id: $DB_USER/" conf/inter_athena.conf
sed -i "s/map_server_pw: ragnarok/map_server_pw: $DB_PASS/" conf/inter_athena.conf
sed -i "s/map_server_db: ragnarok/map_server_db: $DB_NAME/" conf/inter_athena.conf

sed -i "s/web_server_ip: 127.0.0.1/web_server_ip: localhost/" conf/inter_athena.conf
sed -i "s/web_server_port: 3306/web_server_port: 3306/" conf/inter_athena.conf
sed -i "s/web_server_id: ragnarok/web_server_id: $DB_USER/" conf/inter_athena.conf
sed -i "s/web_server_pw: ragnarok/web_server_pw: $DB_PASS/" conf/inter_athena.conf
sed -i "s/web_server_db: ragnarok/web_server_db: $DB_NAME/" conf/inter_athena.conf

sed -i "s/log_db_ip: 127.0.0.1/log_db_ip: localhost/" conf/inter_athena.conf
sed -i "s/log_db_port: 3306/log_db_port: 3306/" conf/inter_athena.conf
sed -i "s/log_db_id: ragnarok/log_db_id: $DB_USER/" conf/inter_athena.conf
sed -i "s/log_db_pw: ragnarok/log_db_pw: $DB_PASS/" conf/inter_athena.conf
sed -i "s/log_db_db: ragnarok/log_db_db: $DB_NAME/" conf/inter_athena.conf

# Configure map_athena.conf
echo "Configuring map_athena.conf..."
sed -i "s/^userid:.*$/userid: $SERVER_COM_USER/" conf/map_athena.conf
sed -i "s/^passwd:.*$/passwd: $SERVER_COM_PASS/" conf/map_athena.conf
sed -i "s|^//\?char_ip:.*$|char_ip: $SERVER_IP|" conf/map_athena.conf
sed -i "s|^//\?char_port:.*$|char_port: 6121|" conf/map_athena.conf
sed -i "s|^//\?map_ip:.*$|map_ip: $SERVER_IP|" conf/map_athena.conf
sed -i "s|^//\?map_port:.*$|map_port: 5121|" conf/map_athena.conf

# Compile the server
echo "Compiling the server..."
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
