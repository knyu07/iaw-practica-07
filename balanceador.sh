#!/bin/bash

#VARIABLES
IP_FRONTEND_1=34.238.85.119
IP_FRONTEND_2=54.196.137.100 

# Actualizacion de los repositorios de la maquina.
apt update

# Instalacion de nginx.
apt install nginx -y

# Modificiacion dl fichero de configuracion.
cd /home/ubuntu
git clone https://github.com/knyu07/iaw-practica-07
mv iaw-practica-07/default /etc/nginx/sites-available
rm -r /home/ubuntu/iaw-practica-07

#Cambiamos los permisos
chown www-data:www-data * -R

#Asignamos variables
sed -i "s/IP_FRONTEND_1/$IP_FRONTEND_1/" /etc/nginx/sites-available/default
sed -i "s/IP_FRONTEND_2/$IP_FRONTEND_2/" /etc/nginx/sites-available/default

# Reiniciar nginx.
service nginx restart
