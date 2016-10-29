server {
        server_name www.%domain;
        return 301 http://%domain$request_uri;
}

server {
        listen 80;
        listen [::]:80;
        server_name %domain;

        root /var/www/vhosts/%domain/htdocs;

        index index.html index.htm;

        access_log /var/www/vhosts/%domain/logs/nginx/access.log;

        location / {
                try_files /index.html /maintenance.html @php;
        }


        location ~* \.(js|css|png|jpg|jpeg|gif|swf|ico|pdf|mov|fla|zip|rar)$ {
                try_files $uri @php;
                expires max;
                access_log off;
        }

        location @php {
                proxy_pass   http://127.0.0.1:8080;
                proxy_redirect  off;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                client_max_body_size 12m;
                client_body_buffer_size 128k;
        }

        location ~ \.php$ {
                proxy_pass   http://127.0.0.1:8080;
                proxy_redirect  off;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $remote_addr;
                client_max_body_size 12m;
                client_body_buffer_size 128k;
        }

        location ~ /\.ht {
                deny all;
        }

}

