# argun

Этот скрипт должен автоматически создать зеркало репозитория Debian 9, Astra Orel и его mirror.
А так же загрузить все пакеты в repo-manage - nexus3.


Запуск astra_apt_nexus3.sh с вводом аргументов:
./astra_apt_nexus3.sh MyUser PasswordUser ipHost MyBestRepo1 MyBestRepo2 MyBestRepo3

Ex:
./astra_apt_nexus3.sh admin 12345678 192.168.10.109 Astra-Mirror


Переменные, которые стоят можно сделать статическими
user=$1
pass=$2
addr=$3
repo1="https://$addr/repository/$4"
repo2="https://$addr/repository/$5"
repo3="https://$addr/repository/$6"
