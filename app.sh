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
    send)
        docker-compose exec node nodemon node/send.js
        ;;
    composer)
        docker-compose exec php $*
        ;;
    build)
        docker-compose exec node npm run dev
        ;;
    npm)
        docker-compose exec node $*
        ;;
    login)
        docker-compose exec -it $2 sh
        ;;
esac
