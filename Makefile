DOCKER_FILES_DIR = ./srcs/requirements/
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml
SUDO = sudo
DOCKER = $(SUDO) docker
DOCKER_COMPOSE = $(SUDO) docker-compose
# DOCKER = $(SUDO) docker
# D_COMPOSE = $(SUDO) docker-compose
WP = wordpress
MARIADB = mariadb
NGINX = nginx
PMA = phpmyadmin
REDIS = redis


all : build
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d
	@-$(DOCKER) exec $(WP_CONTAINER) /bin/bash /root/install_wordpress.sh

build:
	$(DOCKER) build -t $(WP) $(DOCKER_FILES_DIR)wordpress
	$(DOCKER) build -t $(MARIADB) $(DOCKER_FILES_DIR)mariadb
	$(DOCKER) build -t $(NGINX) $(DOCKER_FILES_DIR)nginx
	$(DOCKER) build -t $(REDIS) $(DOCKER_FILES_DIR)bonus/redis

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
	$(DOCKER) rmi $(WP) $(MARIADB) $(NGINX) $(REDIS) -f

re: clean all