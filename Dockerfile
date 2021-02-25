FROM nginx:1.18.0-alpine

ARG NGINX_CONF_FILE=./deploy/nginx.conf

ARG APPLICATION_PATH=./dist/angular-web

USER root

RUN rm -rf /usr/share/nginx/html/*

RUN mkdir -p /var/run/nginx /var/log/nginx /var/cache/nginx && \
    chmod g+rwx /var/cache/nginx /var/run /var/log/nginx

COPY ${NGINX_CONF_FILE} /etc/nginx/nginx.conf
RUN sed -i.bak 's/listen\(.*\)80;/listen 8080;/' /etc/nginx/nginx.conf
EXPOSE 8080

COPY ${APPLICATION_PATH} /usr/share/nginx/html
RUN chown -R 1001:0 /usr/share/nginx/html

RUN echo "nginx -g 'daemon off;'" > run.sh

USER 1001:0

ENTRYPOINT ["sh", "run.sh"]