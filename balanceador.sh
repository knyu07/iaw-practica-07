#!/bin/bash

# Actualizacion de los repositorios de la maquina.
apt update

# Instalacion de nginx.
apt install nginx -y

# Modificiacion dl fichero de configuracion.
cd /home/ubuntu
git clone https://github.com/knyu07/iaw-practica-07
mv iaw-practica-07/nginx.conf /etc/nginx/
rm -r /home/ubuntu/iaw-practica-07

# Reiniciar nginx.
service nginx restart
