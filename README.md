# iot-olap-clickhouse
### `client` висит на 8080 порту для `development`-режима
### `node-iot-generator` висит на 3000 порту
### `server` висит на 5000 порту
# Запуск
### `client`:
##### 1) `npm run configure`
##### 2) `npm run start:dev` для запуска под `webpack-dev-server` и `npm run start:prod` для сборки `dist`
### `node-iot-generator`:
##### 1) `npm run configure`
##### 2) `npm run start:dev` для запуска под `nodemon` и `npm run start:prod` для запуском под `pm2`
### `server`:
##### 1) ¯\_(ツ)_/¯
##### 2) ...
### `docker-compose` (дописывается) должен стартовать простой командой `docker-compose up`, дабы было комфортно разрабатываться и просто деплоить, но пока запускаем всё ручками
