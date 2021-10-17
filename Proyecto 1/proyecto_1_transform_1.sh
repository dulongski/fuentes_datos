#!/bin/bash

file="$1"

sed -e 's/\s//g' $file |
sed -r 's/<gas_pricetype="regular">([0-9]+\.?[0-9]*)<\/gas_price>/regular \1/' |
sed -r 's/<gas_pricetype="premium">([0-9]+\.?[0-9]*)<\/gas_price>/premium \1/' |
sed -r 's/<gas_pricetype="diesel">([0-9]+\.?[0-9]*)<\/gas_price>/diesel \1/' |
sed -r 's/<placeplace_id="([0-9]+)">/estacion_servicio \1/' |
awk '{RS="</place>"
    match($0,/estacion_servicio ([0-9]+)/,id)
    if (match($0, /regular ([0-9]+\.?[0-9]*)/, regular)) print "id", id[1], "regular", regular[1];
    if (match($0, /premium ([0-9]+\.?[0-9]*)/, premium)) print "id", id[1], "premium", premium[1];
    if (match($0, /diesel ([0-9]+\.?[0-9]*)/, diesel)) print "id", id[1], "diesel", diesel[1]}' |

awk '{
	match($0,/id ([0-9]+)/,id)
	if (match($0, /regular ([0-9]+\.?[0-9]*)/, precio)) preg[id[1]] = precio[1];
	if (match($0, /premium ([0-9]+\.?[0-9]*)/, precio)) pprem[id[1]] = precio[1];
	if (match($0, /diesel ([0-9]+\.?[0-9]*)/, precio)) pdies[id[1]] = precio[1];
	ids[id[1]] = id[1]
	} END{
       for (element in ids) print element, ",", preg[element], ",", pprem[element], ",", pdies[element]
	}' |
sed 's/ //g' > precios.csv

echo "gasolineras que sirven gasolina regular:" $(grep -c regular $file)
echo "gasolineras que sirven gasolina diesel:" $(grep -c diesel $file)
echo "gasolineras que sirven gasolina premium:" $(grep -c premium $file)
echo "gasolineras diferentes:" $(wc -l precios.csv)
echo "observaciones de precios:" $(wc -l precios.csv)

sed -i 1i"estacion_servicio,regular,premium,diesel" precios.csv
