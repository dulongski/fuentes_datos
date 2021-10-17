#!/bin/bash

file="$1"

sed -e 's/^ *//' $file |
sed -r 's/<name>(.*)<\/name>/nombre \1/'|
sed -r 's/<x>([+-]?[0-9]+\.?[0-9]*)<\/x>/longitud \1/' |
sed -r 's/<y>([+-]?[0-9]+\.?[0-9]*)<\/y>/latitud \1/' |
sed -r 's/<place place_id="([0-9]+)">/estacion_servicio \1/'|
sed -r 's/<cre_id>.*<\/cre_id>//' |
sed -r 's/<location>//' |
sed -r 's/<\/location>//' |

awk '{RS="</place>"
    match($0,/estacion_servicio ([0-9]+)/,id)
    if (match($0, /nombre (.*)\s/, nombre)) print "id", id[1], "nombre", nombre[1];
    if (match($0, /longitud ([+-]?[0-9]+\.?[0-9]*)/, longitud)) print "id", id[1], "longitud", longitud[1];
    if (match($0, /latitud ([+-]?[0-9]+\.?[0-9]*)/, latitud)) print "id", id[1], "latitud", latitud[1]}' |

sed 's/^[^i].*//' |

awk '{
	match($0,/id ([0-9]+)/,id)
	if (match($0, /nombre (.*)\s/, info)) nom[id[1]] = info[1];
	if (match($0, /longitud ([+-]?[0-9]+\.?[0-9]*)/, info)) lon[id[1]] = info[1];
	if (match($0, /latitud ([+-]?[0-9]+\.?[0-9]*)/, info)) lat[id[1]] = info[1];
	ids[id[1]] = id[1]
	} END{
       for (element in ids) 
       print element, ",",nom[element], ",", lat[element], ",", lon[element]
	}' |
sed 's/ , /,/g' > estaciones.csv


sed -i -r 's/,(([a-z]|[A-Z]).*),/,\L\1,/' estaciones.csv

sed -i -r 'y/áéíóúÁÉÍÓÚ/aeiouAEIOU/' estaciones.csv

sed -i -r 's/(;|:)//g' estaciones.csv

sed -i -r 's/-([A-Za-z])/\1/g' estaciones.csv

sed -i -r 's/, //g' estaciones.csv

sed -i -r 's/0E/0,E/' estaciones.csv

sed -i -r 's/[A-Za-z],\.//g' estaciones.csv

sed -i -r 's/ ,[A-Za-z]//g' estaciones.csv

sed -i -r 's/([A-Za-z]),([A-Za-z])/\1 \2/g' estaciones.csv

sed -i -r 's/,,/,/g' estaciones.csv

sed -i -r 's/([A-Za-z])\./\1/g' estaciones.csv

sed -i '3d' estaciones.csv

sed -i 1i"id_estacion,nombre,latitud,longitud" estaciones.csv

awk -F, '{
        if (NR>1 && $3 !="" && $4 != "") count++
} END{print "estaciones diferentes:",count}' estaciones.csv
