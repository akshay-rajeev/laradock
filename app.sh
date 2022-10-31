#!/bin/bash

case $1 in
    init)
        docker-compose --env-file src/.env up -d --remove-orphans --build
        docker-compose --env-file src/.env exec php chown -R www-data storage
        docker-compose --env-file src/.env exec php composer install
        docker-compose --env-file src/.env exec php php artisan migrate:fresh --seed
        docker-compose --env-file src/.env exec php php artisan key:generate
        docker-compose --env-file src/.env exec node npm install
        docker-compose --env-file src/.env exec node npm run build
        ;;
    start)
        docker-compose --env-file src/.env up -d --remove-orphans
        ;;
    composer)
        docker-compose --env-file src/.env exec php $*
        ;;
    artisan)
        docker-compose --env-file src/.env exec php php $*
        ;;
    migrate)
        docker-compose --env-file src/.env exec php php artisan migrate:fresh --seed
        ;;
    npm)
        docker-compose --env-file src/.env exec node $*
        ;;
    watch)
        docker-compose --env-file src/.env exec node npm run dev
        ;;
    build)
        docker-compose --env-file src/.env exec node npm run build
        ;;
    validate)
        docker-compose --env-file src/.env exec php ./vendor/bin/phpstan analyse --memory-limit=2G
        docker-compose --env-file src/.env exec php ./vendor/bin/phpcbf ./app
        docker-compose --env-file src/.env exec php php artisan test
        ;;
    login)
        docker-compose --env-file src/.env exec -it $2 sh
        ;;
esac