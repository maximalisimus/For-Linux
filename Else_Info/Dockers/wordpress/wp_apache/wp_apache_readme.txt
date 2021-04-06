

mkdir -p website/wordpress && cd website
touch {.env,docker-compose.yml}
nano .env

MYSQL_ROOT_PASSWORD=wp_root_pass
MYSQL_USER=wp_db_user
MYSQL_PASSWORD=wp_pass
MYSQL_DATABASE=wp_db


nano docker-compose.yml

sudo docker-compose up -d
