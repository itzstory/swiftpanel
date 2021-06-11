#!/bin/bash
sudo yum -y install epel-release wget subversion git mariadb-server
service mariadb start
mysql_secure_installation -n -n -n -n -y
mysql -uroot -p$spass -e "CREATE DATABASE gpstory; CREATE USER 'gpstory'@localhost IDENTIFIED BY 'gpstory22'; GRANT ALL PRIVILEGES ON gpstory.* TO 'gpstory'@localhost; use gpstory;"

yum install php-mysql php-gd php-imap php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrp -y
yum install php -y
yum search php -y
yum install php-mysql php-gd php-imap php-ldap php-mbstring php-odbc php-pear php-xml php-xmlrpc -y
yum install php-pecl-apc -y
systemctl restart httpd

cd /tmp
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar -zxvf ioncube_loaders_lin_x86*
cd ioncube/
php -i | grep extension_dir
extension_dir => /usr/lib64/php/modules => /usr/lib64/php/modules
cp /tmp/ioncube/ioncube_loader_lin_5.4.so /usr/lib64/php/modules
sudo yum install nano
echo "zend_extension = /usr/lib64/php/modules/ioncube_loader_lin_5.4.so" >> /etc/php.ini
systemctl restart httpd

cd
yum install gcc php-devel php-pear libssh2 libssh2-devel
pecl install -f ssh2
touch /etc/php.d/ssh2.ini
echo extension=ssh2.so > /etc/php.d/ssh2.ini
systemctl restart httpd


cd /var/www/html
rm -rf index.html
yum install unzip
wget https://github.com/zer0xpl0ide/Swift-Panel/raw/master/SwiftPanel.zip
unzip SwiftPanel.zip
rm -rf SwiftPanel.zip
rm -rf configuration-dist.php
cd .. 
chmod -R 777 html

cat <<EOF > /var/www/html/configuration.php 
<?php 
define('LICENSE','lgnoreMe');
define('DBHOST','localhost');
define('DBNAME','gpstory');
define('DBUSER','gpstory');
define('DBPASSWORD','gpstory22'); 
?>
EOF
service httpd restart
sudo yum -y install epel-release wget subversion git mariadb-server

clear

echo "."
echo "."
echo "Completed"
echo "DB User: gpstory"
echo "DB Name: gpstory"
echo "DB Pass: gpstory22"
echo "After installation, remove folder /install/ manually"
