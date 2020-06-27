#!/bin/bash
 
#Подготовка
#ssh
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
systemctl restart ssh
systemctl restart sshd
 
mkdir /etc/apt/sources.list.d
#Cтавим приоритет на постгрес
echo "Package: *
Pin: release n=stretch-pgdg
Pin-Priority: 1000" > /etc/apt/preferences.d/postgresql
 
#Добавляю репозитории
echo "deb [trusted=yes] https://download.astralinux.ru/astra/stable/orel/repository/ orel main contrib non-free" >> /etc/apt/sources.list
echo "deb http://mirror.yandex.ru/astra/stable/orel/repository/ orel main contrib non-free" >> /etc/apt/sources.list
echo "deb [trusted=yes arch=amd64] https://download.docker.com/linux/debian stretch stable" >> /etc/apt/sources.list
echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "alias ll='ls -l'" >> ~/.bashrc
#echo "alias python='python3.8'
#      alias pip='pip3.8'" >> ~/.bashrc
 
apt update
 
apt install -y gnupg \
    libicu57 \
    make \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
 
 
 
source ~/.bashrc
 
  
 
 
#install python 3.8.3 & LDAP & GDAL
####
    apt install -y gdal-bin
    apt install -y libsasl2-dev libldap2-dev libssl-dev
    apt install -y gcc zlib1g-dev
 
 
apt-get install -y libffi-dev
apt-get install -y python-pil python-yaml libproj12
apt-get install -y libgeos-dev python-lxml libgdal-dev python-shapely
apt-get install -y build-essential python-dev libjpeg-dev zlib1g-dev libfreetype6-dev
 
cd /opt
wget https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tar.xz
tar -xvf Python-3.8.3.tar.xz
cd Python-3.8.3
sudo ./configure --enable-optimizations
sudo make altinstall
python3.8 -V
 
 
apt update
 
# Это не работает #####    python3.8 -m pip install -r requirements.txt --no-cache-dir
 
 
 
cd /opt
sudo rm -f Python-3.8.3.tar.xz
 
####
 
#install postgresql 10
####
      
apt install -y postgresql-10
 
systemctl enable postgresql
su postgres
psql
ALTER USER postgres WITH ENCRYPTED PASSWORD '12345678';
\q
exit
ss -tunelp | grep 5432
 
 
echo "listen_addresses = '*'" >> /etc/postgresql/10/main/postgresql.conf
echo "host    all     all             0.0.0.0/0                 md5" >> /etc/postgresql/10/main/pg_hba.conf
 
systemctl restart postgresql
###
 
#install postgis
####
apt install -y postgresql-10-postgis-3
 
su postgres
psql
 
 
 
 
 
 
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_raster;
CREATE EXTENSION postgis_topology;
CREATE EXTENSION postgis_sfcgal;
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION address_standardizer;
CREATE EXTENSION address_standardizer_data_us;
CREATE EXTENSION postgis_tiger_geocoder;
 
\q
exit
     
 
 
####
 
#install nginx
####
 
apt install -y nginx
 
 
 
 
####
 
#install django & mapproxy
####
 
pip3.8 install --upgrade pip
pip3.8 install virtualenv
pip3.8 install Pillow
pip3.8 install django
pip3.8 install mapproxy
 
 
 
#install Docker
####
 
 
     
apt install -y docker-ce docker-ce-cli containerd.io
 
 
curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
 
 
 
#create Image
cd /opt
tar --numeric-owner --exclude=/proc --exclude=/sys --exclude=/dev --exclude=/run -cvf orel.tar /
ls -alh orel.tar
cat orel.tar | docker import - piratetm/orel
docker images -a
#docker run -it orel bash
 
 
 
#docker login -u твой_Логин -p твой_Пароль_От_Репозитория твойРепозиторий
#docker push piratetm/orel
