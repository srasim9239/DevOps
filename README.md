## Домашнее задание по курсу "DevOps"
Домашнее задание к занятию "3.4. Операционные системы, лекция 2"


1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

    поместите его в автозагрузку,
    предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
    удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.
  
Ответ:  
![Снимок экрана от 2022-01-25 17-18-41](https://user-images.githubusercontent.com/26147777/151385011-cb02a689-bf6a-4bf3-8d3c-7be1465aee5d.png)

Сервис стартует и перезапускается корректно

1.Проверка после перезапуска работы процесса
2. Остановка
3. Проверка работы процесса
4. Запуск процесса 
5. Проверка работы процесса
 
vagrant@vagrant:~$ ps -e |grep node_exporter   
   1375 ?        00:00:00 node_exporter  
vagrant@vagrant:~$ systemctl stop node_exporter  
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===  
Authentication is required to stop 'node_exporter.service'.  
Authenticating as: vagrant,,, (vagrant)  
Password:   
==== AUTHENTICATION COMPLETE ===  
vagrant@vagrant:~$ ps -e |grep node_exporter  
vagrant@vagrant:~$ systemctl start node_exporter  
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===  
Authentication is required to start 'node_exporter.service'.  
Authenticating as: vagrant,,, (vagrant)  
Password:   
==== AUTHENTICATION COMPLETE ===  
vagrant@vagrant:~$ ps -e |grep node_exporter  
   1420 ?        00:00:00 node_exporter  
vagrant@vagrant:~$   



Прописан конфигруационный файл:  

vagrant@vagrant:/etc/systemd/system$ cat /etc/systemd/system/node_exporter.service  
[Unit]  
Description=Node Exporter  
  
[Service]  
ExecStart=/opt/node_exporter/node_exporter  
EnvironmentFile=/etc/default/node_exporter  
 
[Install]  
WantedBy=default.target  



при перезапуске переменная окружения выставляется :  

agrant@vagrant:/etc/systemd/system$ sudo cat /proc/1809/environ
LANG=en_US.UTF-8LANGUAGE=en_US:PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
INVOCATION_ID=0fcb24d52895405c875cbb9cbc28d3ffJOURNAL_STREAM=9:35758MYVAR=some_value  

2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.   
Ответ:  
CPU:
    node_cpu_seconds_total{cpu="0",mode="idle"} 2238.49
    node_cpu_seconds_total{cpu="0",mode="system"} 16.72
    node_cpu_seconds_total{cpu="0",mode="user"} 6.86
    process_cpu_seconds_total
    
Memory:
    node_memory_MemAvailable_bytes 
    node_memory_MemFree_bytes
    
Disk(если несколько дисков то для каждого):
    node_disk_io_time_seconds_total{device="sda"} 
    node_disk_read_bytes_total{device="sda"} 
    node_disk_read_time_seconds_total{device="sda"} 
    node_disk_write_time_seconds_total{device="sda"}
    
Network(так же для каждого активного адаптера):
    node_network_receive_errs_total{device="eth0"} 
    node_network_receive_bytes_total{device="eth0"} 
    node_network_transmit_bytes_total{device="eth0"}
    node_network_transmit_errs_total{device="eth0"}


3. Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:

    в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,
    добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:

config.vm.network "forwarded_port", guest: 19999, host: 19999

После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.  
Ответ:  
![Снимок экрана от 2022-01-25 17-44-58](https://user-images.githubusercontent.com/26147777/151385299-db90f454-33a5-4940-ad67-96ba04e888de.png)

4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?  
Ответ:  
Судя по выводу dmesg да, причем даже тип ВМ, так как есть соответсвующая строка: 

    agrant@vagrant:~$ dmesg |grep virtualiz
[    0.002836] CPU MTRRs all blank - virtualized system.
[    0.074550] Booting paravirtualized kernel on KVM
[    4.908209] systemd[1]: Detected virtualization oracle.


5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?  
Ответ:  
vagrant@vagrant:~$ /sbin/sysctl -n fs.nr_open
1048576


Это максимальное число открытых дескрипторов для ядра (системы), для пользователя задать больше этого числа нельзя (если не менять). 
Число задается кратное 1024, в данном случае =1024*1024. 

Но макс.предел ОС можно посмотреть так :

vagrant@vagrant:~$ cat /proc/sys/fs/file-max
9223372036854775807



vagrant@vagrant:~$ ulimit -Sn
1024


мягкий лимит (так же ulimit -n)на пользователя (может быть увеличен процессов в процессе работы)

vagrant@vagrant:~$ ulimit -Hn
1048576


жесткий лимит на пользователя (не может быть увеличен, только уменьшен)

Оба ulimit -n НЕ могут превысить системный fs.nr_open  

6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.  
Ответ:  
root@vagrant:~# ps -e |grep sleep
   2020 pts/2    00:00:00 sleep
root@vagrant:~# nsenter --target 2020 --pid --mount
root@vagrant:/# ps
    PID TTY          TIME CMD
      2 pts/0    00:00:00 bash
     11 pts/0    00:00:00 ps  
7. Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Н екоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?  
Ответ: 
эта команда является логической бомбой. Она оперирует определением функции с именем ‘:‘, которая вызывает сама себя дважды: один раз на переднем плане и один раз в фоне. Она продолжает своё выполнение снова и снова, пока система не зависнет.  
[ 3099.973235] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-4.scope
[ 3103.171819] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-11.scope


Судя по всему, система на основании этих файлов в пользовательской зоне ресурсов имеет определенное ограничение на создаваемые ресурсы 
   
