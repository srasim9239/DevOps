## Домашнее задание по курсу "DevOps"
Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"


1.Установите средство виртуализации Oracle VirtualBox.
![Снимок экрана от 2021-12-29 18-34-33](https://user-images.githubusercontent.com/26147777/147685095-fbacaa2c-4cf9-4c27-9f95-ab1a6421e36a.png)


2.Установите средство автоматизации Hashicorp Vagrant.
![Снимок экрана от 2021-12-29 18-42-11](https://user-images.githubusercontent.com/26147777/147679101-e1c32cc5-844a-4b96-b1fd-acf996ba4c51.png)

3.В вашем основном окружении подготовьте удобный для дальнейшей работы терминал.
![Снимок экрана от 2021-12-29 18-41-31](https://user-images.githubusercontent.com/26147777/147679051-48b20eec-c64d-4ada-aa67-f1697dffe933.png)

4.С помощью базового файла конфигурации запустите Ubuntu 20.04 в VirtualBox посредством Vagrant:
![Снимок экрана от 2021-12-29 18-46-29](https://user-images.githubusercontent.com/26147777/147679502-48762c33-cc13-4996-b730-e0c08655888b.png)

5.Ознакомьтесь с графическим интерфейсом VirtualBox
Выделено 1Гб RAM, 2 ядраб, 4мб VRAM, 64GB хранилище
![Снимок экрана от 2021-12-29 18-49-29](https://user-images.githubusercontent.com/26147777/147679884-1e5222d8-7894-4bab-90a5-de3ee9921cb8.png)

6.Как добавить оперативной памяти или ресурсов процессора виртуальной машине?

Редактируется файл конфигураци созданный ранее или в GUI

![Снимок экрана от 2021-12-29 18-57-07](https://user-images.githubusercontent.com/26147777/147680647-535ff398-7ace-4d29-95e2-78278e791f4b.png)

7.Команда vagrant ssh
![Снимок экрана от 2021-12-29 18-59-51](https://user-images.githubusercontent.com/26147777/147680813-b33f542b-e3d6-4288-a7e5-c8e4267c0e96.png)

8.Ознакомиться с разделами man bash
 1.HISTFILESIZE 1155я строка
 2.HISTSIZE 1178я строка
 3.ignoreboth это сокращение для 2х директив ignorespace and ignoredups, 
    ignorespace - не сохранять команды начинающиеся с пробела, 
    ignoredups - не сохранять команду, если такая уже имеется в истории

9. {} Команда интерпретируется как список команд, разделенных точкой с запятой, с вариациями, представленными в фигурных скобках.
например mkdir ./DIR_{A..Z} - создаст каталоги сименами DIR_A, DIR_B и т.д. до DIR_Z
строка 343
10. touch {000001..100000}.txt
Создать 300к файлов не дает, слишком длинный аргумент, но можно создать партиями.
11. Проверяет условие (-d /tmp) и возвращает ее статус (0 или 1), наличие каталога /tmp
12. Редактирование Bash Path
![Снимок экрана от 2021-12-29 19-40-09](https://user-images.githubusercontent.com/26147777/147684574-55d60bd1-7202-408e-a6b0-4a34c02837a6.png)

13. at - команда запускается в указанное время
batch или его псевдоним at -b, планирует задания и выполняет их в очереди пакетов, когда позволяет уровень загрузки системы. По умолчанию задания выполняются, когда средняя загрузка системы ниже 1,5. 
14. vagrant suspend


