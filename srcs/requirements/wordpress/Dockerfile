FROM debian:buster
RUN apt update
RUN apt install -y curl wget gnupg2 ca-certificates lsb-release apt-transport-https
RUN wget https://packages.sury.org/php/apt.gpg
RUN apt-key add apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php7.list
RUN apt update
RUN apt install -y php7.4 php7.4-cli php7.4-common php7.4-fpm php7.4-mysql php7.4-dom php7.4-simplexml php7.4-ssh2 php7.4-xml php7.4-xmlreader php7.4-curl  php7.4-exif  php7.4-ftp php7.4-gd  php7.4-iconv php7.4-imagick php7.4-json  php7.4-mbstring php7.4-posix php7.4-sockets php7.4-tokenizer
RUN update-alternatives --set php /usr/bin/php7.4
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php/7.4/fpm/php-fpm.conf
RUN mkdir /run/php/
RUN ulimit -c unlimited
WORKDIR /var/www/html
RUN echo "test ! -f /var/www/html/index.php && wget https://wordpress.org/latest.tar.gz && tar -xzf latest.tar.gz && rm latest.tar.gz && mv wordpress/* . && rmdir wordpress && chown -R www-data:www-data . && chmod -R 755 ./" > /root/install_wordpress.sh
RUN chmod 755 /root/install_wordpress.sh
CMD php-fpm7.4