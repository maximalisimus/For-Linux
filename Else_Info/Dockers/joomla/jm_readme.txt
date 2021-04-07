
version: '3.1'

services:
  joomla:
    image: joomla
    restart: always
    links:
      - joomladb:mysql
    ports:
      - 8080:80
    environment:
      JOOMLA_DB_HOST: joomladb
      JOOMLA_DB_PASSWORD: example

  joomladb:
    image: mysql:5.6
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example


-e JOOMLA_DB_HOST=... (defaults to the IP and port of the linked mysql container)
-e JOOMLA_DB_USER=... (defaults to "root")
-e JOOMLA_DB_PASSWORD=... (defaults to the value of the MYSQL_ROOT_PASSWORD environment variable from the linked mysql container)
-e JOOMLA_DB_NAME=... (defaults to "joomla")

php-fpm:
docker pull joomla:php7.4-fpm
docker pull joomla:fpm-alpine
docker pull joomla:fpm

apache:
docker pull joomla:latest




