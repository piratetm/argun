#!/bin/bash

#Чтобы закачать 1 файл
#curl -k -u "admin:12345678" -H "Content-Type: multipart/form-data" --data-binary "@./kerio-control-vpnclient-linux-amd64.deb" "http://localhost:8081/repository/Astra-Mirror/"



#Устанавливем apt-mirror
apt-get install -y apt-mirror curl

#Создаем каталоги для работы
mkdir -p /mnt/repo/debian/{mirror,var,skel}


#Дергаем строки с моего файла mirror.list с гитхабе
https://raw.githubusercontent.com/piratetm/argun/master/mirror.list>/etc/apt/mirror.list

apt-mirror

#########################

#Для автоматической синхронизации и очистки зеркал нужно добавить строку в настройки cron и выставить подходящее время. Обновление официальных зеркал происходит каждые 6 часов: 3:00,9:00,15:00,21:00. Например так:

#crontab -e

#05 01 * * *     apt-mirror >> /var/log/apt-mirror.log
#05 03 * * *     /mnt/repo/debian/var/clean.sh >> /var/log/apt-mirror.log

#########################


#Создаем комплект переменных, чтобы не мазолить глаза и вводим свои данные к репозиториям
#"https://192.168.10.109/repository/Astra-Mirror/"
# Как создать репозиторий для Debian https://help.sonatype.com/repomanager3/formats/apt-repositories
./$0 admin 12345678 192.168.10.109 Astra-Mirror

#ВВОДИМ ЛОГИН И ПАРОЛЬ
user=$1
pass=$2

#УКАЗЫВАЕМ РЕПОЗИТОРИИ В КОТОРЫЕ БУДЕМ ДЕЛАТЬ ЗАЛИВКУ и ip адрес/хост
addr=$3
repo1="https://$addr/repository/$4"
repo2="https://$addr/repository/$5"
repo3="https://$addr/repository/$6"

h="Content-Type: multipart/form-data"




#########################____REPO 111111_____##################################
#Ищем все файлы в скаченном репозитории download.astralinux.ru
file=$(find /mnt/repo/debian/mirror/download.astralinux.ru/astra/ .deb)
#Добавляем список в файл
echo $file>/opt/repo1


#Создаем цикл, где будем искать каждую строку в файле и добавлять в переменную variable
for variable in `< /opt/repo1`
do
#выполняем при каждом нахождении строки команду на закачку пакета в репозиторий
curl -k -u $user:$pass -H $h --data-binary "@$variable" $repo1
#Тут отображается текучая строка из файла
echo $variable
done 
#########################____REPO 222222_____##################################

#Ищем все файлы в скаченном репозитории download.astralinux.ru
file=$(find /mnt/repo/debian/mirror/download.astralinux.ru/astra/ .deb)
#Добавляем список в файл
echo $file>/opt/repo2

for variable in `< /opt/repo2`
do
#выполняем при каждом нахождении строки команду на закачку пакета в репозиторий
curl -k -u $user:$pass -H $h --data-binary "@$variable" $repo2
#Тут отображается текучая строка из файла
echo $variable
done 

#########################____REPO 333333_____##################################
#Ищем все файлы в скаченном репозитории download.astralinux.ru
file=$(find /mnt/repo/debian/mirror/download.astralinux.ru/astra/ .deb)
#Добавляем список в файл
echo $file>/opt/repo3

for variable in `< /opt/repo3`
do
#выполняем при каждом нахождении строки команду на закачку пакета в репозиторий
curl -k -u $user:$pass -H $h --data-binary "@$variable" $repo3
#Тут отображается текучая строка из файла
echo $variable
done 
####################################################################################


