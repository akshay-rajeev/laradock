#!/bin/bash

case $1 in
    init)
        docker compose build
        docker compose up -d --remove-orphans
        docker compose exec php chown -R www-data storage
        docker compose exec php composer install
        docker compose exec php php artisan migrate:fresh --seed
        docker compose exec php php artisan key:generate
        docker compose exec node npm install
        docker compose exec node npm run build
        ;;
    start)
        docker compose up -d --remove-orphans
        ;;
    composer)
        docker compose exec php $*
        ;;
    artisan)
        docker compose exec php php $*
        ;;
    migrate)
        docker compose exec php php artisan migrate:fresh --seed
        ;;
    npm)
        docker compose exec node $*
        ;;
    watch)
        docker compose exec node npm run dev
        ;;
    build)
        docker compose exec node npm run build
        ;;
    validate)
        docker compose exec php ./vendor/bin/phpstan analyse --memory-limit=2G
        docker compose exec php ./vendor/bin/phpcbf ./app
        docker compose exec php php artisan test
        ;;
    login)
        docker compose exec -it $2 sh
        ;;
esac
