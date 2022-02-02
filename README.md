## Домашнее задание по курсу "DevOps"
# Домашнее задание к занятию "3.5. Файловые системы"

1. Узнайте о [sparse](https://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D1%80%D0%B5%D0%B6%D1%91%D0%BD%D0%BD%D1%8B%D0%B9_%D1%84%D0%B0%D0%B9%D0%BB) (разряженных) файлах.  
Ответ:  
Изучил, стало понятнее как работает Torrent и подобные системы  

1. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?  
Ответ:  
Не могут, т.к. hardlink это ссылка на тот же самый файл и имеет тот же inode, значит права будут одни.
Проверяем...
![Снимок экрана от 2022-02-02 14-36-06](https://user-images.githubusercontent.com/26147777/152146492-3e397606-fb11-4333-a84b-1680a09c7059.png)


1. Сделайте `vagrant destroy` на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile следующим:

    ```bash![Uploading Снимок экрана от 2022-02-02 14-36-06.png…]()

    Vagrant.configure("2") do |config|
      config.vm.box = "bento/ubuntu-20.04"
      config.vm.provider :virtualbox do |vb|
        lvm_experiments_disk0_path = "/tmp/lvm_experiments_disk0.vmdk"
        lvm_experiments_disk1_path = "/tmp/lvm_experiments_disk1.vmdk"
        vb.customize ['createmedium', '--filename', lvm_experiments_disk0_path, '--size', 2560]
        vb.customize ['createmedium', '--filename', lvm_experiments_disk1_path, '--size', 2560]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk0_path]
        vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', lvm_experiments_disk1_path]
      end
    end
    ```

    Данная конфигурация создаст новую виртуальную машину с двумя дополнительными неразмеченными дисками по 2.5 Гб.  
Ответ:  
![Снимок экрана от 2022-02-02 14-44-04](https://user-images.githubusercontent.com/26147777/152147627-b2dfdaf4-6267-4926-9584-0b00fba4d0c7.png)


1. Используя `fdisk`, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.  
Ответ:  
![Снимок экрана от 2022-02-02 15-28-24](https://user-images.githubusercontent.com/26147777/152153732-7266e46e-8cb4-4de7-8ce0-eca130b0c860.png)


1. Используя `sfdisk`, перенесите данную таблицу разделов на второй диск.  
Ответ:  
![Снимок экрана от 2022-02-02 15-34-54](https://user-images.githubusercontent.com/26147777/152154660-4113cb3f-7557-4dce-992e-87bf029996ea.png)


1. Соберите `mdadm` RAID1 на паре разделов 2 Гб.  
Ответ:  
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
![Снимок экрана от 2022-02-02 15-51-13](https://user-images.githubusercontent.com/26147777/152157334-1c4b7c1d-a68e-400b-8b89-0104528a57ac.png)

1. Соберите `mdadm` RAID0 на второй паре маленьких разделов.  
Ответ:  
sudo mdadm --create /dev/md1 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2
![Снимок экрана от 2022-02-02 15-52-39](https://user-images.githubusercontent.com/26147777/152157483-7a494623-393a-46f0-946b-c6bdce1e745b.png)

1. Создайте 2 независимых PV на получившихся md-устройствах.  
Ответ:  
![Снимок экрана от 2022-02-02 15-55-55](https://user-images.githubusercontent.com/26147777/152158082-7b506549-91b6-45b2-aae0-3f1f7de01b3a.png)

1. Создайте общую volume-group на этих двух PV.  
Ответ:  
![Снимок экрана от 2022-02-02 16-08-15](https://user-images.githubusercontent.com/26147777/152159863-d7c4b970-75ce-4a63-9d78-9d0ce32851f8.png)

1. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.  
Ответ:  
![Снимок экрана от 2022-02-02 16-13-28](https://user-images.githubusercontent.com/26147777/152160543-826579bd-d6dd-4a99-a5d3-e27cf077a702.png)

1. Создайте `mkfs.ext4` ФС на получившемся LV.  
Ответ:  
![Снимок экрана от 2022-02-02 16-14-52](https://user-images.githubusercontent.com/26147777/152160769-4cb1cffe-6d11-4965-b2c0-57df63a98bb4.png)

1. Смонтируйте этот раздел в любую директорию, например, `/tmp/new`.  
Ответ:  
![Снимок экрана от 2022-02-02 16-16-51](https://user-images.githubusercontent.com/26147777/152161082-e244bdf4-1dff-4c1c-a639-41072c19d7ea.png)

1. Поместите туда тестовый файл, например `wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz`.  
Ответ:  
![Снимок экрана от 2022-02-02 16-17-52](https://user-images.githubusercontent.com/26147777/152161223-de122478-dd96-45a1-96f2-f32e76fd39ca.png)

1. Прикрепите вывод `lsblk`.  
Ответ:  
![Снимок экрана от 2022-02-02 16-19-56](https://user-images.githubusercontent.com/26147777/152161629-4de26bed-fe8f-4c17-b6ad-84cb45bd6a4b.png)

1. Протестируйте целостность файла:  

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```  
Ответ:  
![Снимок экрана от 2022-02-02 16-21-19](https://user-images.githubusercontent.com/26147777/152161795-f775453f-eea3-4f13-9809-d0741356eace.png)


1. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.  
Ответ:  
![Снимок экрана от 2022-02-02 16-23-59](https://user-images.githubusercontent.com/26147777/152162272-207d1b51-a034-437e-b9c6-4546d9296ce2.png)

1. Сделайте `--fail` на устройство в вашем RAID1 md.  
Ответ:  
dadm /dev/md0 --fail /dev/sdb1
![Снимок экрана от 2022-02-02 16-29-41](https://user-images.githubusercontent.com/26147777/152163194-63563162-777b-4924-9834-5081a1461164.png)

1. Подтвердите выводом `dmesg`, что RAID1 работает в деградированном состоянии.  
Ответ:  
![Снимок экрана от 2022-02-02 16-31-15](https://user-images.githubusercontent.com/26147777/152163348-89b8f314-cc95-4368-ad05-0b48dd1d33fc.png)  
1. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен:

    ```bash
    root@vagrant:~# gzip -t /tmp/new/test.gz
    root@vagrant:~# echo $?
    0
    ```  
Ответ:  
![Снимок экрана от 2022-02-02 16-31-58](https://user-images.githubusercontent.com/26147777/152163458-abb2e6f4-baa8-4b10-95cb-f60f37ee7a3c.png)  

1. Погасите тестовый хост, `vagrant destroy`.  

Ответ:  
![Снимок экрана от 2022-02-02 16-33-18](https://user-images.githubusercontent.com/26147777/152163681-3af80aca-3a98-44ca-9fb9-8eb46d227d21.png)
