-- -----------------------------------------------------
-- Creacion de tablas de registro
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS artista_banda_log (
id_log int not null auto_increment,
fecha datetime not null,
usuario_id varchar(45),
id_banda int,
old_dato varchar(200),
new_dato varchar(200),
tipo_operacion varchar(45),
primary key(id_log));

CREATE TABLE IF NOT EXISTS conciertos_log (
id_log int not null auto_increment,
fecha datetime not null,
usuario_id varchar(45),
id_banda int,
old_dato varchar(200),
new_dato varchar(200),
tipo_operacion varchar(45),
primary key(id_log));


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------------------------
-- Creacion de triggers
-- -----------------------------------------------------------------------

-- --------------------------------
-- Triggers de tabla 'conciertos' -
-- --------------------------------

/*Trigger 'del_conciertos_log': Se encarga de registrar quien realizo la operacion delete en la tabla 'conciertos', mostrando tambien los datos eliminados*/
DELIMITER //
CREATE TRIGGER del_conciertos_log
BEFORE DELETE ON conciertos
FOR EACH ROW
BEGIN 
insert into conciertos_log
(fecha, usuario_id, id_banda, old_dato, tipo_operacion)
values
(now(), session_user(), OLD.idConciertos,
CONCAT (OLD.nombreConcierto, ", " , OLD.Fecha) ,
'Eliminacion');
END 
//

/*Trigger 'upd_conciertos_log': Se encarga de registrar quien realizo la operacion update en la tabla 'conciertos', mostrando tambien que datos fueron acttualizados */
DELIMITER //
CREATE TRIGGER upd_conciertos_log
AFTER UPDATE ON conciertos
FOR EACH ROW
BEGIN 
insert into conciertos_log
(fecha, usuario_id, id_banda, old_dato, new_dato, tipo_operacion)
values
(now(), session_user(), new.idConciertos, 
CONCAT (OLD.nombreConcierto, ", " , OLD.Fecha),
CONCAT (NEW.nombreConcierto, ", " , NEW.Fecha),
'Actualizacion');
END 
//

/*Trigger 'borrar_tickets': Cuando se elimina un campo en la tabla 'conciertos', este trigger se encarga de eliminar todos los tickets relacionados a ese concierto en la tabla 'tickets'*/
DELIMITER //
CREATE TRIGGER borrar_tickets
AFTER DELETE ON conciertos
FOR EACH ROW
BEGIN
DELETE FROM tickets
WHERE idTickets = old.idTickets;
END
// 

-- -----------------------------------
-- Triggers de tabla 'artista_banda' -
-- -----------------------------------

/*Trigger 'del_artista_banda_log': Se encarga de registrar quien realizo la operacion delete en la tabla 'artista_banda', mostrando tambien que datos fueron eliminados*/
DELIMITER //
CREATE TRIGGER del_artista_banda_log
BEFORE DELETE ON artista_banda
FOR EACH ROW
BEGIN 
insert into artista_banda_log
(fecha, usuario_id, id_banda, old_dato, tipo_operacion)
values
(now(), session_user(), OLD.idArtista_Banda,
CONCAT (OLD.Nombre, ", " , OLD.Genero, ", " , OLD.AñoDeCreacion) ,
'Eliminacion');
END 
//

/*Trigger 'ins_artista_banda_log': Se encarga de registrar quien realizo una insercion en la tabla 'artista_banda', mostrando tambien que datos fueron ingresados*/
DELIMITER //
CREATE TRIGGER ins_artista_banda_log
AFTER INSERT ON artista_banda
FOR EACH ROW
BEGIN 
insert into artista_banda_log
(fecha, usuario_id, id_banda, new_dato, tipo_operacion)
values
(now(), session_user(), NEW.idArtista_Banda,
CONCAT (NEW.Nombre, ", " , NEW.Genero, ", " , NEW.AñoDeCreacion) ,
'Insercion');
END 
//
 
/*Trigger 'upd_artista_banda_log': Se encarga de registrar quien realizo un update en la tabla 'artista_banda', mostrando tambien que datos fueron reemplazados 
y los datos nuevos*/ 
DELIMITER //
CREATE TRIGGER upd_artista_banda_log
AFTER UPDATE ON artista_banda
FOR EACH ROW
BEGIN 
insert into artista_banda_log
(fecha, usuario_id, id_banda, old_dato, new_dato, tipo_operacion)
values
(now(), session_user(), new.idArtista_Banda, 
CONCAT (OLD.Nombre, ", " , OLD.Genero, ", " , OLD.AñoDeCreacion),
CONCAT (NEW.Nombre, ", " , NEW.Genero, ", " , NEW.AñoDeCreacion),
'Actualizacion');
END 
//

