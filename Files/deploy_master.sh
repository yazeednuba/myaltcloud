#!/bin/bash

# Update package lists
#sudo apt update

# Install Apache
sudo apt install -y apache2

# Install MySQL
sudo apt install -y mysql-server

# Install PHP
sudo apt install -y php libapache2-mod-php php-mysql

# Clone PHP application from github
#git clone https://github.com/laravel/laravel.git /var/www/html/laravel

# Configure Apache
sudo chown -R www-data:www-data /var/www/html/laravel
sudo chmod -R 755 /var/www/html/laravel

# Restart Apache
sudo systemctl restart apache2

echo "LAMP dependencies installed."

# Just disregard, just for fun
for ((i = 1; i <= 5; i++)); do
    # Print i dashes
    for ((j = 1; j <= i; j++)); do
        echo -n "-"
    done

    echo ""
done

echo "Configuring Apache"

# Apache Configuration
# Enable mod_rewrite
sudo a2enmod rewrite

# Set up virtual host for the PHP application
sudo cat <<EOF > /etc/apache2/sites-available/phpapp.conf
<VirtualHost *:80>
    ServerAdmin webmaster@example.com
    DocumentRoot /var/www/laravel
    ServerName example.com
    ServerAlias www.example.com

    <Directory /var/www/html/laravel>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

# Enable the virtual host
sudo a2ensite laravel

echo "Finished Apache Conf"


for ((i = 1; i <= 5; i++)); do
    for ((j = 1; j <= i; j++)); do
        echo -n "-"
    done
    echo ""
done

echo "Configuring mysql"

# MySQL Configuration
# Install MySQL server
#sudo apt-get install -y mysql-server

# Secure MySQL installation
sudo mysql_secure_installation <<EOF

y
n
n
n
n
EOF

# Create MySQL database and user for the PHP application
sudo mysql -e "CREATE DATABASE IF NOT EXISTS altcloudb;"
sudo mysql -e "CREATE USER 'altschoolcloud'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON altcloud.* TO 'altschoolcloud'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

echo "Finshed mySQL Conf"
for ((i = 1; i <= 5; i++)); do
    for ((j = 1; j <= i; j++)); do
        echo -n "--"
    done
    echo ""
done

echo "Configuring PHP"

# PHP Configuration
# Install PHP and required modules
#sudo apt-get install -y php libapache2-mod-php php-mysql

# Adjust PHP settings if needed (e.g., memory_limit, max_execution_time)

# Restart Apache to apply changes
sudo systemctl restart apache2

# Testing
# Verify Apache and MySQL services are running
sudo systemctl status apache2
sudo systemctl status mysql

# Test PHP application accessibility through the web browser
