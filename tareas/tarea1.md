Fuentes de Datos
Sebastian Dulong Salazar
C.U. 188172
# Tarea 1

1. Bajar con curl o wget el archivo first_5k.csv.zip de la URL: https://www.dropbox.com/s/zlb4zr3xwcwkyn7/first_5k.csv.zip?dl=0

	* `cd /mnt/c/users/ssds6/Documents/fd`

	* `wget https://www.dropbox.com/s/zlb4zr3xwcwkyn7/first_5k.csv.zip?dl=0`

2. Con el comando unzip extrae el contenido del zip y contesta las siguientes preguntas:

	* `sudo apt install unzip`

	* `unzip first_5k.csv.zip?dl=0`

3. ¿Cuántas líneas tiene el archivo?
	* `wc -l first_5k.csv`
	* 5432123

4. ¿Cuántos registros tienen la palabra soriana? (Toma en cuenta que la mayoría de los registros están en mayúsculas, ¡pero no todos!)
	* `grep -ic 'soriana' first_5k.csv`
	* 968297

5. ¿Cuántos registros tienen la palabra tortilla? (Mismas recomendaciones que el punto 4)
	* `grep -ic 'tortilla' first_5k.csv`
	* 69881

6. De los registros que tienen la palabra tortilla, ¿de qué estado de la república es el 13vo último elemento y cuál es el precio? (Regresa solo el 13vo último elemento y verifica el estado y el precio, ponto el palabras)
	* `grep -i 'tortilla' first_5k.csv | tail -n13 | head -1`
	* "TORTILLA DE MAIZ","1 KG. GRANEL","S/M","TORTILLAS Y DERIVADOS DEL MAIZ","BASICOS",12.5,"2011-11-28 00:00:00.000","TORTILLERIAS TRADICIONALES","TORTILLERIA","TORTILLERIA SANTA RITA SUCURSAL SANTA RITA","AV. BENIGNO VALENZUELA S/N, ENTRE RUBEN JARAMILLO Y 10","SINALOA","GUASAVE                                 ",25.555519,-108.454705
	* Sinaloa, 12.5

7. ¿Cuántos registros tienes que sean de la categoría juguetes del estado quintana roo y que sean hot wheels?
	* `grep -i 'juguetes' first_5k.csv | grep -i 'quintana roo'|grep -ic 'hot wheels'`
	* 116

8. ¿Cuántos registros de tiendas de autoservicio tienes tienda de autoservicio?
	* `grep -ic 'tienda de autoservicio' first_5k.csv`
	* 4547966

9. ¿Cuántos registros de papelerías tienes papeleria?
	* `grep -ic 'papeleria' first_5k.csv`
	* 154667

10. ¿Cuántos registros de tortillería tienes tortilleria?
	* `grep -ic 'tortilleria' first_5k.csv`
	* 33038
