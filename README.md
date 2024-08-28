# pymongo-api

## Как запустить

Из директории sharding-repl-cache:

Запускаем mongodb, redis и приложение

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

### Чтобы проверить время выполнения запроса, необходимо открыть:

http://localhost:8080/hellodoc/users

После этого, открыть панель разработчика и выполнить обновление страницы 
несколько раз. Второй и следующие вызовы должны выполняться гораздо быстрее.

### Чтобы проверить кол-во документов на 1 реплике 1 шарда:

```shell
docker exec -it shard1r1 mongosh --port 27018

> use somedb;
> db.helloDoc.countDocuments();
> exit(); 
```

### Чтобы проверить кол-во документов на 2 реплике 1 шарда:

```shell
docker exec -it shard1r2 mongosh --port 27022

> use somedb;
> db.helloDoc.countDocuments();
> exit(); 
```

### Чтобы проверить кол-во документов на 3 реплике 1 шарда:

```shell
docker exec -it shard1r3 mongosh --port 27023

> use somedb;
> db.helloDoc.countDocuments();
> exit(); 
```

### Чтобы проверить кол-во документов на 1 реплике 2 шарда:

```shell
docker exec -it shard2r1 mongosh --port 27019

> use somedb;
> db.helloDoc.countDocuments();
> exit(); 
```

### Чтобы проверить кол-во документов на 2 реплике 2 шарда:

```shell
docker exec -it shard2r2 mongosh --port 27024

> use somedb;
> db.helloDoc.countDocuments();
> exit(); 
```

### Чтобы проверить кол-во документов на 3 реплике 2 шарда:

```shell
docker exec -it shard2r3 mongosh --port 27025

> use somedb;
> db.helloDoc.countDocuments();
> exit(); 
```

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs