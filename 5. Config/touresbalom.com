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
        server_name touresbalon.com www.touresbalon.com;
        
        #Hide server information on response
        server_tokens off;

	root /var/www/touresbalon;
        index index.html;

	expires $expires;

        location / {
                auth_basic off;
                try_files $uri $uri/ =404;
        }
        
        #Proxy al servidor de imagenes
        location /image {
               auth_basic off;
               proxy_pass "http://localhost:8888";

               proxy_http_version 1.1;
               
               proxy_set_header Host               $host;
               proxy_set_header X-Real-IP          $remote_addr;
               proxy_set_header X-Forwarded-For    $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto  $scheme;  
        }
        
        #Proxy al API de productos
        location /api/products {

               auth_basic on;
               proxy_pass "http://touresbalon.com:8081";
                
               proxy_http_version 1.1;

               proxy_set_header Host               $host;
               proxy_set_header X-Real-IP          $remote_addr;
               proxy_set_header X-Forwarded-For    $proxy_add_x_forwarded_for;
               proxy_set_header X-Forwarded-Proto  $scheme;

               if ($request_method = OPTIONS) {
                  add_header 'Access-Control-Allow-Origin' '*' always;
                  add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS,DELETE,PUT' always;
                  add_header 'Access-Control-Allow-Headers' '*';
                  add_header Content-Length 0;
                  add_header Content-Type text/plain;
                  return 200;
               }

	       if ($request_method != OPTIONS){
                  add_header 'Access-Control-Allow-Origin' '*' always;
                  add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS,DELETE,PUT' always;
                  add_header 'Access-Control-Allow-Headers' '*';
               }
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

               if ($request_method = OPTIONS) {
                  add_header 'Access-Control-Allow-Origin' '*' always;
                  add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS,DELETE,PUT' always;
                  add_header 'Access-Control-Allow-Headers' '*';
                  add_header Content-Length 0;
                  add_header Content-Type text/plain;
                  return 200;
               }

               if ($request_method != OPTIONS){
                  add_header 'Access-Control-Allow-Origin' '*' always;
                  add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS,DELETE,PUT' always;
                  add_header 'Access-Control-Allow-Headers' '*';
               }
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

               if ($request_method = OPTIONS) {
                  add_header 'Access-Control-Allow-Origin' '*' always;
                  add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS,DELETE,PUT' always;
                  add_header 'Access-Control-Allow-Headers' '*';
                  add_header Content-Length 0;
                  add_header Content-Type text/plain;
                  return 200;
               }

               if ($request_method != OPTIONS){
                  add_header 'Access-Control-Allow-Origin' '*' always;
                  add_header 'Access-Control-Allow-Methods' 'GET,POST,OPTIONS,DELETE,PUT' always;
                  add_header 'Access-Control-Allow-Headers' '*';
               }
        }
}
