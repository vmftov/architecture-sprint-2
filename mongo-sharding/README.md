# pymongo-api

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Инициализируем и заполняем данными mongodb

```shell
./scripts/mongo-init.sh
```

## Как проверить

### Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

### Чтобы проверить кол-во документов на 1 шарде:

```shell
docker exec -it shard1 mongosh --port 27018

> use somedb;
> db.helloDoc.countDocuments();
> exit(); 
```

### Чтобы проверить кол-во документов на 2 шарде:

```shell
docker exec -it shard2 mongosh --port 27019

> use somedb;
> db.helloDoc.countDocuments();
> exit(); 
```

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs