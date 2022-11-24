-- -----------------------------------------------------------------------
-- Creacion de procedimientos
-- -----------------------------------------------------------------------

/*PROCEDIMIENTO `eliminar_conciertos_pasados': Este procedimiento se encarga de eliminar las filas de la tabla 'conciertos' que posean fechas que ya hayan pasado. 
 Se usa la función CURDATE para verificar la fecha actual. Si la funcion timestampdiff (se encarga de calcular la diferencia de dias) 
devuelve un numero negativo, indica que el evento ya paso*/

DELIMITER //
CREATE PROCEDURE `eliminar_conciertos_pasados` ()
BEGIN
	DECLARE cant_conciertos INT;
    DECLARE conciertos_eliminados VARCHAR (50);
    SET cant_conciertos = (select count(*) from conciertos WHERE (SELECT timestampdiff(DAY, CURDATE(), Fecha) < 0));
    SET conciertos_eliminados = concat ('Se eliminaron ', cant_conciertos, ' conciertos');
	DELETE FROM conciertos WHERE (SELECT timestampdiff(DAY, CURDATE(), Fecha)) < 0 ;
    SELECT conciertos_eliminados;
END
//


/*PROCEDIMIENTO `buscar_productos': Este procedimiento se encarga de buscar valores en la tabla merchandising. En en primer tramo del proceso se le agrega dos '%' al varchar
para que al buscar, tenga en cuenta todo el campo. Luego se devuelve el nombre del producto, su artista relacionado de la tabla 'artista_banda' y 
se ordena por orden alfabetico la columna Nombre. Si no hay resultados, se ejecuta un if que notifica al usuario. 
  */

DELIMITER //
create procedure buscar_productos (IN prod varchar(24))
begin
    declare nombre_producto varchar(24);
    declare errorMessage varchar(255);
    set nombre_producto = CONCAT ('%', prod, '%');
    set errorMessage='No se encontraron resultados';
    select coalesce (T1.idMerchandising) id,
	T1.Producto, coalesce (T2.Nombre) nombre_artista
	from merchandising T1 left join (select * from artista_banda) T2
	on T1.idArtista_Banda = T2.idArtista_Banda
	where T1.Producto like nombre_producto
    order by Producto ASC;
    
    if (select Producto from merchandising where Producto like nombre_producto LIMIT 1) is null then
    signal sqlstate '45000'
    set MESSAGE_TEXT=errorMessage;
    end if;
end
//

