
# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 # формат адреса неверный, нет ковычек
            }
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43" #ковычки
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket as s
import time as t
import datetime as dt
import json
import yaml

# set variables
i     = 1
wait  = 2 # интервал проверок в секундах
srv   = {'drive.google.com':'0.0.0.0', 'mail.google.com':'0.0.0.0', 'google.com':'0.0.0.0'}
init  = 0
fpath = "/home/ras/DevOps/4.3/" #путь к файлам сервисов
flog  = "/home/ras/DevOps/4.3/error.log" #путь к файлам логов


print('*** start script ***')
print(srv)
print('********************')

while 1 == 1 :
  for host in srv:
    is_error = False
    ip = s.gethostbyname(host)
    if ip != srv[host]:
      if i==1 and init !=1: 
        is_error=True
        # вывод ошибок в файл
        with open(flog,'a') as fl:
          print(str(dt.datetime.now().strftime("%Y-%m-%d %H:%M:%S")) +' [ERROR] ' + str(host) +' IP mistmatch: '+srv[host]+' '+ip,file=fl)
    # запись в файл
    if is_error:
      data = []
      for host in srv:
        data.append({host:ip})
      with open(fpath+"services.json",'w') as jsf:
        json_data= json.dumps(data)
        jsf.write(json_data)
      with open(fpath+"services.yaml",'w') as ymf:
        yaml_data= yaml.dump(data)
        ymf.write(yaml_data)
      srv[host]=ip
  t.sleep(wait) # задержка 
```

### Вывод скрипта при запуске при тестировании:
```
2022-04-08 13:38:37 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.73.194
2022-04-08 13:38:37 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:37 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:39 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.73.194
2022-04-08 13:38:39 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:39 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:41 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.73.194
2022-04-08 13:38:41 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:41 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:43 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.73.194
2022-04-08 13:38:43 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:43 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:45 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.73.194
2022-04-08 13:38:45 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:45 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:47 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.73.194
2022-04-08 13:38:47 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:47 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:49 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.73.194
2022-04-08 13:38:49 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:49 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:51 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.73.194
2022-04-08 13:38:51 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:51 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:53 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.73.194
2022-04-08 13:38:53 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:53 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:55 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:38:55 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:55 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:57 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:38:57 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:38:57 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:38:59 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:38:59 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:00 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:02 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:02 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:02 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:04 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:04 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:04 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:06 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:06 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:06 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:08 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:08 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:08 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:10 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:10 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:10 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:12 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:12 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:12 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:14 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:14 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:14 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:16 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:16 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:16 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:18 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:18 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:18 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:20 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:20 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:20 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:22 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:22 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:22 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:24 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:24 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:24 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:26 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:26 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:26 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:28 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:28 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:28 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:30 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:30 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.197
2022-04-08 13:39:30 [ERROR] google.com IP mistmatch: 216.58.209.197 216.58.210.174
2022-04-08 13:39:32 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:32 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:32 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:34 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:34 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:34 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:36 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:36 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:36 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:38 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:38 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:38 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:40 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:40 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:40 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:42 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:42 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:42 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:44 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:44 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:44 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:46 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:46 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:46 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:48 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:48 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:48 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:50 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:50 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:50 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:52 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:52 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:52 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:54 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:54 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:54 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:56 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:56 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:56 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:39:58 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:39:58 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:39:58 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:00 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:00 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:00 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:02 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:02 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:02 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:04 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:04 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:04 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:06 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:06 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:06 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:08 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:08 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:08 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:10 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:10 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:10 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:12 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:12 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:12 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:14 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:14 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:14 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:16 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:16 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:16 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:18 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:18 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:18 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:20 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:20 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:20 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:22 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:22 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:22 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:24 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:24 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:24 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:26 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:26 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:26 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:28 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:28 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:28 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:30 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:30 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:30 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:32 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:32 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:32 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:34 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:34 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:34 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:36 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:36 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:36 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:38 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:38 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:38 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:40 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:40 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:40 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:42 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:42 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:42 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:44 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:44 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:44 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:46 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:46 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:46 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:48 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:48 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:48 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174
2022-04-08 13:40:51 [ERROR] drive.google.com IP mistmatch: 0.0.0.0 173.194.222.194
2022-04-08 13:40:51 [ERROR] mail.google.com IP mistmatch: 0.0.0.0 216.58.209.165
2022-04-08 13:40:51 [ERROR] google.com IP mistmatch: 216.58.209.165 216.58.210.174

```

### json-файл(ы), который(е) записал ваш скрипт:
```json
[{"drive.google.com": "216.58.210.174"}, {"mail.google.com": "216.58.210.174"}, {"google.com": "216.58.210.174"}]
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
- drive.google.com: 216.58.210.174
- mail.google.com: 216.58.210.174
- google.com: 216.58.210.174

```
