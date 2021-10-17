Fuentes de Datos
Sebastian Dulong Salazar
C.U. 188172
# Tarea 2

1. Con `wget` o `curl` baja el archivo de nombres desde 1880 hasta 2014 de censos de Estados Unidos de la siguiente URL: https://www.dropbox.com/s/ezrp0t7uwyg7vgi/NationalNames.zip?dl=0

`cd /mnt/c/Users/ssds6/Documents/fd/`
`wget https://www.dropbox.com/s/ezrp0t7uwyg7vgi/NationalNames.zip?dl=0`


2. Descomprime el archivo con `unzip`

`unzip 'NationalNames.zip?dl=0'`

3. Cambia el nombre del archivo a `census_names.csv`

`mv NationalNames.csv census_names.csv`

Utilizando `sed` y/o `grep` responde las siguientes preguntas:

* Las modificaciones se realizan en el archivo original.

4. Modifica los nombres de las columnas para que estén todas en minúsculas.

`sed -i -E '1s/\(.*\)/\L\1/' census_names.csv`

5. `Anna` o `Ana`

	a. ¿Cuántos registros hay que tenga el nombre `Anna` o `Ana`?

	`grep -Ec ',Ann?a,' census_names.csv` : 447

	b. Modifica los registros que tengan `Anna` o `Ana` por el que aparezca más veces (imputación), es decir, si `Anna` aparece más veces que `Ana` entonces hay que cambiar las `Ana` por `Anna` -> Respeta la mayúscula inicial.

	Compararemos el número de `Anna` vs el de `Ana`:

	`grep -Ec ',Anna,' census_names.csv` : 267
	`grep -Ec ',Ana,' census_names.csv` : 180

	Reemplazaremos los `Ana` por `Anna`:

	`sed -i 's/,Ana,/,Anna,/' census_names.csv`

	c. Verifica que tienes el mismo número de registros para ahora todas las `Anna` o `Ana`

	`grep -Ec ',Anna,' census_names.csv` : 447
	`grep -Ec ',Ana,' census_names.csv` : 0


6. `Emma` o `Ema`

	a. ¿Cuántos registros hay que tenga el nombre `Emma` o `Ema`?

	`grep -Ec ',Emm?a,' census_names.csv` : 364

	b.  Modifica los registros que tengan `Emma` o `Ena` por el que aparezca más veces (imputación), es decir, si `Emma` aparece más veces que `Ema` entonces hay que cambiar las `Ema` por `Emma` -> Respeta la mayúscula inicial.

	Compararemos el número de `Emma` vs el de `Ema`:

	`grep -Ec ',Emma,' census_names.csv` : 246
	`grep -Ec ',Ema,' census_names.csv` : 118

	Reemplazaremos los `Ema` por `Emma`:

	`sed -i 's/,Ema,/,Emma,/' census_names.csv`

	c. Verifica que tienes el mismo número de registros para ahora todas las `Emma` o `Ema`

	`grep -Ec ',Emma,' census_names.csv` : 364
	`grep -Ec ',Ema,' census_names.csv` : 0


