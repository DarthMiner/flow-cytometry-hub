#!/bin/sh
# Replace LISTEN_PORT with Railway's PORT (default 80)
sed -i "s/LISTEN_PORT/${PORT:-80}/g" /etc/nginx/conf.d/default.conf
nginx -g 'daemon off;'
