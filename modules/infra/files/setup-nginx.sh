apt-get update
apt install -y nginx
cat << EOF > /etc/nginx/nginx.conf
    server {
        server_name ${domain_name}; # company tooling site
        location ~ { # case-sensitive regular expression match
  	        include /etc/nginx/mime.types;
            proxy_redirect      off;
            proxy_set_header    X-Real-IP $remote_addr;
            proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header    Host $http_host;
  	        proxy_pass http://${alb}; # aws-lb
        }
    }
EOF
systemctl restart nginx
systemctl enable nginx