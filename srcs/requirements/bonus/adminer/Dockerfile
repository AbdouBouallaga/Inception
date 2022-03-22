FROM debian:buster
RUN apt update
RUN apt install -y curl wget gnupg2 ca-certificates lsb-release apt-transport-https nginx
RUN wget https://packages.sury.org/php/apt.gpg
RUN apt-key add apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php7.list
RUN apt update
RUN apt install -y php7.4 php7.4-cli php7.4-common php7.4-fpm php7.4-mysql php7.4-dom php7.4-simplexml php7.4-ssh2 php7.4-xml php7.4-xmlreader php7.4-curl  php7.4-exif  php7.4-ftp php7.4-gd  php7.4-iconv php7.4-imagick php7.4-json  php7.4-mbstring php7.4-posix php7.4-sockets php7.4-tokenizer
RUN update-alternatives --set php /usr/bin/php7.4
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 127.0.0.1:9001/g' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php/7.4/fpm/php-fpm.conf
RUN mkdir /run/php/
RUN ulimit -c unlimited
RUN echo "test ! -f /var/www/html/index.php && wget https://wordpress.org/latest.tar.gz && tar -xzf latest.tar.gz && rm latest.tar.gz && mv wordpress/* . && rmdir wordpress && chown -R www-data:www-data . && chmod -R 755 ./" > /root/install_wordpress.sh
RUN chmod 755 /root/install_wordpress.sh
RUN sed -i 's/ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;/ssl_protocols TLSv1.3;/g' /etc/nginx/nginx.conf
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=MA/ST=Morocco/L=Khouribga/O=1337/OU=1337/CN=babdelka.1337.notma"
RUN rm /etc/nginx/sites-available/default
RUN rm /etc/nginx/sites-enabled/default
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
RUN ulimit -c unlimited
RUN wget "http://www.adminer.org/latest.php" -O /var/www/html/adminer.php
RUN chown -R www-data:www-data /var/www/html/adminer.php
RUN chmod 755 /var/www/html/adminer.php
WORKDIR /var/www/html
CMD /etc/init.d/php7.4-fpm start && nginx -g "daemon off;"