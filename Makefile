DOCKER_FILES_DIR = ./srcs/requirements/
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml
SUDO = 
DOCKER = $(SUDO) docker
DOCKER_COMPOSE = $(SUDO) docker-compose
DOCKER_EXIST := $(which docker)
DOCKER_COMPOSE_EXIST := $(which docker-compose)
# DOCKER = $(SUDO) docker
# D_COMPOSE = $(SUDO) docker-compose
WP_IMG = wordpress_image
WP_CONTAINER = wordpress
MARIADB_IMG = mariadb_image
MARIADB_CONTAINER = mariadb
NGINX_IMG = nginx_image
NGINX_CONTAINER = nginx

@setup_env: all
	sudo chown -R babdelka:babdelka /home/babdelka/data
	@if test -d $(DOCKER_EXIST); \
	then \
		echo "Docker is already installed"; \
	else \
		echo "Docker is not installed"; \
		$(SUDO) apt update && $(SUDO) apt install -y curl && curl -fsSL https://get.docker.com | sh;\
	fi

	@if test -d $(DOCKER_COMPOSE_EXIST); \
	then \
		echo "Docker-compose is already installed"; \
	else \
		echo "Docker is not installed"; \
		$($(SUDO)) curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && $($(SUDO)) chmod +x /usr/local/bin/docker-compose;\
	fi

all : build
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d

test:
	echo '$(shell hostname -i)'


fix_db:
	$(DOCKER) exec $(WP_CONTAINER) curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	$(DOCKER) exec $(WP_CONTAINER) /bin/sh -c "chmod +x wp-cli.phar"
	$(DOCKER) exec $(WP_CONTAINER) /bin/sh -c "mv wp-cli.phar /usr/local/bin/wp"
#	$(DOCKER) exec $(WP_CONTAINER) /bin/sh -c "wp search-replace http://127.0.0.1 http://{{inventory_hostname}} --precise --recurse-objects --all-tables --allow-root"


build:
	$(DOCKER) build -t $(WP_IMG) $(DOCKER_FILES_DIR)wordpress
	$(DOCKER) build -t $(MARIADB_IMG) $(DOCKER_FILES_DIR)mariadb
	$(DOCKER) build -t $(NGINX_IMG) $(DOCKER_FILES_DIR)nginx

clean :
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
# 	$(DOCKER) rm -f $(WP_CONTAINER) $(MARIADB_CONTAINER) $(NGINX_CONTAINER)


fclean: clean
	$(DOCKER) rmi $(WP_IMG) $(MARIADB_IMG) $(NGINX_IMG) -f