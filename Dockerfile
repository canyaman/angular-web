FROM nginx:1.18.0-alpine

ARG NGINX_CONF_FILE=./deploy/nginx.conf

ARG APPLICATION_PATH=./dist/angular-web

## Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*

COPY ${NGINX_CONF_FILE} /etc/nginx/nginx.conf

COPY ${APPLICATION_PATH} /usr/share/nginx/html

RUN echo "nginx -g 'daemon off;'" > run.sh

ENTRYPOINT ["sh", "run.sh"]