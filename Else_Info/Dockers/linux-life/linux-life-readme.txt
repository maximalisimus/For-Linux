

Быстрый запуск Докера:
1)mkdir -p /app/ajenticp/{backup,www}
2)docker run -p 80:80 -p 443:443 -p 7777:22 -p 8888:8000 -v /app/ajenticp/www:/www -v /app/ajenticp/backup:/backup -d linuxlife/ajenti-v:v0.23

