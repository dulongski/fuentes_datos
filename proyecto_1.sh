#!/bin/bash

if [ -e estaciones.xml ]
then
:
else
wget -O - https://bit.ly/2V1Z3sm > estaciones.xml
fi

if [ -e precios.xml ]
then
:
else
wget -O -  https://bit.ly/2JNcTha > precios.xml
fi

file1="$1"
file2="$2"
bash proyecto_1_transform_1.sh $file1
bash proyecto_1_transform_2.sh $file2
bash proyecto_1_load.sh

