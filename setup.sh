#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_message() {
    echo -e "${2}${1}${NC}"
}

# Function to prompt for input
prompt_input() {
    local prompt="$1"
    local var_name="$2"
    local default="$3"
    
    if [ -n "$default" ]; then
        read -p "$prompt [$default]: " input
        input=${input:-$default}
    else
        read -p "$prompt: " input
    fi
    
    eval "$var_name=$input"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    print_message "Please run as root (use sudo)" "$RED"
    exit 1
fi

# Get system information
print_message "=== Ragnarok Online Server Setup Script ===" "$GREEN"
print_message "This script will help you set up your rAthena server." "$YELLOW"

# Prompt for variables
prompt_input "Enter your database name" "DB_NAME" "ragnarok"
prompt_input "Enter your MySQL username" "DB_USER" "ragnarok"
prompt_input "Enter your MySQL password" "DB_PASS" "ragnarok"
prompt_input "Enter your server name" "SERVER_NAME" "MyRO"
prompt_input "Enter your server's public IP" "SERVER_IP"
prompt_input "Enter your admin username" "ADMIN_USER" "admin"
prompt_input "Enter your admin password" "ADMIN_PASS" "admin"
prompt_input "Enter server communication username" "SERVER_COM_USER" "s1"
prompt_input "Enter server communication password" "SERVER_COM_PASS" "p1"

# Update system
print_message "\nUpdating system..." "$YELLOW"
apt update && apt upgrade -y

# Install dependencies
print_message "Installing dependencies..." "$YELLOW"
apt install -y build-essential zlib1g-dev libpcre3-dev \
    libmariadb-dev libmariadb-dev-compat \
    php phpmyadmin mysql-server mysql-client \
    nano git make gcc g++ \
    libmysqlclient-dev libssl-dev libzlib1g-dev

# Add PHP repository
add-apt-repository ppa:ondrej/php -y

# Clone rAthena
print_message "Cloning rAthena repository..." "$YELLOW"
cd /home
git clone https://github.com/rathena/rathena.git
cd rAthena
git pull

# Configure MySQL
print_message "Configuring MySQL..." "$YELLOW"
mysql -e "CREATE DATABASE $DB_NAME;"
mysql -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"
mysql -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'localhost' WITH GRANT OPTION;"
mysql -e "CREATE DATABASE log;"
mysql -e "GRANT ALL ON log.* TO '$DB_USER'@'localhost';"

# Import SQL files
print_message "Importing SQL files..." "$YELLOW"
cd sql-files

# Main database imports
for sql_file in main.sql roulette_default_data.sql item_cash_db.sql item_cash_db2.sql \
    item_db.sql item_db2.sql item_db_re.sql item_db2_re.sql \
    mob_db.sql mob_db2.sql mob_db_re.sql mob_db2_re.sql \
    mob_skill_db.sql mob_skill_db2.sql produce_db.sql \
    quest_db.sql quest_db_re.sql shop_db.sql shop_db2.sql \
    skill_db.sql skill_db2.sql skill_db_re.sql skill_db2_re.sql; do
    print_message "Importing $sql_file..." "$YELLOW"
    mysql -u$DB_USER -p$DB_PASS $DB_NAME < $sql_file
done

# Log database import
mysql -u$DB_USER -p$DB_PASS log < logs.sql

# Create admin account
print_message "Creating admin account..." "$YELLOW"
mysql -e "INSERT INTO \`$DB_NAME\`.\`login\` (\`account_id\`, \`userid\`, \`user_pass\`, \`sex\`, \`email\`, \`group_id\`, \`state\`, \`unban_time\`, \`expiration_time\`, \`logincount\`, \`lastlogin\`, \`last_ip\`, \`birthdate\`, \`character_slots\`, \`pincode\`, \`pincode_change\`, \`vip_time\`, \`old_group\`) VALUES ('20000000', '$ADMIN_USER', '$ADMIN_PASS', 'M', 'admin@email.com', '99', '0', '0', '0', '0', '2022-02-20 00:00:00', '', '2022-02-20', '9', '', '0', '0', '0');"

# Configure server files
print_message "Configuring server files..." "$YELLOW"
cd ../conf

# Configure char_athena.conf
sed -i "s/userid: s1/userid: $SERVER_COM_USER/" char_athena.conf
sed -i "s/passwd: p1/passwd: $SERVER_COM_PASS/" char_athena.conf
sed -i "s/server_name: rAthena/server_name: $SERVER_NAME/" char_athena.conf
sed -i "s/login_ip: 127.0.0.1/login_ip: $SERVER_IP/" char_athena.conf
sed -i "s/char_ip: 127.0.0.1/char_ip: $SERVER_IP/" char_athena.conf

# Configure inter_athena.conf
sed -i "s/login_server_id: s1/login_server_id: $DB_USER/" inter_athena.conf
sed -i "s/login_server_pw: p1/login_server_pw: $DB_PASS/" inter_athena.conf
sed -i "s/login_server_db: ragnarok/login_server_db: $DB_NAME/" inter_athena.conf
sed -i "s/ipban_db_id: s1/ipban_db_id: $DB_USER/" inter_athena.conf
sed -i "s/ipban_db_pw: p1/ipban_db_pw: $DB_PASS/" inter_athena.conf
sed -i "s/ipban_db_db: ragnarok/ipban_db_db: $DB_NAME/" inter_athena.conf
sed -i "s/char_server_id: s1/char_server_id: $DB_USER/" inter_athena.conf
sed -i "s/char_server_pw: p1/char_server_pw: $DB_PASS/" inter_athena.conf
sed -i "s/char_server_db: ragnarok/char_server_db: $DB_NAME/" inter_athena.conf
sed -i "s/map_server_id: s1/map_server_id: $DB_USER/" inter_athena.conf
sed -i "s/map_server_pw: p1/map_server_pw: $DB_PASS/" inter_athena.conf
sed -i "s/map_server_db: ragnarok/map_server_db: $DB_NAME/" inter_athena.conf
sed -i "s/web_server_id: s1/web_server_id: $DB_USER/" inter_athena.conf
sed -i "s/web_server_pw: p1/web_server_pw: $DB_PASS/" inter_athena.conf
sed -i "s/web_server_db: ragnarok/web_server_db: $DB_NAME/" inter_athena.conf
sed -i "s/log_db_id: s1/log_db_id: $DB_USER/" inter_athena.conf
sed -i "s/log_db_pw: p1/log_db_pw: $DB_PASS/" inter_athena.conf

# Configure map_athena.conf
sed -i "s/userid: s1/userid: $SERVER_COM_USER/" map_athena.conf
sed -i "s/passwd: p1/passwd: $SERVER_COM_PASS/" map_athena.conf
sed -i "s/\/\/char_ip: 127.0.0.1/char_ip: $SERVER_IP/" map_athena.conf
sed -i "s/\/\/char_port: 6121/char_port: 6121/" map_athena.conf
sed -i "s/\/\/map_ip: 127.0.0.1/map_ip: $SERVER_IP/" map_athena.conf
sed -i "s/\/\/map_port: 5121/map_port: 5121/" map_athena.conf

# Set permissions
print_message "Setting permissions..." "$YELLOW"
cd ..
chmod a+x ./configure

# Compile server
print_message "Compiling server..." "$YELLOW"
./configure --enable-packetver=20220406 --enable-prere=yes --enable-vip=no --enable-64bit=yes --enable-debug=no
make clean
make server
chmod a+x login-server char-server map-server

print_message "\nSetup completed successfully!" "$GREEN"
print_message "You can now start your server using: ./athena-start start" "$YELLOW"
print_message "Default admin account:" "$YELLOW"
print_message "Username: $ADMIN_USER" "$YELLOW"
print_message "Password: $ADMIN_PASS" "$YELLOW"
print_message "\nDon't forget to configure your firewall to allow the following ports:" "$YELLOW"
print_message "- 3306 (MySQL)" "$YELLOW"
print_message "- 6900 (Login Server)" "$YELLOW"
print_message "- 6121 (Char Server)" "$YELLOW"
print_message "- 5121 (Map Server)" "$YELLOW" 