7. `Kateleen` o `Katilynn` o `Katelyn` o `Katelynn` o `Katelin` o `Katelynne` o `Katelyne` o `Katelinn` o `Katelyn`

	a. ¿Qué implicación consideras relevante en hacer estos cambios en los nombres? Considera que estamos tratando con datos de un censo.

	Creo que es importante considerar que si realizamos mal la imputación, en el `sed` podemos llevarnos varios nombres entre las patas y arruinar la base de datos.

	También creo que hay que notar que esta imputación puede ser efectiva para análisis, pues juntar a todas las personas con nombre parecido puede ser útil para poner nombres en botellas de Coca-Cola (por ejemplo), pero si estos cambios se realizan en bases de datos históricas sin respaldo podemos perder los datos del nombre "real" de la persona.

	* Si ya haz utilizado Postgres, esta BD tiene una función que permite identificar registros que "suenan" parecido -> https://www.postgresql.org/docs/9.1/fuzzystrmatch.html

	b. ¿Cuántos registros hay que tengan todas las combinaciones de `katelyn`?

	`grep -Ec ',Kat(eleen|ilynn|elyn|elynn|elin|elynne|elyne|elinn),' census_names.csv` : 260

	c. Modifica los registros que tengan el nombre de `katelyn` con todas su variantes por el que aparezca más veces (imputación), es decir, si `Katelyn` aparece más veces que todas las demás combinaciones, modifica todas las combinaciones a la mayor. -> Respeta la mayúscula inicial.

	Compararemos el número de `Kateleen` vs `Katilynn` vs `Katelyn` vs `Katelynn` vs `Katelin` vs `Katelynne` vs `Katelyne` vs `Katelinn` :


	`grep -Ec ',Kateleen,' census_names.csv` : 17
	`grep -Ec ',Katilynn,' census_names.csv` : 26
	`grep -Ec ',Katelyn,' census_names.csv` : 63
	`grep -Ec ',Katelynn,' census_names.csv` : 38
	`grep -Ec ',Katelin,' census_names.csv` : 38
	`grep -Ec ',Katelynne,' census_names.csv` : 31
	`grep -Ec ',Katelyne,' census_names.csv` : 27
	`grep -Ec ',Katelinn,' census_names.csv` : 20

	Reemplazaremos todas las variantes por `Katelyn`:

	`sed -E -i 's/,Kat(eleen|ilynn|elynn|elin|elynne|elyne|elinn),/,Katelyn,/' census_names.csv`


	d. Verifica que tienes el mismo número de registros una vez que hiciste la modificación.

	`grep -Ec ',Kateleen,' census_names.csv` : 0
	`grep -Ec ',Katilynn,' census_names.csv` : 0
	`grep -Ec ',Katelyn,' census_names.csv` : 260
	`grep -Ec ',Katelynn,' census_names.csv` : 0
	`grep -Ec ',Katelin,' census_names.csv` : 0
	`grep -Ec ',Katelynne,' census_names.csv` : 0
	`grep -Ec ',Katelyne,' census_names.csv` : 0
	`grep -Ec ',Katelinn,' census_names.csv` : 0

	`grep -Ec ',Kat(eleen|ilynn|elyn|elynn|elin|elynne|elyne|elinn),' census_names.csv` : 260



8. `Jennie` o `Jenni` o `Jeni` o `Yenni` o `Yeni` o `Yennie`

	a. ¿Cuántos registros hay que tengan todas las combinaciones de `Jennie`?

	`grep -Ec ',[JY]en(nie|ni|i),' census_names.csv` : 383

	b. Modifica los registros que tengan el nombre de `Jennie` con todas su variantes por el que aparezca más veces (imputación), es decir, si `Jeni` aparece más veces que todas las demás combinaciones, modifica todas las combinaciones a la mayor. -> Respeta la mayúscula inicial.

	Compararemos el número de `Jennie` vs `Jenni` vs `Jeni` vs `Yenni` vs `Yeni` vs `Yennie` :

	`grep -Ec ',Jennie,' census_names.csv` : 195
	`grep -Ec ',Jenni,' census_names.csv` : 70
	`grep -Ec ',Jeni,' census_names.csv` : 69
	`grep -Ec ',Yennie,' census_names.csv` : 1
	`grep -Ec ',Yenni,' census_names.csv` : 11
	`grep -Ec ',Yeni,' census_names.csv` : 37

	Reemplazaremos todas las variantes por `Jennie`:

	`sed -E -i 's/,[JY]en(nie|ni|i),/,Jennie,/' census_names.csv`

	c. Verifica que tienes el mismo número de registros una vez que hiciste la modificación.

	`grep -Ec ',Jennie,' census_names.csv` : 383
	`grep -Ec ',Jenni,' census_names.csv` : 0
	`grep -Ec ',Jeni,' census_names.csv` : 0
	`grep -Ec ',Yennie,' census_names.csv` : 0
	`grep -Ec ',Yenni,' census_names.csv` : 0
	`grep -Ec ',Yeni,' census_names.csv` : 0

	`grep -Ec ',[JY]en(nie|ni|i),' census_names.csv` : 383
