# Домашнее задание к занятию "08.02 Работа с Playbook"

## Основная часть
1. Приготовьте свой собственный inventory файл `prod.yml`.
## Ответ
```
---
      elasticsearch:
        hosts:
          elastic:
            ansible_connection: docker
      kibana:
        hosts:
          kibana:
            ansible_connection: docker
```
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает kibana.
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, сгенерировать конфигурацию с параметрами.
## Ответ
```
name: Install Kibana
  hosts: kibana
  tasks:
    - name: Upload tar.gz kibana from remote URL
      get_url:
        url: "https://artifacts.elastic.co/downloads/kibana/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        mode: 0755
        timeout: 60
        force: true
        validate_certs: false
      register: get_kibana
      until: get_kibana is succeeded
      tags: kibana
    - name: Create directrory for kibana
      file:
        state: directory
        path: "{{ kibana_home }}"
      tags: kibana
    - name: Extract kibana in the installation directory
      become: true
      unarchive:
        copy: false
        src: "/tmp/kibana-{{ kibana_version }}-linux-x86_64.tar.gz"
        dest: "{{ kibana_home }}"
        extra_opts: [--strip-components=1]
        creates: "{{ kibana_home }}/bin/kibana"
      tags:
        - kibana
    - name: Set environment kibana
      become: true
      template:
        src: templates/kib.sh.j2
        dest: /etc/profile.d/kib.sh
      tags: kibana
```
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
## Ответ
```
 ras@ras-VirtualBox  ~/DevOps/08-ansible-02-playbook/playbook   main ±  ansible-lint site.yml -vvv
Examining site.yml of type playbook

```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
✘ ras@ras-VirtualBox  ~/DevOps/08-ansible-02-playbook/playbook   main ±✚  ansible-playbook -i inventory/prod.yml site.yml --check
[WARNING]: Found both group and host with same name: kibana

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [elastic]
ok: [kibana]

TASK [Set facts for Java 11 vars] **********************************************
ok: [kibana]
ok: [elastic]

TASK [Upload .tar.gz file containing binaries from local storage] **************
changed: [elastic]
changed: [kibana]

TASK [Ensure installation dir exists] ******************************************
changed: [kibana]
changed: [elastic]

TASK [Extract java in the installation directory] ******************************
fatal: [kibana]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.15.1' must be an existing dir"}
fatal: [elastic]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.15.1' must be an existing dir"}

PLAY RECAP *********************************************************************
elastic                    : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
kibana                     : ok=4    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   

```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```
 ✘ ras@ras-VirtualBox  ~/DevOps/08-ansible-02-playbook/playbook   main ±✚  ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: Found both group and host with same name: kibana

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [elastic]
ok: [kibana]

TASK [Set facts for Java 11 vars] **********************************************
ok: [kibana]
ok: [elastic]

TASK [Upload .tar.gz file containing binaries from local storage] **************
ok: [kibana]
ok: [elastic]

TASK [Ensure installation dir exists] ******************************************
ok: [elastic]
ok: [kibana]

TASK [Extract java in the installation directory] ******************************
skipping: [kibana]
skipping: [elastic]

TASK [Export environment variables] ********************************************
ok: [kibana]
ok: [elastic]

PLAY [Install Elasticsearch] ***************************************************

TASK [Gathering Facts] *********************************************************
ok: [elastic]

TASK [Upload .tar.gz file containing binaries from local storage] **************
ok: [elastic]

TASK [Create directrory for Elasticsearch] *************************************
ok: [elastic]

TASK [Extract Elasticsearch in the installation directory] *********************
ok: [elastic]

TASK [Set environment Elastic] *************************************************
ok: [elastic]

PLAY [Install Kibana] **********************************************************

TASK [Gathering Facts] *********************************************************
ok: [kibana]

TASK [Upload .tar.gz file containing binaries from local storage] **************
ok: [kibana]

TASK [Create directrory for kibana] ********************************************
ok: [kibana]

TASK [Extract kibana in the installation directory] ****************************
ok: [kibana]

TASK [Set environment kibana] **************************************************
--- before
+++ after: /home/ras/.ansible/tmp/ansible-local-75786yjnj8v9b/tmpv7i4nkb5/kib.sh.j2
@@ -0,0 +1,5 @@
+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
+#!/usr/bin/env bash
+
+export KB_HOME=/opt/kibana/8.3.2
+export PATH=$PATH:$KB_HOME/bin

changed: [kibana]

PLAY RECAP *********************************************************************
elastic                    : ok=10   changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
kibana                     : ok=10   changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0 
```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```
 ras@ras-VirtualBox  ~/DevOps/08-ansible-02-playbook/playbook   main ±✚  ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: Found both group and host with same name: kibana

PLAY [Install Java] ************************************************************

TASK [Gathering Facts] *********************************************************
ok: [elastic]
ok: [kibana]

TASK [Set facts for Java 11 vars] **********************************************
ok: [elastic]
ok: [kibana]

TASK [Upload .tar.gz file containing binaries from local storage] **************
ok: [elastic]
ok: [kibana]

TASK [Ensure installation dir exists] ******************************************
ok: [kibana]
ok: [elastic]

TASK [Extract java in the installation directory] ******************************
skipping: [elastic]
skipping: [kibana]

TASK [Export environment variables] ********************************************
ok: [elastic]
ok: [kibana]

PLAY [Install Elasticsearch] ***************************************************

TASK [Gathering Facts] *********************************************************
ok: [elastic]

TASK [Upload .tar.gz file containing binaries from local storage] **************
ok: [elastic]

TASK [Create directrory for Elasticsearch] *************************************
ok: [elastic]

TASK [Extract Elasticsearch in the installation directory] *********************
ok: [elastic]

TASK [Set environment Elastic] *************************************************
ok: [elastic]

PLAY [Install Kibana] **********************************************************

TASK [Gathering Facts] *********************************************************
ok: [kibana]

TASK [Upload .tar.gz file containing binaries from local storage] **************
ok: [kibana]

TASK [Create directrory for kibana] ********************************************
ok: [kibana]

TASK [Extract kibana in the installation directory] ****************************
ok: [kibana]

TASK [Set environment kibana] **************************************************
ok: [kibana]

PLAY RECAP *********************************************************************
elastic                    : ok=10   changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   
kibana                     : ok=10   changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   


```
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, в ответ предоставьте ссылку на него.

