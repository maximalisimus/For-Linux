

mkdir -p website/{wordpress,nginx-conf.d} && cd website
touch {.env,docker-compose.yml,nginx-conf.d/wordpress.conf}
nano .env

MYSQL_ROOT_PASSWORD=wp_root_pass
MYSQL_USER=wp_db_user
MYSQL_PASSWORD=wp_pass
MYSQL_DATABASE=wp_db

nano nginx-conf.d/wordpress.conf
nano docker-compose.yml

sudo docker-compose up -d

sed -i -e "/\# server_name/s/# //" nginx-conf.d/wordpress.conf
sed -i -e "/north.world-ithech.ru/s/north.world-ithech.ru/warden.wps.com/" nginx-conf.d/wordpress.conf
sudo docker-compose up --force-recreate --no-deps -d nginx

