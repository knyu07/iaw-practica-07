#!/bin/bash
set -x

#VARIABLES
BD_ROOT_PASSWD=root
IP_MYSQL=172.31.95.64

# Actualizamos la lista de paquetes
apt update

#Instalamos las librerias de PHP para MySQL
apt-get install debconf-utils -y
apt-get install php libapache2-mod-php php-mysql -y

#Estamos estableciendo la contraseña del usuario root en MySQL
debconf-set-selections <<<"mysql-server mysql-server/root_password password $DB_ROOT_PASSWD"
debconf-set-selections <<<"mysql-server mysql-server/root_password_again password $DB_ROOT_PASSWD"

# Instalamos el MySQL Server
apt install mysql-server -y

# Actualizamos la contraseña de root de MySQL
mysql -u root <<< "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$BD_ROOT_PASSWD';"

# --------------------------------------------------------------------------------
# Ejecutamos el script de base de datos de la aplicación web
# --------------------------------------------------------------------------------

# Clonamos el repositorio
cd /home/ubuntu
rm -rf iaw-practica-lamp
git clone https://github.com/josejuansanchez/iaw-practica-lamp

# Importamos el script de creación de la base de datos
mysql -u root -p$BD_ROOT_PASSWD < /home/ubuntu/iaw-practica-lamp/db/database.sql

#-----------------------------------------#

#Configuramos MySQL para permitir conexiones desde la IP privada de la instancia

sudo sed -i "s/127.0.0.1/$IP_MYSQL/" /etc/mysql/mysql.conf.d/mysqld.cnf

#Reiniciamos servicio MySQL
systemctl restart mysql.service 
