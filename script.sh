#!/bin/bash

sudo apt update

#Create a user
sudo useradd -m -G sudo appuser
sudo passwd appuser

#Install nginx
sudo apt install nginx -y

# sudo systemctl status nginx
# sudo systemctl stop nginx
# sudo systemctl start nginx
# sudo systemctl restart nginx
# sudo systemctl reload nginx

#Nginx directories
# /etc/nginx - configuration
# /var/www/html - The actual web content
# /var/log/nginx/access.log
# /var/log/nginx/error.log

#Install let's encrypt
sudo apt install certbot -y
sudo apt install certbot python3-certbot-nginx -y

# website_name=impulsetechs.com

# sudo mkdir -p /var/www/$website_name/html
# sudo chown -R $USER:$USER /var/www/$website_name/html
# sudo chmod -R 755 /var/www/$website_name

# sudo nano /etc/nginx/sites-available/$website_name

##Add it to the file
# server {
#         listen 80;
#         listen [::]:80;

#         root /var/www/$website_name/html;
#         index index.html index.htm index.nginx-debian.html;

#         server_name $website_name www.$website_name;

#         location / {
#                 try_files $uri $uri/ =404;
#         }
# }

##Create a link
# sudo ln -s /etc/nginx/sites-available/$website_name /etc/nginx/sites-enabled/

##Edit nginx.conf
# sudo nano /etc/nginx/nginx.conf

##Uncoment 
# ...
# http {
#     ...
#     server_names_hash_bucket_size 64;
#     ...
# }
# ...

#Check configuration
sudo nginx -t

#Reload nginx
sudo nginx -s reload

#Obtain certificate
sudo certbot --nginx -d web.com -d www.web.com

#Restart nginx
sudo systemctl restart nginx

sudo certbot renew --dry-run

cd /var/www/
git clone https://github.com/sizykhpa/portfolio_home_page.git 
sudo mv portfolio_home_page/* html/ && sudo rm -r portfolio_home_page
git clone https://github.com/sizykhpa/memory_game.git && git clone https://github.com/sizykhpa/meme_generator.git && git clone https://github.com/sizykhpa/connect_four.git && git clone https://github.com/sizykhpa/todo_app.git


#install newer version Python
cd /home
sudo git clone https://github.com/impulset/install_python_ubuntu_16_18.git
cd install_python_ubuntu_16_18
sudo chmod 700 script.sh
sudo ./script.sh


#Install aiohttp and gunicorn
pip3.8 install aiohttp
pip3.8 install gunicorn


#Nginx configuration for Aiohttp and gunicorn 
#Edit /etc/nginx/sites-available/default


#create app directory
mkdir -p /home/ubuntu/app
cd /home/ubuntu/app

#start app
gunicorn main:app --bind localhost:8080 --worker-class aiohttp.GunicornWebWorker

sudo systemctl daemon-reload
sudo systemctl start your-service.service
sudo systemctl enable example.service