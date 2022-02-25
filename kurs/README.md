# Курсовая работа по итогам модуля "DevOps и системное администрирование"


- Процесс установки и настройки ufw  
![Снимок экрана от 2022-02-24 13-40-54](https://user-images.githubusercontent.com/26147777/155687961-59c7164f-9fd5-4ec8-b1a6-45654953cb9d.png)  

- Процесс установки и выпуска сертификата с помощью hashicorp vault  
![Снимок экрана от 2022-02-24 13-45-33](https://user-images.githubusercontent.com/26147777/155688479-1d768caf-b5e5-4e52-8363-857602b5aee6.png)  
![Снимок экрана от 2022-02-24 14-22-09](https://user-images.githubusercontent.com/26147777/155688489-69dcfe45-8ac8-44dd-bb3e-cb3262c45db1.png)  
Запускаем vault server -dev -dev-root-token-id root  
![Снимок экрана от 2022-02-24 14-22-21](https://user-images.githubusercontent.com/26147777/155688698-c853ff48-ce6a-4006-8439-cd6d0b98348c.png)  
![Снимок экрана от 2022-02-24 14-22-28](https://user-images.githubusercontent.com/26147777/155688704-10058120-7578-454e-8b3f-3b7031c35980.png)  

- Процесс установки и настройки сервера nginx  
```
sudo apt-get install nginx  
```
- Страница сервера nginx в браузере хоста не содержит предупреждений  
Добавляем корневой сертификат в доверенные.   
![Снимок экрана от 2022-02-25 09-51-53](https://user-images.githubusercontent.com/26147777/155695017-02e138de-b1c2-44d7-9841-04d0e807be7b.png)

- Скрипт генерации нового сертификата работает (сертификат сервера ngnix должен быть "зеленым")  
![Снимок экрана от 2022-02-25 13-10-38](https://user-images.githubusercontent.com/26147777/155696897-8b25e078-4ac6-44cc-afc6-d1296d2c156e.png)
сам скрипт лежит рядом  

После переносим корневой сертификат на хост и снова добавляем в доверенные  
![Снимок экрана от 2022-02-25 13-45-53](https://user-images.githubusercontent.com/26147777/155702188-e71ff406-ad31-45d1-bf0b-ede02b2a6227.png)  
Ниже описанный способ у меня не отрабатывает. Пришлось добавлять в браузере вручную.
```
 ras@ras-VirtualBox  ~  sudo cp /home/ras/CA_cert.crt /usr/share/ca-certificates/CA_cert.crt
 ras@ras-VirtualBox  ~  sudo update-ca-certificates
Updating certificates in /etc/ssl/certs...
0 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.
```
- Crontab работает (выберите число и время так, чтобы показать что crontab запускается и делает что надо)
