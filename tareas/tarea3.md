Fuentes de Datos
Sebastian Dulong Salazar
C.U. 188172
# Tarea 3

~~~
cd /mnt/c/Users/ssds6/Documents/fd/
~~~

1. Baja con `wget` o `curl` los datos de covid nacional en la siguiente URL: https://archivo.datos.cdmx.gob.mx/casos_nacionales_covid-19.csv

Obtuve los datos el 21-09-2021 a las 19:08 hrs. 

~~~
wget https://archivo.datos.cdmx.gob.mx/casos_nacionales_covid-19.csv

mv casos_nacionales_covid-19.csv covid.csv
~~~

Sugiero que primero revises con un `head -20` el contenido del archivo, familiarízate con el contenido de los diferentes campos con los que trabajaremos: fecha de defunción `fecha_def`, fecha de actualización `fecha_actualizacion`, entidad de residencia `entidad_res`, edad `edad`, embarazo `embarazo`, diabetes `diabetes` y sector `sector`.

De la pregunta 2 en adelante ocupa únicamente `awk`.

2. Modifica a que todas las columnas estén en minúsculas ocupando `tolower()`.

~~~
gawk -F, -i inplace '{print tolower($0)}' covid.csv
~~~

3. Modifica los acentos por la misma letra sin acento utilizando `gsub()` de `awk`. [gsub](https://www.gnu.org/software/gawk/manual/html_node/String-Functions.html).

~~~
awk -F, '{gsub(/á/, "a");
          gsub(/é/, "e");
          gsub(/í/, "i");
          gsub(/ó/, "o");
          gsub(/ú/, "u");
          print $0}' covid.csv > temp.csv && mv temp.csv covid.csv
~~~

4. ¿Cuántas personas fallecieron menores de 20 años? [0-19]

~~~
awk -F, '{
	if((NR > 1) && ($14 != "na") && ($17 < 20)) 
	count++} 
END{
	print count}' covid.csv
~~~

497

5. ¿Cuántas personas embarazadas fallecieron entre julio y diciembre del 2020? 

~~~
awk -F, '{
if((NR > 1) && ($14 ~ /2020-(0[7-9]|1[0-2])-[0-3][0-9]/) && ($19 ~ /si/))
count++}
END{
print count}' covid.csv
~~~

9

6. De las personas entre 30 y 50 [30-50] años que fallecieron, ¿cuántas tenían diabetes?

~~~
awk -F, '{
if((NR > 1) && ($14 != "na") && ($17 > 29) && ($17 < 51) && ($22 ~ /si/))
count++}
END{
print count}' covid.csv
~~~

2676

7. De las personas que encontraste en la pregunta 6, ¿cuántas no residen en la "MICHOACÁN"?

Considerando entidad_res como lugar de residencia incluyendo si es "na":

~~~
awk -F, '{
if((NR > 1) && ($14 != "na") && ($17 > 29) && ($17 < 51) && ($22 ~ /si/) && ($9 !~ /michoacan/))
count++}
END{
print count}' covid.csv
~~~

2676


Considerando entidad_res como lugar de residencia si no es "na":

~~~
awk -F, '{
if((NR > 1) && ($14 != "na") && ($17 > 29) && ($17 < 51) && ($22 ~ /si/) && ( $9 != "na") && ($9 !~ /michoacan/))
count++}
END{
print count}' covid.csv
~~~

698

Considerando entidad_nac como lugar de residencia en el caso de que entidad_res sea "na":

~~~
awk -F, '{
if((NR > 1) && ($14 != "na") && ($17 > 29) && ($17 < 51) && ($22 ~ /si/) && (( $9 == "na" && $8 !~ /michoacan/ ) || ($9 != "na" && $9 !~ /michoacan/)))
count++}
END{
print count}' covid.csv
~~~

2666

8. ¿Cuántas personas menores de 19 años [0-18] fallecieron en agosto del 2021?

