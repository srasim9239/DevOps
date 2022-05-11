# Домашнее задание к занятию "6.2. SQL"


## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.
### Ответ
```
version: "3.3"

volumes:
  postgressql_data:  
  backup_postgressql_data:

services:
  
  postgressql:
    image: postgres:12-bullseye 
    container_name: postgressql
    environment:
      - PGDATA=/var/lib/postgresql/data/
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
    volumes:
      - postgressql_data:/var/lib/postgresql/data
      - backup_postgressql_data:/backup
      - ./config:/docker-entrypoint-initdb.d
    network_mode: "host"
```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db  
# Ответ:  
```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
(4 rows)

postgres=# \d+ orders
                                   Table "public.orders"
 Column |  Type   | Collation | Nullable | Default | Storage  | Stats target | Description 
--------+---------+-----------+----------+---------+----------+--------------+-------------
 id     | integer |           | not null |         | plain    |              | 
 name   | text    |           |          |         | extended |              | 
 price  | integer |           |          |         | plain    |              | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_booking_fkey" FOREIGN KEY (booking) REFERENCES orders(id)
Access method: heap

postgres=# \d+ clients
                                   Table "public.clients"
  Column  |  Type   | Collation | Nullable | Default | Storage  | Stats target | Description 
----------+---------+-----------+----------+---------+----------+--------------+-------------
 id       | integer |           | not null |         | plain    |              | 
 lastname | text    |           |          |         | extended |              | 
 country  | text    |           |          |         | extended |              | 
 booking  | integer |           |          |         | plain    |              | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "country_index" btree (country)
Foreign-key constraints:
    "clients_booking_fkey" FOREIGN KEY (booking) REFERENCES orders(id)
Access method: heap

postgres=# SELECT table_name, grantee, privilege_type 
postgres-#  FROM information_schema.role_table_grants 
postgres-#  WHERE table_name='orders';
 table_name |     grantee      | privilege_type 
------------+------------------+----------------
 orders     | postgres         | INSERT
 orders     | postgres         | SELECT
 orders     | postgres         | UPDATE
 orders     | postgres         | DELETE
 orders     | postgres         | TRUNCATE
 orders     | postgres         | REFERENCES
 orders     | postgres         | TRIGGER
 orders     | test-simple-user | INSERT
 orders     | test-simple-user | SELECT
 orders     | test-simple-user | UPDATE
 orders     | test-simple-user | DELETE
 orders     | test-admin-user  | INSERT
 orders     | test-admin-user  | SELECT
 orders     | test-admin-user  | UPDATE
 orders     | test-admin-user  | DELETE
 orders     | test-admin-user  | TRUNCATE
 orders     | test-admin-user  | REFERENCES
 orders     | test-admin-user  | TRIGGER
(18 rows)

postgres=# SELECT table_name, grantee, privilege_type 
postgres-#  FROM information_schema.role_table_grants 
postgres-#  WHERE table_name='clients';
 table_name |     grantee      | privilege_type 
------------+------------------+----------------
 clients    | postgres         | INSERT
 clients    | postgres         | SELECT
 clients    | postgres         | UPDATE
 clients    | postgres         | DELETE
 clients    | postgres         | TRUNCATE
 clients    | postgres         | REFERENCES
 clients    | postgres         | TRIGGER
 clients    | test-simple-user | INSERT
 clients    | test-simple-user | SELECT
 clients    | test-simple-user | UPDATE
 clients    | test-simple-user | DELETE
 clients    | test-admin-user  | INSERT
 clients    | test-admin-user  | SELECT
 clients    | test-admin-user  | UPDATE
 clients    | test-admin-user  | DELETE
 clients    | test-admin-user  | TRUNCATE
 clients    | test-admin-user  | REFERENCES
 clients    | test-admin-user  | TRIGGER
(18 rows)
```


## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.
# ОТвет:  
```
postgres=# SELECT * FROM orders;
 id |  name   | price 
----+---------+-------
  1 | Шоколад |    10
  2 | Принтер |  3000
  3 | Книга   |   500
  4 | Монитор |  7000
  5 | Гитара  |  4000
(5 rows)

postgres=# SELECT * FROM clients;
 id |       lastname       | country | booking 
----+----------------------+---------+---------
  1 | Иванов Иван Иванович | USA     |        
  2 | Петров Петр Петрович | Canada  |        
  3 | Иоганн Себастьян Бах | Japan   |        
  4 | Ронни Джеймс Дио     | Russia  |        
  5 | Ritchie Blackmore    | Russia  |        
(5 rows)

postgres=# SELECT COUNT(*) FROM orders;
 count 
-------
     5
(1 row)

postgres=# SELECT COUNT(*) FROM clients;
 count 
-------
     5
(1 row)

postgres=# 

```
## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.  
# Ответ:  
```
postgres=# alter table clients add column order_number integer references orders
postgres-# ;
ALTER TABLE
postgres=# UPDATE clients SET order_number=3 WHERE id=1;                        
UPDATE 1
postgres=# UPDATE clients SET order_number=4 WHERE id=2;
UPDATE 1
postgres=# UPDATE clients SET order_number=5 WHERE id=3;
UPDATE 1
postgres=# SELECT * FROM clients;
 id |       lastname       | country | booking | order_number 
----+----------------------+---------+---------+--------------
  4 | Ронни Джеймс Дио     | Russia  |         |             
  5 | Ritchie Blackmore    | Russia  |         |             
  1 | Иванов Иван Иванович | USA     |         |            3
  2 | Петров Петр Петрович | Canada  |         |            4
  3 | Иоганн Себастьян Бах | Japan   |         |            5
(5 rows)

postgres=# SELECT * FROM clients WHERE order_number IS NOT NULL;
 id |       lastname       | country | booking | order_number 
----+----------------------+---------+---------+--------------
  1 | Иванов Иван Иванович | USA     |         |            3
  2 | Петров Петр Петрович | Canada  |         |            4
  3 | Иоганн Себастьян Бах | Japan   |         |            5
(3 rows)

postgres=# 
```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.  
Ответ:  
```
postgres=# EXPLAIN (FORMAT YAML) SELECT * FROM clients WHERE order_number IS NOT NULL;
                QUERY PLAN                
------------------------------------------
 - Plan:                                 +
     Node Type: "Seq Scan"               +
     Parallel Aware: false               +
     Relation Name: "clients"            +
     Alias: "clients"                    +
     Startup Cost: 0.00                  +
     Total Cost: 17.80                   +
     Plan Rows: 776                      +
     Plan Width: 76                      +
     Filter: "(order_number IS NOT NULL)"
(1 row)

postgres=# 
```
EXPLAIN - позволяет нам дать служебную информацию о запросе к БД, в том числе время на выполнение запроса, что при оптимизации работы БД является очень полезной информацией.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.   
# Ответ:  
# Резервное копирование
```
root@ras-VirtualBox:/# pg_dumpall -U postgres -W > /backup/backup_"`date +"%d-%m-%Y"`"
```
# Останавливаем докер, удаляем Volume
```
 ✘ ras@ras-VirtualBox  ~/DevOps/06-db-02-sql   main ±  sudo docker-compose down
Stopping postgressql ... done
Removing postgressql ... done
 ✘ ras@ras-VirtualBox  ~/DevOps/06-db-02-sql   main ±  sudo docker volume ls
DRIVER    VOLUME NAME
local     06-db-02-sql_backup_postgressql_data
local     06-db-02-sql_postgressql_data
 ras@ras-VirtualBox  ~/DevOps/06-db-02-sql   main ±  sudo docker volume rm 06-db-02-sql_postgressql_data
06-db-02-sql_postgressql_data
 ras@ras-VirtualBox  ~/DevOps/06-db-02-sql   main ±  sudo docker volume ls                         
DRIVER    VOLUME NAME
local     06-db-02-sql_backup_postgressql_data
```

```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# 


```
# Восстанавливаем
```
root@ras-VirtualBox:/# psql -U postgres -f /backup/backup_11-05-2022 
```
# Проверяем
```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
(4 rows)

postgres=# \dt
          List of relations
 Schema |  Name   | Type  |  Owner   
--------+---------+-------+----------
 public | clients | table | postgres
 public | orders  | table | postgres
(2 rows)

postgres=# \du
                                       List of roles
    Role name     |                         Attributes                         | Member of 
------------------+------------------------------------------------------------+-----------
 postgres         | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test-admin-user  | Superuser, No inheritance                                  | {}
 test-simple-user | No inheritance                                             | {}

postgres=# select * from orders
postgres-# ;
 id |  name   | price 
----+---------+-------
  1 | Шоколад |    10
  2 | Принтер |  3000
  3 | Книга   |   500
  4 | Монитор |  7000
  5 | Гитара  |  4000
(5 rows)

postgres=# select * from clients
;
 id |       lastname       | country | booking | order_number 
----+----------------------+---------+---------+--------------
  4 | Ронни Джеймс Дио     | Russia  |         |             
  5 | Ritchie Blackmore    | Russia  |         |             
  1 | Иванов Иван Иванович | USA     |         |            3
  2 | Петров Петр Петрович | Canada  |         |            4
  3 | Иоганн Себастьян Бах | Japan   |         |            5
(5 rows)

postgres=# 
```

