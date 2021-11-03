server {

    server_name www.yoursite.com yoursite.com; # managed by Certbot

        location / {
            root /var/www/html;
            index index.html;
        }

        location /my_ip {
                proxy_pass http://localhost:8080/;
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-Host $server_name;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_redirect off;
        }

        location /my_ip/ {
                proxy_pass http://localhost:8080/;
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-Host $server_name;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_redirect off;
        }


    listen [::]:443 ssl ipv6only=on; # managed by Certbot
    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/yoursite.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/yoursite.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot
}

server {
    if ($host = www.yoursite.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    if ($host = yoursite.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


        listen 80 ;
        listen [::]:80 ;
    server_name www.yoursite.com yoursite.com;
    return 404; # managed by Certbot

}