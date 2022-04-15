
# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Ответ:  
https://hub.docker.com/repository/docker/srasim9239/nginx

## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;
- Nodejs веб-приложение;
- Мобильное приложение c версиями для Android и iOS;
- Шина данных на базе Apache Kafka;
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
- Мониторинг-стек на базе Prometheus и Grafana;
- MongoDB, как основное хранилище данных для java-приложения;
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

Ответ:  
Высоконагруженное монолитное java веб-приложение;
 - физический сервер, т.к. монолитное, следовательно в микросерверах не реализуемо без изменения кода,
   и так как высоконагруженное -  то необходим физический доступ к ресурсами, без использования гипервизора виртуалки. 
 
Nodejs веб-приложение;
 - это веб приложение, для таких приложений достаточно докера, противопоказаний для контейнерной реализации не вижу.
   и в рамках микросервисной архитектуры может быть хорошим решением. 
 
Мобильное приложение c версиями для Android и iOS;
 - Виртаулка -  приложение в докере не имеет GUI, а это по описанию не вариант. 

База данных postgresql используемая, как кэш;
  - в идеале для БД использовать Виртуалку, если доступ к кешу нужен для разных систем, пользователей, 
    использование БД на докере не рекомендуется.
    а так же должен быть сохранен между сессиями , при остановке  приклада.
    вариант с Контейнером(докер) можно рассмотреть только если данные нужны только в рамках сессии 
    самого приложения работающего на этом же контейнере.
    

Шина данных на базе Apache Kafka;
 - зависит от передаваемых данных или контура (тест/прод), для прода и критичности данных лучше Вируалка, для теста достаточно Контейнерной реализации, 
   если потеря данных при потере контенйера не является критичной то можно и в контейнере. 
  
Elastic stack для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
 - сам Elasticsearvh лучше на виртуалку, отказоустойчивость решается на уровне кластера, 
   кибану и логсташ можно вынести в докер контейнер, или так же на виртуалках.
      использование в Докерем может дать "+" для использования в тестовом периоде с максимальным функционалом, 
   в докере можно перезаливать машину каждый месяц и получать опять полную функциональность

Мониторинг-стек на базе prometheus и grafana;
 - сами системы не хранят как таковых данны, можно развернуть на Докере,
   минусов не вижу, в + скорость развертывания, возможность масштабирования для различных задачь: 
     например у графаны есть ограничение на число обрабатываемых метрик и может понадобиться разделения под разные задачи (контуры)

Mongodb, как основное хранилище данных для java-приложения;
 - можно использовать Виртуальную машину, т.к. хранилище и  не сказано что высоконагруженное
   в Контейнере хранить БД с данными не подходит
   для физического сервера может быть через чур расточительно
   
Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
  - отдельный физический сервер или виртуализация, если сервер есть в наличии использовал бы его, но только необходимо оценить доступные объемы хранения
   данных, в том числе подумать о техническом сопровождении: просчитать затраты на поддержку железа и ЗИП. Если по совокупности поставленных задач будет понятно, что через осязаемое недалекое время мы выйдем за пределы мощностей физ. сервера, то выбрал бы, на перспективу, виртуализацию, однако возможны первичные затраты на доп. железо, но все зависит от проекта. 
   
## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

Ответ:  
Вывод с centos 
```
docker run -d -v /data:/data centos sleep infinity
d1ea08c76f321b9541a08fbae1484bf925fb487bfa6aa4aa8a2514631ab69fea
root@vagrant:~# docker ps
CONTAINER ID   IMAGE     COMMAND            CREATED         STATUS         PORTS     NAMES
d1ea08c76f32   centos    "sleep infinity"   8 seconds ago   Up 5 seconds             goofy_solomon
docker exec -it d1ea08c76f32 bash
[root@d1ea08c76f32 /]# ls -lha
total 60K
drwxr-xr-x   1 root root 4.0K Apr 15 11:31 .
drwxr-xr-x   1 root root 4.0K Apr 15 11:31 ..
-rwxr-xr-x   1 root root    0 Apr 15 11:31 .dockerenv
lrwxrwxrwx   1 root root    7 Nov  3  2020 bin -> usr/bin
drwxr-xr-x   2 root root 4.0K Apr 15 11:24 data
drwxr-xr-x   5 root root  340 Apr 15 11:31 dev
drwxr-xr-x   1 root root 4.0K Apr 15 11:31 etc
drwxr-xr-x   2 root root 4.0K Nov  3  2020 home
lrwxrwxrwx   1 root root    7 Nov  3  2020 lib -> usr/lib
lrwxrwxrwx   1 root root    9 Nov  3  2020 lib64 -> usr/lib64
drwx------   2 root root 4.0K Sep 15  2021 lost+found
drwxr-xr-x   2 root root 4.0K Nov  3  2020 media
drwxr-xr-x   2 root root 4.0K Nov  3  2020 mnt
drwxr-xr-x   2 root root 4.0K Nov  3  2020 opt
dr-xr-xr-x 184 root root    0 Apr 15 11:31 proc
dr-xr-x---   2 root root 4.0K Sep 15  2021 root
drwxr-xr-x  11 root root 4.0K Sep 15  2021 run
lrwxrwxrwx   1 root root    8 Nov  3  2020 sbin -> usr/sbin
drwxr-xr-x   2 root root 4.0K Nov  3  2020 srv
dr-xr-xr-x  13 root root    0 Apr 15 11:31 sys
drwxrwxrwt   7 root root 4.0K Sep 15  2021 tmp
drwxr-xr-x  12 root root 4.0K Sep 15  2021 usr
drwxr-xr-x  20 root root 4.0K Sep 15  2021 var
[root@d1ea08c76f32 /]# cd data
[root@d1ea08c76f32 data]# ls
[root@d1ea08c76f32 data]# touch test   
[root@d1ea08c76f32 data]# ls
test
```

