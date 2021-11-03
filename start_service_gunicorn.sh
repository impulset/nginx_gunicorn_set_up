#cd /etc/systemd/system
#Let’s create a file called nano /etc/systemd/system/myapp.service:
[Unit]
Description=gunicorn daemon
#Requires=gunicorn.socket
After=network.target

[Service]
Type=notify
# the specific user that our service will run as
User=root
#Group=someuser
# another option for an even more restricted service is
# DynamicUser=yes
# see http://0pointer.net/blog/dynamic-users-with-systemd.html
RuntimeDirectory=gunicorn
WorkingDirectory=/home/ubuntu/app
ExecStart=/usr/local/bin/gunicorn main:app --bind localhost:8080 --worker-class aiohttp.GunicornWebWorker
ExecReload=/bin/kill -s HUP $MAINPID
KillMode=mixed
TimeoutStopSec=5
PrivateTmp=true

[Install]
WantedBy=multi-user.target

# sudo systemctl daemon-reload
# sudo systemctl start myapp.service
# sudo systemctl enable myapp.service