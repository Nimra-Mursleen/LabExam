#!/bin/bash
dnf update -y
dnf install -y nginx openssl

# Self-signed Cert generation
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/cert.key -out /etc/nginx/cert.crt \
  -subj "/C=US/ST=State/L=City/O=Org/CN=localhost"

# Simple Nginx configuration to enable SSL
cat <<EOF > /etc/nginx/conf.d/ssl.conf
server {
    listen 443 ssl;
    ssl_certificate /etc/nginx/cert.crt;
    ssl_certificate_key /etc/nginx/cert.key;
    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
EOF

echo "<h1>Nginx  Terraform environment.</h1>" > /usr/share/nginx/html/index.html

systemctl enable nginx
systemctl start nginix
