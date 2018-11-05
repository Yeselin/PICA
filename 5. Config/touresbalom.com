# Expires map
map $sent_http_content_type $expires {
    default                    off;
    text/html                  epoch; #means no cache, as it is not a static page
    text/css                   max;
    application/javascript     max;
    application/woff2          max;
    ~image/                    30d; #it is only the logo, so maybe I could change it once a month now
}


server {
        auth_basic           "Restricted Content";
        auth_basic_user_file /home/kuiper/BACKUP/nginx_pass/.htpasswd; 

        listen 80 default_server;
        listen [::]:80 default_server;

	root /var/www/touresbalon;
        index index.html;

        server_name _;

	expires $expires;

        location / {
                auth_basic on;
                try_files $uri $uri/ =404;
        }
        
        #Proxy al API de productos
        location /api/products {
               auth_basic on;
	       proxy_pass "http://localhost:8081";

               proxy_http_version 1.1;

               proxy_set_header Host               $host;
               proxy_set_header X-Real-IP          $remote_addr;
               proxy_set_header X-Forwarded-For    $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto  $scheme;
        }

        #Proxy al API de orders
        location /api/orders {
               auth_basic on;
               proxy_pass "http://localhost:8082";

               proxy_http_version 1.1;

               proxy_set_header Host               $host;
               proxy_set_header X-Real-IP          $remote_addr;
               proxy_set_header X-Forwarded-For    $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto  $scheme;
        }

	#Proxy al API de customers
        location /api/customers {
               auth_basic on;
               proxy_pass "http://localhost:8083";

               proxy_http_version 1.1;

               proxy_set_header Host               $host;
               proxy_set_header X-Real-IP          $remote_addr;
               proxy_set_header X-Forwarded-For    $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto  $scheme;
        }
}
