#!/bin/bash

case $1 in
    init)
        docker-compose --env-file src/.env up -d --remove-orphans --build
        docker-compose --env-file src/.env exec -T php chown -R www-data storage
        docker-compose --env-file src/.env exec -T php composer install
        docker-compose --env-file src/.env exec -T php php artisan migrate:fresh --seed
        docker-compose --env-file src/.env exec -T php php artisan key:generate
        docker-compose --env-file src/.env exec -T node npm install
        docker-compose --env-file src/.env exec -T node npm run build
        ;;
    start)
        docker-compose --env-file src/.env up -d --remove-orphans
        ;;
    composer)
        docker-compose --env-file src/.env exec -T php $*
        ;;
    artisan)
        docker-compose --env-file src/.env exec -T php php $*
        ;;
    migrate)
        docker-compose --env-file src/.env exec -T php php artisan migrate:fresh --seed
        ;;
    npm)
        docker-compose --env-file src/.env exec -T node $*
        ;;
    watch)
        docker-compose --env-file src/.env exec -T node npm run dev
        ;;
    build)
        docker-compose --env-file src/.env exec -T node npm run build
        ;;
    validate)
        docker-compose --env-file src/.env exec php ./vendor/bin/phpstan analyse --memory-limit=2G
        docker-compose --env-file src/.env exec php ./vendor/bin/phpcpd --exclude vendor ./
        docker-compose --env-file src/.env exec php ./vendor/bin/phpcs ./
        docker-compose --env-file src/.env exec php ./vendor/bin/phpcbf ./
        docker-compose --env-file src/.env exec php php artisan test
        ;;
    login)
        docker exec -it $2 sh
        ;;
esac