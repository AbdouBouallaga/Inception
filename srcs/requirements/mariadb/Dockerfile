FROM debian:buster
RUN apt update
RUN apt install mariadb-server -y
# RUN sed -i 's/#port                   = 3306/port                   = 3306/g' /etc/mysql/mariadb.conf.d/50-server.cnf
# RUN sed -i 's/bind-address            = 127.0.0.1/bind-address            = 10.12.99.4/g' /etc/mysql/mariadb.conf.d/50-server.cnf
# RUN /etc/init.d/mysql reload
RUN /etc/init.d/mysql start
# RUN mariadb -e "CREATE USER '$MYSQL_USER1'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD1';"
# RUN mariadb -e "CREATE USER '$MYSQL_USER2'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD2';"
# RUN mariadb -e "GRANT ALL PRIVILEGES ON * . * TO '$MYSQL_USER1'@'localhost';"
# RUN mariadb -e "GRANT ALL PRIVILEGES ON '$MYSQL_WP_DB_NAME'.* TO '$MYSQL_USER2'@localhost;"
# RUN mariadb -e "FLUSH PRIVILEGES;"
CMD bash -c "/etc/init.d/mysql start && tail -f /dev/null"