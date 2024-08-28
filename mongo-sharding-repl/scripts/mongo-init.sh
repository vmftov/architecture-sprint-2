#!/bin/bash

###
# Инициализируем конфиг сервер шардов
###

docker compose exec -T configSrv mongosh --port 27017 <<EOF
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);
EOF

###
# Инициализируем шард 1
###

docker compose exec -T shard1r1 mongosh --port 27018 <<EOF
rs.initiate(
    {
      _id : "rs0",
      members: [
        { _id : 0, host : "shard1r1:27018" },
        { _id : 1, host : "shard1r2:27022" },
        { _id : 2, host : "shard1r3:27023" }
      ]
    }
);
EOF

###
# Инициализируем шард 2
###

docker compose exec -T shard2r1 mongosh --port 27019 <<EOF
rs.initiate(
    {
      _id : "rs1",
      members: [
        { _id : 1, host : "shard2r1:27019" },
        { _id : 2, host : "shard2r2:27024" },
        { _id : 3, host : "shard2r3:27025" },
      ]
    }
);
EOF

###
# Инициализируем роутер шардов
###

docker compose exec -T mongos_router mongosh --port 27020 <<EOF
sh.addShard( "rs0/shard1r1:27018");
sh.addShard( "rs0/shard1r2:27022");
sh.addShard( "rs0/shard1r3:27023");
sh.addShard( "rs1/shard2r1:27019");
sh.addShard( "rs1/shard2r2:27024");
sh.addShard( "rs1/shard2r3:27025");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})
EOF
