# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

В этом задании вы потренируетесь в:
- установке elasticsearch
- первоначальном конфигурировании elastcisearch
- запуске elasticsearch в docker

Используя докер образ [centos:7](https://hub.docker.com/_/centos) как базовый и 
[документацию по установке и запуску Elastcisearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html):

- составьте Dockerfile-манифест для elasticsearch
- соберите docker-образ и сделайте `push` в ваш docker.io репозиторий
- запустите контейнер из получившегося образа и выполните запрос пути `/` c хост-машины

Требования к `elasticsearch.yml`:
- данные `path` должны сохраняться в `/var/lib`
- имя ноды должно быть `netology_test`

В ответе приведите:
- текст Dockerfile манифеста
- ссылку на образ в репозитории dockerhub
- ответ `elasticsearch` на запрос пути `/` в json виде

Подсказки:
- возможно вам понадобится установка пакета perl-Digest-SHA для корректной работы пакета shasum
- при сетевых проблемах внимательно изучите кластерные и сетевые настройки в elasticsearch.yml
- при некоторых проблемах вам поможет docker директива ulimit
- elasticsearch в логах обычно описывает проблему и пути ее решения

Далее мы будем работать с данным экземпляром elasticsearch.
## Ответ:
Dockerfile
```
#6.5. Elasticsearch
FROM centos:7
LABEL ElasticSearch Lab 6.5
ENV PATH=/usr/lib:$PATH

RUN rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
RUN echo "[elasticsearch]" >>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "name=Elasticsearch repository for 7.x packages" >>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "baseurl=https://artifacts.elastic.co/packages/7.x/yum">>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "gpgcheck=1">>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch">>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "enabled=0">>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "autorefresh=1">>/etc/yum.repos.d/elasticsearch.repo &&\
    echo "type=rpm-md">>/etc/yum.repos.d/elasticsearch.repo 

RUN yum install -y --enablerepo=elasticsearch elasticsearch 
    
ADD elasticsearch.yml /etc/elasticsearch/
RUN mkdir /usr/share/elasticsearch/snapshots &&\
    chown elasticsearch:elasticsearch /usr/share/elasticsearch/snapshots
RUN mkdir /var/lib/logs \
    && chown elasticsearch:elasticsearch /var/lib/logs \
    && mkdir /var/lib/data \
    && chown elasticsearch:elasticsearch /var/lib/data
    
USER elasticsearch
CMD ["/usr/sbin/init"]
CMD ["/usr/share/elasticsearch/bin/elasticsearch"]
```
```
# docker exec -it a93ec23982f0 bash
bash-4.2$ curl -u elastic http://localhost:9200
Enter host password for user 'elastic':
{
  "name" : "a93ec23982f0",
  "cluster_name" : "netology_test",
  "cluster_uuid" : "cY57sYeMRGOyoFTbjRO5TQ",
  "version" : {
    "number" : "7.17.3",
    "build_flavor" : "default",
    "build_type" : "rpm",
    "build_hash" : "5ad023604c8d7416c9eb6c0eadb62b14e766caff",
    "build_date" : "2022-04-19T08:11:19.070913226Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
bash-4.2$ 

```
https://hub.docker.com/repository/docker/srasim9239/els
## Задача 2

В этом задании вы научитесь:
- создавать и удалять индексы
- изучать состояние кластера
- обосновывать причину деградации доступности данных

Ознакомтесь с [документацией](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-create-index.html) 
и добавьте в `elasticsearch` 3 индекса, в соответствии со таблицей:

| Имя | Количество реплик | Количество шард |
|-----|-------------------|-----------------|
| ind-1| 0 | 1 |
| ind-2 | 1 | 2 |
| ind-3 | 2 | 4 |

Получите список индексов и их статусов, используя API и **приведите в ответе** на задание.

Получите состояние кластера `elasticsearch`, используя API.

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

Удалите все индексы.

**Важно**

При проектировании кластера elasticsearch нужно корректно рассчитывать количество реплик и шард,
иначе возможна потеря данных индексов, вплоть до полной, при деградации системы.
## Ответ
Создание индексов:
```
curl -X PUT localhost:9200/ind-1 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
curl -X PUT localhost:9200/ind-2 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 2,  "number_of_replicas": 1 }}'
curl -X PUT localhost:9200/ind-3 -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 4,  "number_of_replicas": 2 }}'    
```
Список индексов:
```
$ curl -X GET 'http://localhost:9200/_cat/indices?v' 
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases RW-zeHIpRImO-jMw-udu2A   1   0         41            0     38.8mb         38.8mb
green  open   ind-1            EZHZv5QCTqGtf14ZTA0Rsg   1   0          0            0       226b           226b
yellow open   ind-3            wFnhEd1GQTqtApvG7t9wgg   4   2          0            0       415b           415b
yellow open   ind-2            tewyhLkYQNmmN10_GUR8jA   2   1          0            0       452b           452b
```
Статусы индексов
```
bash-4.2$ curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
bash-4.2$ curl -X GET 'http://localhost:9200/_cluster/health/ind-2?pretty'
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 50.0
}
bash-4.2$ curl -X GET 'http://localhost:9200/_cluster/health/ind-3?pretty' 
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 50.0
}
```
Статус кластера:
```
$ curl -XGET localhost:9200/_cluster/health/?pretty=true
{
  "cluster_name" : "netology_test",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 7,
  "active_shards" : 7,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 41.17647058823529
}
```
Удаление индексов:
```
$ curl -X DELETE 'http://localhost:9200/ind-1?pretty' 
{
  "acknowledged" : true
}
$ curl -X DELETE 'http://localhost:9200/ind-2?pretty' 
{
  "acknowledged" : true
}
$ curl -X DELETE 'http://localhost:9200/ind-3?pretty' 
{
  "acknowledged" : true
}
$ curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index uuid pri rep docs.count docs.deleted store.size pri.store.size
```

индексы в статусе Yellow потому что у них указано число реплик, а по факту нет других серверов, соответсвено реплицировать некуда.
## Задача 3

В данном задании вы научитесь:
- создавать бэкапы данных
- восстанавливать индексы из бэкапов

Создайте директорию `{путь до корневой директории с elasticsearch в образе}/snapshots`.

Используя API [зарегистрируйте](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-register-repository.html#snapshots-register-repository) 
данную директорию как `snapshot repository` c именем `netology_backup`.

**Приведите в ответе** запрос API и результат вызова API для создания репозитория.

Создайте индекс `test` с 0 реплик и 1 шардом и **приведите в ответе** список индексов.

[Создайте `snapshot`](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-take-snapshot.html) 
состояния кластера `elasticsearch`.

**Приведите в ответе** список файлов в директории со `snapshot`ами.

Удалите индекс `test` и создайте индекс `test-2`. **Приведите в ответе** список индексов.

[Восстановите](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshots-restore-snapshot.html) состояние
кластера `elasticsearch` из `snapshot`, созданного ранее. 

**Приведите в ответе** запрос к API восстановления и итоговый список индексов.

Подсказки:
- возможно вам понадобится доработать `elasticsearch.yml` в части директивы `path.repo` и перезапустить `elasticsearch`
## Ответ:
```
bash-4.2$ ls -lha /usr/share/elasticsearch/snapshots
total 12K
drwxr-xr-x 1 elasticsearch elasticsearch 4.0K May 11 14:05 .
drwxr-xr-x 1 root          root          4.0K May 11 13:46 ..
bash-4.2$ curl -XPOST localhost:9200/_snapshot/netology_backup?pretty -H 'Content-Type: application/json' -d'{"type": "fs", "settings": { "location":"/usr/share/elasticsearch/snapshots" }}'
{
  "acknowledged" : true
}
bash-4.2$ curl -X PUT localhost:9200/_snapshot/netology_backup/elasticsearch?wait_for_completion=true
{"snapshot":{"snapshot":"elasticsearch","uuid":"mAp4aF1KSuC-Ho6YMNi8MA","repository":"netology_backup","version_id":7170399,"version":"7.17.3","indices":[".ds-ilm-history-5-2022.05.11-000001",".ds-.logs-deprecation.elasticsearch-default-2022.05.11-000001",".geoip_databases"],"data_streams":["ilm-history-5",".logs-deprecation.elasticsearch-default"],"include_global_state":true,"state":"SUCCESS","start_time":"2022-05-11T14:10:33.039Z","start_time_in_millis":1652278233039,"end_time":"2022-05-11T14:10:34.443Z","end_time_in_millis":1652278234443,"duration_in_millis":1404,"failures":[],"shards":{"total":3,"failed":0,"successful":3},"feature_states":[{"feature_name":"geoip","indices":[".geoip_databases"]}]}}bash-4.2$ ls -lha /usr/share/elasticsearch/snapshots
total 60K
drwxr-xr-x 1 elasticsearch elasticsearch 4.0K May 11 14:10 .
drwxr-xr-x 1 root          root          4.0K May 11 13:46 ..
-rw-r--r-- 1 elasticsearch elasticsearch 1.2K May 11 14:10 index-0
-rw-r--r-- 1 elasticsearch elasticsearch    8 May 11 14:10 index.latest
drwxr-xr-x 5 elasticsearch elasticsearch 4.0K May 11 14:10 indices
-rw-r--r-- 1 elasticsearch elasticsearch  29K May 11 14:10 meta-mAp4aF1KSuC-Ho6YMNi8MA.dat
-rw-r--r-- 1 elasticsearch elasticsearch  692 May 11 14:10 snap-mAp4aF1KSuC-Ho6YMNi8MA.dat
bash-4.2$ 
bash-4.2$ curl -X DELETE 'http://localhost:9200/test?pretty'
{
  "acknowledged" : true
}
bash-4.2$ curl -X PUT localhost:9200/test-2?pretty -H 'Content-Type: application/json' -d'{ "settings": { "number_of_shards": 1,  "number_of_replicas": 0 }}'
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test-2"
}
bash-4.2$ curl -X GET http://localhost:9200/_cat/indices?v
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 xyyVQhvKSjOzSDareRk7Mw   1   0          0            0       226b           226b


bash-4.2$ curl -X POST localhost:9200/_snapshot/netology_backup/elasticsearch/_restore?pretty -H 'Content-Type: application/json' -d'{"include_global_state":true}'
{
  "accepted" : true
}
bash-4.2$ curl -X GET http://localhost:9200/_cat/indices?v
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 xyyVQhvKSjOzSDareRk7Mw   1   0          0            0       226b           226b
green  open   test   Y8VtO9hlTr6AcrH236tP-w   1   0          0            0       226b           226b
bash-4.2$ 
```
