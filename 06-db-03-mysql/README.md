# Домашнее задание к занятию "6.3. MySQL"


## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с данным контейнером.
## Ответ:
```
mysql> status
--------------
mysql  Ver 8.0.29 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:		15
Current database:	
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		8.0.29 MySQL Community Server - GPL
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8mb4
Db     characterset:	utf8mb4
Client characterset:	latin1
Conn.  characterset:	latin1
UNIX socket:		/var/run/mysqld/mysqld.sock
Binary data as:		Hexadecimal
Uptime:			12 min 21 sec

Threads: 2  Questions: 38  Slow queries: 0  Opens: 140  Flush tables: 3  Open tables: 58  Queries per second avg: 0.051
--------------

mysql> use test_db;
Database changed
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)

mysql> select count(*) from orders where price >300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)

mysql> 
```

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
    
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.
## Ответ
```
mysql> create user 'test'@'localhost' 
    ->     identified with mysql_native_password by 'test-pass' 
    ->     with max_queries_per_hour 100
    ->     password expire interval 180 day 
    ->     failed_login_attempts 3 
    ->     attribute '{"fname": "James","lname": "Pretty"}';
Query OK, 0 rows affected (0.04 sec)

mysql> GRANT Select ON test_db.orders TO 'test'@'localhost';
Query OK, 0 rows affected, 1 warning (0.01 sec)

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test';
+------+-----------+---------------------------------------+
| USER | HOST      | ATTRIBUTE                             |
+------+-----------+---------------------------------------+
| test | localhost | {"fname": "James", "lname": "Pretty"} |
+------+-----------+---------------------------------------+
1 row in set (0.00 sec)

mysql> 
```
## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`
## Ответ:
```
mysql> SELECT TABLE_NAME,ENGINE,ROW_FORMAT,TABLE_ROWS,DATA_LENGTH,INDEX_LENGTH FROM information_schema.TABLES WHERE table_name = 'orders' and  TABLE_SCHEMA = 'test_db' ORDER BY ENGINE asc;
+------------+--------+------------+------------+-------------+--------------+
| TABLE_NAME | ENGINE | ROW_FORMAT | TABLE_ROWS | DATA_LENGTH | INDEX_LENGTH |
+------------+--------+------------+------------+-------------+--------------+
| orders     | InnoDB | Dynamic    |          5 |       16384 |            0 |
+------------+--------+------------+------------+-------------+--------------+
1 row in set (0.00 sec)

mysql> show profiles;
+----------+------------+------------------------------------+
| Query_ID | Duration   | Query                              |
+----------+------------+------------------------------------+
|        1 | 0.09963300 | ALTER TABLE orders ENGINE = InnoDB |
|        2 | 0.06122250 | ALTER TABLE orders ENGINE = MyISAM |
+----------+------------+------------------------------------+
2 rows in set, 1 warning (0.00 sec)

mysql> 

## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`. 

## Ответ:
```
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

innodb_flush_log_at_trx_commit = 0 
innodb_file_per_table = 1
autocommit = 0
innodb_log_buffer_size	= 1M
key_buffer_size = 2448М
max_binlog_size	= 100M
```
