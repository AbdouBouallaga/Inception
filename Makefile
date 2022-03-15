DOCKER_FILES_DIR = ./srcs/requirements/
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml
SUDO = sudo
DOCKER = $(SUDO) docker
DOCKER_COMPOSE = $(SUDO) docker-compose
# DOCKER = $(SUDO) docker
# D_COMPOSE = $(SUDO) docker-compose
WP_IMG = wordpress_image
WP_CONTAINER = wordpress
MARIADB_IMG = mariadb_image
MARIADB_CONTAINER = mariadb
NGINX_IMG = nginx_image
NGINX_CONTAINER = nginx


all : build
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d
	$(DOCKER) exec $(WP_CONTAINER) /bin/bash /root/install_wordpress.sh

test:
	echo "hi"


fix_db:
	$(DOCKER) exec $(WP_CONTAINER) curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	$(DOCKER) exec $(WP_CONTAINER) /bin/sh -c "chmod +x wp-cli.phar"
	$(DOCKER) exec $(WP_CONTAINER) /bin/sh -c "mv wp-cli.phar /usr/local/bin/wp"
#	$(DOCKER) exec $(WP_CONTAINER) /bin/sh -c "wp search-replace http://127.0.0.1 http://{{inventory_hostname}} --precise --recurse-objects --all-tables --allow-root"

build:
	$(DOCKER) build -t $(WP_IMG) $(DOCKER_FILES_DIR)wordpress
	$(DOCKER) build -t $(MARIADB_IMG) $(DOCKER_FILES_DIR)mariadb
	$(DOCKER) build -t $(NGINX_IMG) $(DOCKER_FILES_DIR)nginx

setup_env:
	@if test -f /usr/bin/docker; \
	then \
		echo "Docker is already installed"; \
	else \
		echo "Docker is not installed"; \
		$(SUDO) apt update && $(SUDO) apt install -y curl && curl -fsSL https://get.docker.com | sh;\
	fi

	@if test -f /usr/local/bin/docker-compose; \
	then \
		echo "Docker-compose is already installed"; \
	else \
		echo "Docker is not installed"; \
		$(SUDO) curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose && $(SUDO) chmod +x /usr/local/bin/docker-compose;\
	fi

clean :
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
# 	$(DOCKER) rm -f $(WP_CONTAINER) $(MARIADB_CONTAINER) $(NGINX_CONTAINER)


fclean: clean
	$(DOCKER) rmi $(WP_IMG) $(MARIADB_IMG) $(NGINX_IMG) -f

re: clean all