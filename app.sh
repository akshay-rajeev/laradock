#!/bin/bash

case $1 in
    init)
        docker-compose build
        docker-compose up -d --remove-orphans
        docker-compose exec php composer install
        docker-compose exec php php artisan migrate:fresh --seed
        docker-compose exec node npm install
        docker-compose exec node npm run dev
        ;;
    start)
        docker-compose up -d --remove-orphans
        ;;
    artisan)
        docker-compose exec php php $*
        ;;
    migrate)
        docker-compose exec php php artisan migrate:fresh --seed
        ;;
    composer)
        docker-compose exec php $*
        ;;
    watch)
        docker-compose exec node npm run dev
        ;;
    build)
        docker-compose exec node npm run build
        ;;
    npm)
        docker-compose exec node $*
        ;;
    login)
        docker-compose exec -it $2 sh
        ;;
esac
