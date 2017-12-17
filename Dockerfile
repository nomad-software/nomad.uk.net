FROM nginx:alpine
VOLUME /var/log/nginx
COPY public /usr/share/nginx/html
EXPOSE 80
