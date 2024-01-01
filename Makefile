FIG=docker compose

# Dans la ligne de commande de notre machine, on vérifie si docker-compose est disponible
HAS_DOCKER:=$(shell command -v $(FIG) 2> /dev/null)
# Si c'est le cas, EXEC et EXEC_DB vont permettre d'exécuter des commandes dans les conteneurs
ifdef HAS_DOCKER
	EXEC=$(FIG) exec app
	EXEC_DB=$(FIG) exec db
# Sinon, on exécute les commandes sur la machine locale
else
	EXEC=
	EXEC_DB=
endif

# Ligne de commande du projet Symfony
CONSOLE=php bin/console


check:
	composer check


csfix:
	composer fix


start:
	docker-compose  up  

start.daemon:
	docker-compose  up -d 

stop:
	docker-compose down



restart: stop start.daemon 

update: ## Met à jour le projet avec les informations de composer.lock (ne les met pas à jour)
	$(EXEC) composer install

upgrade: ## Met à jour le projet avec les informations de composer.json (met à jour le composer.lock)
	$(EXEC) composer update
