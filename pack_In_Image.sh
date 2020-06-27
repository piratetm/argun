#!/bin/bash
#create Image
cd /opt
tar --numeric-owner --exclude=/proc --exclude=/sys --exclude=/dev --exclude=/run -cvf orel.tar /
ls -alh orel.tar
cat orel.tar | docker import - piratetm/orel
docker images -a
#docker run -it orel bash
 
 
 
#docker login -u твойЛогинВДокерХабе
#docker push репозиторийВнашемХабе/orel
