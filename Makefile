DOCKER = sudo docker
D_COMPOSE = sudo docker-compose
WP_IMG = src_wordpress
WP_CONTAINER = wordpress
MARIADB_IMG = src_mariadb
MARIADB_CONTAINER = mariadb
NGINX_IMG = src_nginx
NGINX_CONTAINER = nginx

all :
	$(D_COMPOSE) up --build

clean :
	$(D_COMPOSE) down
	$(DOCKER) rm -f $(WP_CONTAINER) $(MARIADB_CONTAINER) $(NGINX_CONTAINER)
	$(DOCKER) rmi $(WP_IMG) $(MARIADB_IMG) $(NGINX_IMG) -f
