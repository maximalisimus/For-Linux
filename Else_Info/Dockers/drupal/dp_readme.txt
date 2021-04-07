
# Drupal with PostgreSQL
#
# Access via "http://localhost:8080"
#   (or "http://$(docker-machine ip):8080" if using docker-machine)
#
# During initial Drupal setup,
# Database type: PostgreSQL
# Database name: postgres
# Database username: postgres
# Database password: example
# ADVANCED OPTIONS; Database host: postgres

version: '3.1'

services:

  drupal:
    image: drupal:8-apache
    ports:
      - 8080:80
    volumes:
      - /var/www/html/modules
      - /var/www/html/profiles
      - /var/www/html/themes
      # this takes advantage of the feature in Docker that a new anonymous
      # volume (which is what we're creating here) will be initialized with the
      # existing content of the image at the same location
      - /var/www/html/sites
    restart: always

  postgres:
    image: postgres:10
    environment:
      POSTGRES_PASSWORD: example
    restart: always


Run docker stack deploy -c stack.yml drupal (or docker-compose -f stack.yml up), 
wait for it to initialize completely, and visit http://swarm-ip:8080, 
http://localhost:8080, or http://host-ip:8080 (as appropriate). 
When installing select postgres as database with the following parameters: 
dbname=postgres user=postgres pass=example hostname=postgres



docker run -d --name some-mysql --network some-network \
    -e MYSQL_DATABASE=drupal \
    -e MYSQL_USER=user \
    -e MYSQL_PASSWORD=password \
    -e MYSQL_ROOT_PASSWORD=password \
mysql:5.7



Supported tags and respective Dockerfile links
9.1.5-php8.0-apache-buster, 9.1-php8.0-apache-buster, 9-php8.0-apache-buster, php8.0-apache-buster, 9.1.5-php8.0-apache, 9.1-php8.0-apache, 9-php8.0-apache, php8.0-apache, 9.1.5-apache-buster, 9.1-apache-buster, 9-apache-buster, apache-buster, 9.1.5-apache, 9.1-apache, 9-apache, apache, 9.1.5, 9.1, 9, latest, 9.1.5-php8.0, 9.1-php8.0, 9-php8.0, php8.0
9.1.5-php8.0-fpm-buster, 9.1-php8.0-fpm-buster, 9-php8.0-fpm-buster, php8.0-fpm-buster, 9.1.5-php8.0-fpm, 9.1-php8.0-fpm, 9-php8.0-fpm, php8.0-fpm, 9.1.5-fpm-buster, 9.1-fpm-buster, 9-fpm-buster, fpm-buster, 9.1.5-fpm, 9.1-fpm, 9-fpm, fpm
9.1.5-php8.0-fpm-alpine3.12, 9.1-php8.0-fpm-alpine3.12, 9-php8.0-fpm-alpine3.12, php8.0-fpm-alpine3.12, 9.1.5-php8.0-fpm-alpine, 9.1-php8.0-fpm-alpine, 9-php8.0-fpm-alpine, php8.0-fpm-alpine, 9.1.5-fpm-alpine3.12, 9.1-fpm-alpine3.12, 9-fpm-alpine3.12, fpm-alpine3.12, 9.1.5-fpm-alpine, 9.1-fpm-alpine, 9-fpm-alpine, fpm-alpine
9.1.5-php7.4-apache-buster, 9.1-php7.4-apache-buster, 9-php7.4-apache-buster, php7.4-apache-buster, 9.1.5-php7.4-apache, 9.1-php7.4-apache, 9-php7.4-apache, php7.4-apache
9.1.5-php7.4-fpm-buster, 9.1-php7.4-fpm-buster, 9-php7.4-fpm-buster, php7.4-fpm-buster, 9.1.5-php7.4-fpm, 9.1-php7.4-fpm, 9-php7.4-fpm, php7.4-fpm
9.1.5-php7.4-fpm-alpine3.12, 9.1-php7.4-fpm-alpine3.12, 9-php7.4-fpm-alpine3.12, php7.4-fpm-alpine3.12, 9.1.5-php7.4-fpm-alpine, 9.1-php7.4-fpm-alpine, 9-php7.4-fpm-alpine, php7.4-fpm-alpine
9.0.11-php7.4-apache-buster, 9.0-php7.4-apache-buster, 9.0.11-php7.4-apache, 9.0-php7.4-apache, 9.0.11-apache-buster, 9.0-apache-buster, 9.0.11-apache, 9.0-apache, 9.0.11, 9.0, 9.0.11-php7.4, 9.0-php7.4
9.0.11-php7.4-fpm-buster, 9.0-php7.4-fpm-buster, 9.0.11-php7.4-fpm, 9.0-php7.4-fpm, 9.0.11-fpm-buster, 9.0-fpm-buster, 9.0.11-fpm, 9.0-fpm
9.0.11-php7.4-fpm-alpine3.12, 9.0-php7.4-fpm-alpine3.12, 9.0.11-php7.4-fpm-alpine, 9.0-php7.4-fpm-alpine, 9.0.11-fpm-alpine3.12, 9.0-fpm-alpine3.12, 9.0.11-fpm-alpine, 9.0-fpm-alpine
8.9.13-php7.4-apache-buster, 8.9-php7.4-apache-buster, 8-php7.4-apache-buster, 8.9.13-php7.4-apache, 8.9-php7.4-apache, 8-php7.4-apache, 8.9.13-apache-buster, 8.9-apache-buster, 8-apache-buster, 8.9.13-apache, 8.9-apache, 8-apache, 8.9.13, 8.9, 8, 8.9.13-php7.4, 8.9-php7.4, 8-php7.4
8.9.13-php7.4-fpm-buster, 8.9-php7.4-fpm-buster, 8-php7.4-fpm-buster, 8.9.13-php7.4-fpm, 8.9-php7.4-fpm, 8-php7.4-fpm, 8.9.13-fpm-buster, 8.9-fpm-buster, 8-fpm-buster, 8.9.13-fpm, 8.9-fpm, 8-fpm
8.9.13-php7.4-fpm-alpine3.12, 8.9-php7.4-fpm-alpine3.12, 8-php7.4-fpm-alpine3.12, 8.9.13-php7.4-fpm-alpine, 8.9-php7.4-fpm-alpine, 8-php7.4-fpm-alpine, 8.9.13-fpm-alpine3.12, 8.9-fpm-alpine3.12, 8-fpm-alpine3.12, 8.9.13-fpm-alpine, 8.9-fpm-alpine, 8-fpm-alpine
7.78-php7.4-apache-buster, 7-php7.4-apache-buster, 7.78-php7.4-apache, 7-php7.4-apache, 7.78-apache-buster, 7-apache-buster, 7.78-apache, 7-apache, 7.78, 7, 7.78-php7.4, 7-php7.4
7.78-php7.4-fpm-buster, 7-php7.4-fpm-buster, 7.78-php7.4-fpm, 7-php7.4-fpm, 7.78-fpm-buster, 7-fpm-buster, 7.78-fpm, 7-fpm
7.78-php7.4-fpm-alpine3.12, 7-php7.4-fpm-alpine3.12, 7.78-php7.4-fpm-alpine, 7-php7.4-fpm-alpine, 7.78-fpm-alpine3.12, 7-fpm-alpine3.12, 7.78-fpm-alpine, 7-fpm-alpine





