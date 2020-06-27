# argun

Запуск astra_apt_nexus3.sh с вводом аргументов:
./astra_apt_nexus3.sh MyUser PasswordUser ipHost MyBestRepo1 MyBestRepo2 MyBestRepo3

Ex:
./astra_apt_nexus3.sh admin 12345678 192.168.10.109 Astra-Mirror


Переменные, которые стоят можно сделать статическими
user=$1
pass=$2

#УКАЗЫВАЕМ РЕПОЗИТОРИИ В КОТОРЫЕ БУДЕМ ДЕЛАТЬ ЗАЛИВКУ и ip адрес/хост
addr=$3
repo1="https://$addr/repository/$4"
repo2="https://$addr/repository/$5"
repo3="https://$addr/repository/$6"
