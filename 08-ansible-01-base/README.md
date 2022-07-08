# Домашнее задание к занятию "08.01 Введение в Ansible"

## Основная часть
1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте какое значение имеет факт `some_fact` для указанного хоста при выполнении playbook'a.
## Ответ
```
 ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] ***********************************************************************

TASK [Gathering Facts] **********************************************************************
ok: [localhost]

TASK [Print OS] *****************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP **********************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


```
2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.
```
ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] ***********************************************************************

TASK [Gathering Facts] **********************************************************************
ok: [localhost]

TASK [Print OS] *****************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP **********************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
+
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
```
 ⚙ ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  sudo ansible-playbook -i inventory/prod.yml site.yml       


PLAY [Print os facts] **********************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [cent]
ok: [ubuntu]

TASK [Print OS] ****************************************************************************************************************************************
ok: [cent] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************************
ok: [cent] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP *********************************************************************************************************************************************
cent                       : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились следующие значения: для `deb` - 'deb default fact', для `el` - 'el default fact'.
```
✘ ⚙ ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  cat group_vars/deb/examp.yml ;echo ""
---
  some_fact: "deb default fact"

 ⚙ ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  cat group_vars/el/examp.yml ;echo ""
---
  some_fact: "el default fact"

```
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
```
 ⚙ ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  sudo ansible-playbook -i inventory/prod.yml site.yml 

PLAY [Print os facts] **********************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [cent]
ok: [ubuntu]

TASK [Print OS] ****************************************************************************************************************************************
ok: [cent] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************************
ok: [cent] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *********************************************************************************************************************************************
cent                       : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


```

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
``✘ ⚙ ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  ansible-vault encrypt group_vars/deb/examp.yml          
New Vault password: 
Confirm New Vault password: 
Encryption successful
 ⚙ ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  ansible-vault encrypt group_vars/el/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
```

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
```
✘ ⚙ ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  sudo ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password: 

PLAY [Print os facts] **********************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [cent]
ok: [ubuntu]

TASK [Print OS] ****************************************************************************************************************************************
ok: [cent] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************************
ok: [cent] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *********************************************************************************************************************************************
cent                       : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
local
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
```
 ⚙ ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  cat inventory/prod.yml ; echo ""
---
  el:
    hosts:
      cent:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local

```
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
```
⚙ ras@ras-VirtualBox  ~/DevOps/08-ansible-01-base/playbook   main ±  sudo ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password: 

PLAY [Print os facts] **********************************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************************************
ok: [localhost]
ok: [cent]
ok: [ubuntu]

TASK [Print OS] ****************************************************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}
ok: [cent] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] **************************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
ok: [cent] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *********************************************************************************************************************************************
cent                       : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
+
