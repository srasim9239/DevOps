# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32
```  
Ответ:
```
route-views>show ip route 94.25.185.188   
Routing entry for 94.25.176.0/20
  Known via "bgp 6447", distance 20, metric 0
  Tag 852, type external
  Last update from 154.11.12.212 4d01h ago
  Routing Descriptor Blocks:
  * 154.11.12.212, from 154.11.12.212, 4d01h ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 852
      MPLS label: none
      
      
route-views>show ip bgp  94.25.185.188 
BGP routing table entry for 94.25.176.0/20, version 305315779
Paths: (23 available, best #8, table default)
  Not advertised to any peer
  Refresh Epoch 1
  701 174 31133 25159
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin IGP, localpref 100, valid, external
      path 7FE15FA87488 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3549 3356 174 31133 25159
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:3 3356:22 3356:86 3356:575 3356:666 3356:901 3356:2011 3549:2581 3549:30840
      path 7FE0FD7FE0E0 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 174 31133 25159
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external
      Community: 174:21101 174:22028 53767:5000
      path 7FE12DD7AC88 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 174 31133 25159
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:3 3356:22 3356:86 3356:575 3356:666 3356:901 3356:2012
      path 7FE051BEB3E0 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  8283 31133 25159
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 8283:1 8283:101 8283:103
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x24
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001 0000 205B 0000 0005
              0000 0003 
      path 7FE02AAA43E0 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  4901 6079 31133 25159
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE0184B3B80 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  57866 6830 174 31133 25159
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 6830:17000 6830:17504 6830:33125 17152:0 57866:501
      path 7FE162788858 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 31133 25159
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external, best
      path 7FE18B0BCBC8 RPKI State valid
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  20912 3257 174 31133 25159
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8070 3257:30155 3257:50001 3257:53900 3257:53902 20912:65004
      path 7FE136C33E58 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3303 31133 25159
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external
      Community: 3303:1004 3303:1006 3303:1030 3303:3056
      path 7FE12118AD70 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 31133 25159
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      path 7FE0DFD48378 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7018 174 31133 25159
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin IGP, localpref 100, valid, external
      Community: 7018:5000 7018:37232
      path 7FE07E560CC0 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3561 209 3356 174 31133 25159
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7FE0532E1BF8 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1351 6939 31133 25159
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE0A9A60768 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 6939 31133 25159
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external
      path 7FE16D68F128 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  6939 31133 25159
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external
      path 7FE0ED905528 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  101 174 31133 25159
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin IGP, localpref 100, valid, external
      Community: 101:20100 101:20110 101:22100 174:21101 174:22028
      Extended Community: RT:101:22100
      path 7FE17239B9C8 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7660 2516 174 31133 25159
    203.181.248.168 from 203.181.248.168 (203.181.248.168)
      Origin IGP, localpref 100, valid, external
      Community: 2516:1030 7660:9001
      path 7FE0B1196788 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 2
  2497 174 31133 25159
    202.232.0.2 from 202.232.0.2 (58.138.96.254)
      Origin IGP, localpref 100, valid, external
      path 7FE0C7E23DF8 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  49788 12552 31133 25159
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin IGP, localpref 100, valid, external
      Community: 12552:12000 12552:12100 12552:12101 12552:22000
      Extended Community: 0x43:100:1
      path 7FE12FD5E6D0 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1221 4637 31133 25159
    203.62.252.83 from 203.62.252.83 (203.62.252.83)
      Origin IGP, localpref 100, valid, external
      path 7FE178567A68 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3257 174 31133 25159
    89.149.178.10 from 89.149.178.10 (213.200.83.26)
      Origin IGP, metric 10, localpref 100, valid, external
      Community: 3257:8059 3257:30153 3257:50001 3257:54900 3257:54901
      path 7FE0F1584008 RPKI State valid
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  19214 174 31133 25159
    208.74.64.40 from 208.74.64.40 (208.74.64.40)
      Origin IGP, localpref 100, valid, external
      Community: 174:21101 174:22028
      path 7FE10C630BD0 RPKI State valid
      rx pathid: 0, tx pathid: 0
```

2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
Ответ:  
```
ras@ras-VirtualBox:~$ sudo modprobe -v dummy numdummies=2
[sudo] пароль для ras: 
insmod /lib/modules/5.13.0-28-generic/kernel/drivers/net/dummy.ko numdummies=0 numdummies=2
ras@ras-VirtualBox:~$ lsmod | grep dummy
dummy                  16384  0
ras@ras-VirtualBox:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:d4:f5:9c brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute enp0s3
       valid_lft 85262sec preferred_lft 85262sec
    inet6 fe80::1519:2033:a48b:f410/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 22:c4:f0:27:21:32 brd ff:ff:ff:ff:ff:ff
4: dummy1: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 5a:69:16:c4:1f:70 brd ff:ff:ff:ff:ff:ff
ras@ras-VirtualBox:~$ sudo ip addr add 192.168.1.150/24 dev dummy0
ras@ras-VirtualBox:~$ sudo ip addr add 192.168.2.150/24 dev dummy1
ras@ras-VirtualBox:~$ route
Таблица маршутизации ядра протокола IP
Destination Gateway Genmask Flags Metric Ref Use Iface
default         _gateway        0.0.0.0         UG    100    0        0 enp0s3
10.0.2.0        0.0.0.0         255.255.255.0   U     100    0        0 enp0s3
link-local      0.0.0.0         255.255.0.0     U     1000   0        0 enp0s3
ras@ras-VirtualBox:~$ routel
/usr/bin/routel: 48: shift: can't shift that many
         target            gateway          source    proto    scope    dev tbl
        default           10.0.2.2                     dhcp          enp0s3 
      10.0.2.0/ 24                       10.0.2.15   kernel     link enp0s3 
   169.254.0.0/ 16                                              link enp0s3 
       10.0.2.0          broadcast       10.0.2.15   kernel     link enp0s3 local
      10.0.2.15              local       10.0.2.15   kernel     host enp0s3 local
     10.0.2.255          broadcast       10.0.2.15   kernel     link enp0s3 local
      127.0.0.0          broadcast       127.0.0.1   kernel     link     lo local
     127.0.0.0/ 8            local       127.0.0.1   kernel     host     lo local
      127.0.0.1              local       127.0.0.1   kernel     host     lo local
127.255.255.255          broadcast       127.0.0.1   kernel     link     lo local
  192.168.1.150              local   192.168.1.150   kernel     host dummy0 local
  192.168.2.150              local   192.168.2.150   kernel     host dummy1 local
            ::1                                      kernel              lo 
        fe80::/ 64                                   kernel          enp0s3 
            ::1              local                   kernel              lo local
fe80::1519:2033:a48b:f410              local                   kernel          enp0s3 local
ras@ras-VirtualBox:~$ sudo ip route add 94.25.185.188 via 10.0.2.15
ras@ras-VirtualBox:~$ routel
         target            gateway          source    proto    scope    dev tbl
/usr/bin/routel: 48: shift: can't shift that many
        default           10.0.2.2                     dhcp          enp0s3 
      10.0.2.0/ 24                       10.0.2.15   kernel     link enp0s3 
  94.25.185.188          10.0.2.15                                   enp0s3 
   169.254.0.0/ 16                                              link enp0s3 
       10.0.2.0          broadcast       10.0.2.15   kernel     link enp0s3 local
      10.0.2.15              local       10.0.2.15   kernel     host enp0s3 local
     10.0.2.255          broadcast       10.0.2.15   kernel     link enp0s3 local
      127.0.0.0          broadcast       127.0.0.1   kernel     link     lo local
     127.0.0.0/ 8            local       127.0.0.1   kernel     host     lo local
      127.0.0.1              local       127.0.0.1   kernel     host     lo local
127.255.255.255          broadcast       127.0.0.1   kernel     link     lo local
  192.168.1.150              local   192.168.1.150   kernel     host dummy0 local
  192.168.2.150              local   192.168.2.150   kernel     host dummy1 local
            ::1                                      kernel              lo 
        fe80::/ 64                                   kernel          enp0s3 
            ::1              local                   kernel              lo local
fe80::1519:2033:a48b:f410              local                   kernel          enp0s3 local
ras@ras-VirtualBox:~$ 
```


3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.
Ответ:  

```  
ras@ras-VirtualBox:~$ sudo ss -lulpn4
State        Recv-Q       Send-Q               Local Address:Port                Peer Address:Port       Process                                                                                                  
UNCONN       0            0                          0.0.0.0:40933                    0.0.0.0:*                                                                                                                   
UNCONN       0            0                          0.0.0.0:2049                     0.0.0.0:*                                                                                                                   
UNCONN       0            0                    127.0.0.53%lo:53                       0.0.0.0:*           users:(("systemd-resolve",pid=613,fd=12))                                                               
UNCONN       0            0                          0.0.0.0:111                      0.0.0.0:*           users:(("rpcbind",pid=612,fd=5),("systemd",pid=1,fd=221))                                               
UNCONN       0            0                          0.0.0.0:37141                    0.0.0.0:*           users:(("rpc.mountd",pid=815,fd=8))                                                                     
UNCONN       0            0                          0.0.0.0:33218                    0.0.0.0:*           users:(("rpc.mountd",pid=815,fd=16))                                                                    
UNCONN       0            0                          0.0.0.0:43605                    0.0.0.0:*           users:(("firefox",pid=4937,fd=171))                                                                     
UNCONN       0            0                          0.0.0.0:631                      0.0.0.0:*           users:(("cups-browsed",pid=2191,fd=7))                                                                  
UNCONN       0            0                          0.0.0.0:44040                    0.0.0.0:*           users:(("avahi-daemon",pid=702,fd=14))                                                                  
UNCONN       0            0                          0.0.0.0:5353                     0.0.0.0:*           users:(("avahi-daemon",pid=702,fd=12))                                                                  
UNCONN       0            0                          0.0.0.0:38162                    0.0.0.0:*           users:(("rpc.mountd",pid=815,fd=12))   
ras@ras-VirtualBox:~$ sudo lsof -i -P | grep IPv4
systemd      1            root  220u  IPv4  16350      0t0  TCP *:111 (LISTEN)
systemd      1            root  221u  IPv4  16353      0t0  UDP *:111 
rpcbind    612            _rpc    4u  IPv4  16350      0t0  TCP *:111 (LISTEN)
rpcbind    612            _rpc    5u  IPv4  16353      0t0  UDP *:111 
systemd-r  613 systemd-resolve   12u  IPv4  25858      0t0  UDP localhost:53 
systemd-r  613 systemd-resolve   13u  IPv4  25859      0t0  TCP localhost:53 (LISTEN)
avahi-dae  702           avahi   12u  IPv4  28904      0t0  UDP *:5353 
avahi-dae  702           avahi   14u  IPv4  28906      0t0  UDP *:44040 
NetworkMa  709            root   23u  IPv4  31798      0t0  UDP ras-VirtualBox:68->_gateway:67 
rpc.mount  815            root    8u  IPv4  29724      0t0  UDP *:37141 
rpc.mount  815            root    9u  IPv4  29730      0t0  TCP *:48735 (LISTEN)
rpc.mount  815            root   12u  IPv4  29741      0t0  UDP *:38162 
rpc.mount  815            root   13u  IPv4  29744      0t0  TCP *:37715 (LISTEN)
rpc.mount  815            root   16u  IPv4  30213      0t0  UDP *:33218 
rpc.mount  815            root   17u  IPv4  30216      0t0  TCP *:51195 (LISTEN)
cupsd     2185            root    7u  IPv4  47071      0t0  TCP localhost:631 (LISTEN)
cups-brow 2191            root    7u  IPv4  47094      0t0  UDP *:631 
firefox   4937             ras   71u  IPv4 119416      0t0  TCP ras-VirtualBox:41290->top-fwz1.mail.ru:443 (ESTABLISHED)
firefox   4937             ras  115u  IPv4  87913      0t0  TCP ras-VirtualBox:44582->ec2-44-231-10-174.us-west-2.compute.amazonaws.com:443 (ESTABLISHED)
firefox   4937             ras  123u  IPv4 102937      0t0  TCP ras-VirtualBox:36790->yandex.ru:443 (ESTABLISHED)
firefox   4937             ras  167u  IPv4  89184      0t0  TCP ras-VirtualBox:42036->lb-140-82-113-26-iad.github.com:443 (ESTABLISHED)
firefox   4937             ras  171u  IPv4 119438      0t0  TCP ras-VirtualBox:40510->mad06s10-in-f2.1e100.net:443 (ESTABLISHED)
firefox   4937             ras  175u  IPv4 119403      0t0  TCP ras-VirtualBox:52252->104.22.40.171:443 (ESTABLISHED)
firefox   4937             ras  281u  IPv4 109739      0t0  TCP ras-VirtualBox:41260->mc.yandex.ru:443 (ESTABLISHED)
```
4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?
Ответ:  
```
ras@ras-VirtualBox:~$ sudo ss -4unlp
State        Recv-Q       Send-Q               Local Address:Port                Peer Address:Port       Process                                                                                                  
UNCONN       0            0                          0.0.0.0:40933                    0.0.0.0:*                                                                                                                   
UNCONN       0            0                          0.0.0.0:2049                     0.0.0.0:*                                                                                                                   
UNCONN       0            0                    127.0.0.53%lo:53                       0.0.0.0:*           users:(("systemd-resolve",pid=613,fd=12))                                                               
UNCONN       0            0                          0.0.0.0:111                      0.0.0.0:*           users:(("rpcbind",pid=612,fd=5),("systemd",pid=1,fd=221))                                               
UNCONN       0            0                          0.0.0.0:37141                    0.0.0.0:*           users:(("rpc.mountd",pid=815,fd=8))                                                                     
UNCONN       0            0                          0.0.0.0:33218                    0.0.0.0:*           users:(("rpc.mountd",pid=815,fd=16))                                                                    
UNCONN       0            0                          0.0.0.0:631                      0.0.0.0:*           users:(("cups-browsed",pid=2191,fd=7))                                                                  
UNCONN       0            0                          0.0.0.0:44040                    0.0.0.0:*           users:(("avahi-daemon",pid=702,fd=14))                                                                  
UNCONN       0            0                          0.0.0.0:5353                     0.0.0.0:*           users:(("avahi-daemon",pid=702,fd=12))                                                                  
UNCONN       0            0                          0.0.0.0:38162                    0.0.0.0:*           users:(("rpc.mountd",pid=815,fd=12))                                                                    
ras@ras-VirtualBox:~$ 
```
Avahi-daemon это система обеспечивающая обнаружение сервисов в локальной сети.  
systemd-resolved — служба systemd, выполняющая разрешение сетевых имён для локальных приложений   
pc.mountd - Демон монтирования NFS mountd обрабатывает запросы клиентов на монтирование каталогов.
cups-daemon система печати в UNIX
5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.  
Сервисом draw.io пользуюсь постоянно. Схему рисовать не стал, там все понятно, просто скину скрин шаблона сети
![image](https://user-images.githubusercontent.com/26147777/154260169-1953dd1d-5215-443d-8d17-505b782ac4e1.png)

