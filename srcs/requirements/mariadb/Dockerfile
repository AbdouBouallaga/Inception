FROM debian:buster
RUN apt update
RUN apt install curl software-properties-common dirmngr gnupg2 -y
RUN curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash -s -- --mariadb-server-version=10.7 --skip-maxscale --skip-tools
RUN apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
RUN add-apt-repository 'deb [arch=amd64,i386,arm64,ppc64el] https://mariadb.mirror.liquidtelecom.com/repo/10.7/debian buster main'
RUN apt update
RUN apt install mariadb-server mariadb-client -y
RUN sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
RUN apt install -y wget
RUN wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
RUN tar -xvf node_exporter-1.3.1.linux-amd64.tar.gz
RUN mv node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin/node_exporter
CMD node_exporter & mysqld_safe --user=root --console && fg 