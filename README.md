# Prerequisite
1. Docker should be installed and configured before continuing. For instruction on how to install Docker, follow the guide on the Docker homepage for your OS.<br>
https://docs.docker.com/engine/install/

# Steps (Development Environment)
1. Once docker is installed. Go to the root of the project where app.sh is present and run the following command in terminal so that application scripts can be run.<br>
```sudo chmod +x app.sh```

2. Create a .env file in the src folder by copying the .env.example file and make the needed changes.<br>
**Note: Be sure to set the ```DB_HOST``` to ```mysql``` since mysql is hosted as a container**

3. Run the init application command to build and bring up all the docker containers<br>
```./app init```

4. Your application will be available at<br>
http://localhost

# Commands
This section explain how to run various Laravel commands like artisan, composer, npm etc

## ./app init
**Use this command only once for the very first time to build and bring up docker containers to run the project**

## ./app start
Use this command to run the application. After running this command the application can be accessed at<br>
http://localhost

## ./app composer
Use this command to run composer commands on php container.<br>
Eg: ```./app composer install```

## ./app artisan
Use this command to run artisan commands on php container.<br>
Eg: ```./app artisan make:migration create_users_table```

## ./app validate
Use this command to run code quality checks for the project. Run this command everytime before pushing to Git.

## ./app npm
Use this command to run npm commands on node container.<br>
Eg: ```./app npm install```

## ./app watch
Use this command to run npm run watch commands on node container. Used to start Vite hot reload server.

## ./app build
Use this command to run npm run build commands on node container. Used to build production assets while deploying.

## ./app migrate
Use this command to reset the migration and run seeders. This command runs<br>
```artisan migrate:fresh --seed```<br>
**This will reset the DB and result in data lose**

## ./app login {container_name}
This command can be used when you need to get inside any container. Possible options for container_name are as follows.<br>
```
1. php
2. mysql
3. node
4. cron
5. nginx
```