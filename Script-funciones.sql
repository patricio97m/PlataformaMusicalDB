-- ---------------------------------------------------------------------
-- Creacion de funciones
-- ---------------------------------------------------------------------

/*Esta funcion se encarga de buscar el genero musical de un artista en especifico a traves de su ID*/

DELIMITER //
create function get_genero_artista (id int) returns varchar(30)
DETERMINISTIC
begin
	declare Genero_banda varchar (30);
	set Genero_banda = (select Genero from `streaming_music_database`.`artista_banda` where `idArtista_Banda` = id);
    return Genero_banda;
end
//

/*Esta funcion se encarga de calcular la duracion total de un disco, sumando cada una de sus canciones. Es necesario
ingresar el ID del disco deseado*/

DELIMITER //
create function get_duracion_disco (num int) returns time
DETERMINISTIC
begin
	declare duracion_disco time;
	set duracion_disco = (select sum(Duracion)  from `streaming_music_database`.`canciones_discos` where `id` = num);
    return duracion_disco;
end
//

/*Esta funcion se encarga de calcular los dias restantes para que se produzca un concierto. Se utiliza la funcion timestampdiff que
calcula la diferencia de dias entre la realizacion del evento y el dia actual (CURDATE).*/

DELIMITER //
create function get_dias_faltantes_concierto (id int) returns int
DETERMINISTIC
begin
	declare dias int;
	set dias = (select timestampdiff(DAY, CURDATE(), Fecha)  from `streaming_music_database`.`conciertos` where `idConciertos` = id);
    return dias;
end
//

/* Esta funcion nos indica si el género del artista contiene la palabra 'rock'*/

DELIMITER //
create function artista_hace_rock (id int) returns varchar(2)
DETERMINISTIC
begin
	declare respuesta varchar (2);
    declare genero_banda varchar (30);
    set respuesta = 'NO';
    set genero_banda = (select Genero from `streaming_music_database`.`artista_banda` where `idArtista_Banda` = id);
    if genero_banda like '%Rock%' THEN 
    set respuesta = 'SI';
    end if;
    return respuesta;
end
//
