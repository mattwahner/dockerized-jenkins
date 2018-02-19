FROM ubuntu
USER root

ARG domain
ARG email

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:certbot/certbot && \
    apt-get update && \
    apt-get install -y python-certbot-nginx nginx

COPY nginx.conf /etc/nginx/sites-available/default
RUN sed -i 's/$DOMAIN/'$domain'/g' /etc/nginx/sites-available/default && \
    certbot -n --nginx --agree-tos --email $email -d $domain