~~~
awk -F, '{
if((NR > 1) && ($14 ~ /2021-08-[0-3][0-9]/) && ($17 < 19))
count++}
END{
print count}' covid.csv
~~~

33

9. Verifica si la columna de fecha de defunción tiene una longitud de 10 caracteres. En caso de que no sea verifica si tiene números, de no ser así, imprime el siguiente mensaje `El renglón <NR> no tiene asociada una fecha <$fecha_def>`; si contiene números verifica que inicien con `2020` e imprime `El renglón <NR> no tiene el formato adecuado de fecha <$fecha_def>`. 

~~~
awk -F, '{
        if (NR > 1 && length($14) !=  10){
                if($14 ~ /[0-9]/) {
                	if($14 !~ /^2020/) {
                        print "El renglón " NR " no tiene el formato adecuado de fecha " $14;
                	}
                } else {
                        print "El renglón " NR " no tiene asociada una fecha " $14;
                }
        }
}' covid.csv
~~~

10. Cuenta cuántos registros de fallecidos tenemos de cada entidad de residencia.
~~~
entidad de residencia: <entidad_name_1> registros: <xx>
entidad de residencia: <entidad_name_2> registros: <yy>
~~~

~~~
awk -F, '{
if ((NR > 1) && ($14 != "na"))
res[$9]++
}
END{
  for (element in res)
    print "entidad de residencia: ", element, " registros: ", res[element]
}' covid.csv
~~~

~~~
entidad de residencia:  "sonora"  registros:  6
entidad de residencia:  "michoacan de ocampo"  registros:  75
entidad de residencia:  "san luis potosi"  registros:  20
entidad de residencia:  "tabasco"  registros:  4
entidad de residencia:  "hidalgo"  registros:  486
entidad de residencia:  "veracruz de ignacio de la llave"  registros:  106
entidad de residencia:  "zacatecas"  registros:  5
entidad de residencia:  "tlaxcala"  registros:  69
entidad de residencia:  "nuevo leon"  registros:  11
entidad de residencia:  "nayarit"  registros:  2
entidad de residencia:  "jalisco"  registros:  11
entidad de residencia:  "quintana roo"  registros:  12
entidad de residencia:  "queretaro"  registros:  50
entidad de residencia:  "guanajuato"  registros:  58
entidad de residencia:  "sinaloa"  registros:  6
entidad de residencia:  "guerrero"  registros:  171
entidad de residencia:  "yucatan"  registros:  5
entidad de residencia:  "tamaulipas"  registros:  18
entidad de residencia:  "morelos"  registros:  157
entidad de residencia:  "puebla"  registros:  271
entidad de residencia:  "oaxaca"  registros:  79
entidad de residencia:  na  registros:  50551
entidad de residencia:  "mexico"  registros:  15571
~~~

11. Cuenta cuántos registros tenemos de cada sector diferente, imprime:
~~~
sector: <sector_name_1> registros: <xx>
sector: <sector_name_2> registros: <yy>
~~~

Donde `< >` corresponden a valores dinámicos obtenidos de los datos.

~~~
awk -F, '{
if ((NR > 1))
sec[$5]++
}
END{
  for (element in sec)
    print "sector: ", element, " registros: ", sec[element]
}' covid.csv
~~~

~~~
sector:  "municipal"  registros:  1
sector:  "cruz roja"  registros:  643
sector:  "sedena"  registros:  13628
sector:  "imss"  registros:  480338
sector:  "issste"  registros:  40586
sector:  "dif"  registros:  3
sector:  "privada"  registros:  139594
sector:  "semar"  registros:  6244
sector:  "pemex"  registros:  14442
sector:  "universitario"  registros:  23
sector:  "estatal"  registros:  1466
sector:  "imss-bienestar"  registros:  65
sector:  na  registros:  36
sector:  "ssa"  registros:  3317826
~~~
