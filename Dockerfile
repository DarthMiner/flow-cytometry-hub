FROM nginx:alpine
COPY . /usr/share/nginx/html
COPY nginx.conf /etc/nginx/templates/default.conf.template
ENV NGINX_ENVSUBST_FILTER=PORT
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
