<details>
<summary>English</summary>

# Prerequisite
1. Docker should be installed and configured before continuing. For instruction on how to install Docker, follow the guide on the Docker homepage for your OS.<br>
[Installation Guide](https://docs.docker.com/engine/install/)

# Steps (Development Environment)
1. Once docker is installed. Go to the root of the project where app.sh is present and run the following command in terminal so that application scripts can be run.<br>
```sudo chmod +x app.sh```

2. Create a .env file in the src folder by copying the .env.example file and make the needed changes.<br>
**Note: Be sure to set the ```DB_HOST``` to ```mysql``` since mysql is hosted as a container**

3. Run the init application command to build and bring up all the docker containers<br>
```./app.sh init```

4. Your application will be available at<br>
[localhost](http://localhost)

# Commands
This section explain how to run various Laravel commands like artisan, composer, npm etc

## ./app.sh init
**Use this command only once for the very first time to build and bring up docker containers to run the project**

## ./app.sh start
Use this command to run the application. After running this command the application can be accessed at<br>
[localhost](http://localhost)

## ./app.sh composer
Use this command to run composer commands on php container.<br>
Eg: ```./app.sh composer install```

## ./app.sh artisan
Use this command to run artisan commands on php container.<br>
Eg: ```./app.sh artisan make:migration create_users_table```

## ./app.sh validate
Use this command to run code quality checks for the project. Run this command everytime before pushing to Git.

## ./app.sh npm
Use this command to run npm commands on node container.<br>
Eg: ```./app.sh npm install```

## ./app.sh watch
Use this command to run npm run watch commands on node container. Used to start Vite hot reload server.

## ./app.sh build
Use this command to run npm run build commands on node container. Used to build production assets while deploying.

## ./app.sh migrate
Use this command to reset the migration and run seeders. This command runs<br>
```artisan migrate:fresh --seed```<br>
**Warning: This will reset the DB and result in data lose**

## ./app.sh login container_name
This command can be used when you need to get inside any container. Possible options for container_name are as follows.<br>
1. php
2. mysql
3. node
4. cron
5. nginx

# Steps (Production Environment)
While deploying to Amazon EC2 follow the steps below
1. Use git or FTP to pull the code to your server and create the .env file by copying the .env.example file and make the required changes.

2. Navigate to the root project folder where setup-ec2.sh is present and run the following commands in order to setup docker and the application.
```
sudo chmod +x setup-ec2.sh
sudo chmod +x app.sh
./setup-ec2.sh
./app.sh init
```

3. If everything went well the application should be available in the public IP of the EC2 instance.