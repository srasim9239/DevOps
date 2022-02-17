# Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"

1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.  
Ответ:  
![Снимок экрана от 2022-02-17 12-23-48](https://user-images.githubusercontent.com/26147777/154445432-0c077240-bbc0-4b06-8220-5a6d8a7db945.png)

2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.  
![Снимок экрана от 2022-02-17 12-34-01](https://user-images.githubusercontent.com/26147777/154447241-af25ce41-0b4c-4578-8f8b-d51c0a020548.png)
![Снимок экрана от 2022-02-17 12-37-58](https://user-images.githubusercontent.com/26147777/154447911-4ae8a247-b2ac-410f-b9b3-779d18429b04.png)

3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.  
![Снимок экрана от 2022-02-17 13-20-50](https://user-images.githubusercontent.com/26147777/154456741-70fad97c-f4b0-404b-8a13-14f5596d02b0.png)

4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).  

![Снимок экрана от 2022-02-17 13-29-33](https://user-images.githubusercontent.com/26147777/154457716-86cc6ff6-fb36-4077-b01d-4258948c55ba.png)
![Снимок экрана от 2022-02-17 13-30-48](https://user-images.githubusercontent.com/26147777/154457723-ba5e02c9-dba5-4e7c-897e-c315aafe44d5.png)

5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
 Ответ:  
 1.Генерация ключа  
 2. Копирование на удаленный сервер. Командой ssh-copy-id не получилось, только через cat ~/.ssh/id_rsa.pub | ssh ras@192.168.11.27 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"  
 3. Попытка подключения без парольной авторизации  
 ```
  ✘ ⚙ ras@ras-VirtualBox  ~  ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/ras/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/ras/.ssh/id_rsa
Your public key has been saved in /home/ras/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:---------------------- ras@ras-VirtualBox
The key's randomart image is:
+---[RSA 3072]----+
|                 |
|. *              |
|.B =o .  .       |
|. =..= ooo       |
|   o..* Soo      |
|  . oвыф   |
|    o=.o=*o      |
+----[SHA256]-----+
 ⚙ ras@ras-VirtualBox  ~  ssh-copy-id ras@192.168.11.27
/usr/bin/ssh-copy-id: ERROR: No identities found
 ✘ ⚙ ras@ras-VirtualBox  ~  cat ~/.ssh/id_rsa.pub | ssh ras@192.168.11.27 "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
ras@192.168.11.27's password: 

 ⚙ ras@ras-VirtualBox  ~  ssh ras@192.168.11.27 
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.11.0-46-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

35 updates can be applied immediately.
Чтобы просмотреть дополнительные обновления выполните: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.
*** System restart required ***
Last login: Thu Feb 17 14:00:46 2022 from 172.16.3.33
ras@ras-ub ~ % 
```

6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.  
Ответ:  
Файлы переименуются без проблем.   
Правим config и пробуем подключиться по имени  
```
 ⚙ ras@ras-VirtualBox  ~/.ssh  cat ~/.ssh/config                                
Host ub
    HostName 192.168.11.27
    User ras
 ⚙ ras@ras-VirtualBox  ~/.ssh  ssh ub
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.11.0-46-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

35 updates can be applied immediately.
Чтобы просмотреть дополнительные обновления выполните: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.
*** System restart required ***
Last login: Thu Feb 17 14:36:52 2022 from 172.16.3.33
ras@ras-ub ~ % 
```
7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.
Ответ:  
Командой sudo tcpdump -w f.pcap -c 100 сохраняем пакеты в файл.
И смотрим через wireshark  
![Снимок экрана от 2022-02-17 14-52-27](https://user-images.githubusercontent.com/26147777/154476312-3c9e2adc-0a95-4358-b41f-73cf48b6c5d2.png)

