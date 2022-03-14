FROM debian:buster
RUN apt update && apt install -y nginx && apt install -y openssl
RUN sed -i 's/ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;/ssl_protocols TLSv1.3;/g' /etc/nginx/nginx.conf
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=MA/ST=Morocco/L=Khouribga/O=1337/OU=1337/CN=localhost"
RUN rm /etc/nginx/sites-available/default
RUN rm /etc/nginx/sites-enabled/default
RUN apt install nmap -y
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
RUN ulimit -c unlimited
CMD ["nginx", "-g", "daemon off;"]