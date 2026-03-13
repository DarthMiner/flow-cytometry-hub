FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY *.html /usr/share/nginx/html/
COPY sitemap.xml /usr/share/nginx/html/
COPY robots.txt /usr/share/nginx/html/
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
