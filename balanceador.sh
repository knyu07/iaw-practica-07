#!/bin/bash

#VARIABLES
IP_FRONTEND_1=52.201.221.167
IP_FRONTEND_2=52.201.212.21

# Actualizacion de los repositorios de la maquina.
apt update

# Instalacion de nginx.
apt install nginx -y

# Modificiacion dl fichero de configuracion.
cd /home/ubuntu
git clone https://github.com/knyu07/iaw-practica-07
mv iaw-practica-07/default /etc/nginx/sites-available
rm -r /home/ubuntu/iaw-practica-07

#Asignamos variables
sed -i "s/IP_FRONTEND_1/$IP_FRONTEND_1/" /etc/nginx/nginx.conf
sed -i "s/IP_FRONTEND_2/$IP_FRONTEND_2/" /etc/nginx/nginx.conf

# Reiniciar nginx.
service nginx restart