Создаем файл на хосте
```
root@vagrant:/data# touch testhost
root@vagrant:/data# ls -lha
total 8.0K
drwxr-xr-x  2 root root 4.0K Apr 15 11:40 .
drwxr-xr-x 22 root root 4.0K Apr 15 11:24 ..
-rw-r--r--  1 root root    0 Apr 15 11:34 test
-rw-r--r--  1 root root    0 Apr 15 11:40 testhost
```

Вывод с дебиан контейнера
```
root@vagrant:~# docker run -d -v /data:/data debian sleep infinity
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
dbba69284b27: Pull complete 
Digest: sha256:87eefc7c15610cca61db5c0fd280911c6a737c0680d807432c0bd80cd0cca39b
Status: Downloaded newer image for debian:latest
79f4f6665d806e28b1e42362fe0c4fe4c5f524a5c45582329782eb8cb44559f7
root@vagrant:~# docker ps
CONTAINER ID   IMAGE     COMMAND            CREATED          STATUS         PORTS     NAMES
79f4f6665d80   debian    "sleep infinity"   10 seconds ago   Up 6 seconds             angry_herschel
d1ea08c76f32   centos    "sleep infinity"   4 minutes ago    Up 4 minutes             goofy_solomon
root@vagrant:~# docker exec -it 79f4f6665d80 bash
root@79f4f6665d80:/# ls -lha
total 76K
drwxr-xr-x   1 root root 4.0K Apr 15 11:36 .
drwxr-xr-x   1 root root 4.0K Apr 15 11:36 ..
-rwxr-xr-x   1 root root    0 Apr 15 11:36 .dockerenv
drwxr-xr-x   2 root root 4.0K Mar 28 00:00 bin
drwxr-xr-x   2 root root 4.0K Mar 19 13:46 boot
drwxr-xr-x   2 root root 4.0K Apr 15 11:40 data
drwxr-xr-x   5 root root  340 Apr 15 11:36 dev
drwxr-xr-x   1 root root 4.0K Apr 15 11:36 etc
drwxr-xr-x   2 root root 4.0K Mar 19 13:46 home
drwxr-xr-x   8 root root 4.0K Mar 28 00:00 lib
drwxr-xr-x   2 root root 4.0K Mar 28 00:00 lib64
drwxr-xr-x   2 root root 4.0K Mar 28 00:00 media
drwxr-xr-x   2 root root 4.0K Mar 28 00:00 mnt
drwxr-xr-x   2 root root 4.0K Mar 28 00:00 opt
dr-xr-xr-x 178 root root    0 Apr 15 11:36 proc
drwx------   1 root root 4.0K Apr 15 11:38 root
drwxr-xr-x   3 root root 4.0K Mar 28 00:00 run
drwxr-xr-x   2 root root 4.0K Mar 28 00:00 sbin
drwxr-xr-x   2 root root 4.0K Mar 28 00:00 srv
dr-xr-xr-x  13 root root    0 Apr 15 11:36 sys
drwxrwxrwt   2 root root 4.0K Mar 28 00:00 tmp
drwxr-xr-x  11 root root 4.0K Mar 28 00:00 usr
drwxr-xr-x  11 root root 4.0K Mar 28 00:00 var
root@79f4f6665d80:/# cd data
root@79f4f6665d80:/data# ls -lha
total 8.0K
drwxr-xr-x 2 root root 4.0K Apr 15 11:40 .
drwxr-xr-x 1 root root 4.0K Apr 15 11:36 ..
-rw-r--r-- 1 root root    0 Apr 15 11:34 test
-rw-r--r-- 1 root root    0 Apr 15 11:40 testhost
```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

Ответ:  
Для разнообразия собрал на Centos
https://hub.docker.com/repository/docker/srasim9239/centos7 

