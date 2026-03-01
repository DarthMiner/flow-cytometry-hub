#!/bin/sh
echo "Railway PORT is: $PORT"
sed -i "s/listen 80/listen ${PORT:-80}/" /etc/nginx/conf.d/default.conf
cat /etc/nginx/conf.d/default.conf
nginx -g 'daemon off;'
