
# Pull image from Docker Hub.
$ docker pull gogs/gogs

# Create local directory for volume.
$ mkdir -p /var/gogs

# Use `docker run` for the first time.
$ docker run --name=gogs -p 10022:22 -p 10080:3000 -v /var/gogs:/data gogs/gogs

# Use `docker start` if you have stopped it.
$ docker start gogs




sudo docker volume create portainer_data

sudo docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

sudo docker ps


mkdir -p gogs-server/{gogs_data,mysql_data} && cd gogs-server
nano docker-compose.yml

sudo docker-compose up -d



version: '3'

networks:
  gogsnet:

services:
  gogs:
    image: gogs/gogs
    container_name: gogs-server
    restart: unless-stopped
    # restart: always
    environment:
      - USER_UID=1000
      - USER_GID=1000
    volumes:
      - ./gogs_data:/data
    ports:
      - "3000:3000"
      - "2222:22"
    depends_on:
      - mysql
    links:
      - mysql
    networks:
      - gogsnet

  mysql:
    # image: yobasystems/alpine-mariadb:latest
    image: mysql:8.0
    container_name: mysql
    restart: unless-stopped
    environment:
      - MYSQL_ROOT_PASSWORD=gogs
      - MYSQL_DATABASE=gogs
      - MYSQL_USER=gogs
      - MYSQL_PASSWORD=gogs
    ports:
      - "3306:3306"
    volumes:
      - ./mysql_data:/var/lib/mysql
    # command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
    command: '--default-authentication-plugin=mysql_native_password'
    networks:
      - gogsnet


