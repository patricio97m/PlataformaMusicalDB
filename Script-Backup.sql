/*
	DESAFIO ENTREGABLE DE CLASE 21
	TABLAS INCLUIDAS EN EL BACKUP:
	-artista_banda
	-canciones
	-discos_eps
	-podcast
	-presentadores
	-usuario
Se conservaron solamente las tablas más importantes de la base de datos*/

-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: streaming_music_database
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `artista_banda`
--

LOCK TABLES `artista_banda` WRITE;
/*!40000 ALTER TABLE `artista_banda` DISABLE KEYS */;
INSERT INTO `artista_banda` VALUES (1,'Michael Jackson','Pop','1972'),(2,'The Beatles','Rock','1960'),(3,'Iron Maiden','Heavy Metal','1975'),(4,'Kiss','Hard Rock','1973'),(5,'Aerosmith','Hard Rock','1970'),(6,'Depeche Mode','Industrial','1980'),(7,'INXS','Pop Rock','1977'),(8,'Motley Crue','Hard Rock','1981'),(9,'Billy Idol','Hard Rock','1981'),(10,'Queen','Rock','1970'),(11,'Guns n\' Roses','Hard Rock','1985'),(12,'Soda Stereo ','Rock','1982'),(13,'Divididos','Rock','1988'),(14,'The Ramones','Punk Rock','1974'),(15,'Misfits','Punk Rock','1977');
/*!40000 ALTER TABLE `artista_banda` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ins_artista_banda_log` AFTER INSERT ON `artista_banda` FOR EACH ROW BEGIN 
insert into artista_banda_log
(fecha, usuario_id, id_banda, new_dato, tipo_operacion)
values
(now(), session_user(), NEW.idArtista_Banda,
CONCAT (NEW.Nombre, ", " , NEW.Genero, ", " , NEW.AñoDeCreacion) ,
'Insercion');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `upd_artista_banda_log` AFTER UPDATE ON `artista_banda` FOR EACH ROW BEGIN 
insert into artista_banda_log
(fecha, usuario_id, id_banda, old_dato, new_dato, tipo_operacion)
values
(now(), session_user(), new.idArtista_Banda, 
CONCAT (OLD.Nombre, ", " , OLD.Genero, ", " , OLD.AñoDeCreacion),
CONCAT (NEW.Nombre, ", " , NEW.Genero, ", " , NEW.AñoDeCreacion),
'Actualizacion');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `del_artista_banda_log` BEFORE DELETE ON `artista_banda` FOR EACH ROW BEGIN 
insert into artista_banda_log
(fecha, usuario_id, id_banda, old_dato, tipo_operacion)
values
(now(), session_user(), OLD.idArtista_Banda,
CONCAT (OLD.Nombre, ", " , OLD.Genero, ", " , OLD.AñoDeCreacion) ,
'Eliminacion');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `canciones`
--

LOCK TABLES `canciones` WRITE;
/*!40000 ALTER TABLE `canciones` DISABLE KEYS */;
INSERT INTO `canciones` VALUES (1,'Bad','00:04:08',1,1),(2,'The Way You Make Me Feel','00:04:59',2,1),(3,'Speed Demon','00:04:02',3,1),(4,'Liberian Girl','00:04:01',4,1),(5,'Just Good Friends','00:03:53',5,1),(6,'Another Part of Me','00:04:07',6,1),(7,'Man in the Mirror','00:03:54',7,1),(8,'I Just Cant Stop Loving You','00:02:03',8,1),(9,'Dirty Diana','00:03:17',9,1),(10,'Smooth Criminal','00:04:27',10,1),(11,'Leave Me Alone','00:05:07',11,1),(12,'Jam','00:05:38',1,2),(13,'Black or White','00:04:14',8,2),(14,'Wrathchild','00:02:55',2,4),(15,'Killers','00:05:01',7,4),(16,'Another one Bites the Dust','00:03:34',3,8),(17,'Save Me','00:03:49',10,8),(18,'Nada Personal','00:04:52',1,10),(19,'Danza Rota','00:03:31',4,10),(20,'Ecos','00:04:57',10,10),(21,'Cancion Animal','00:04:07',3,12),(22,'De Musica Ligera','00:03:32',6,12),(23,'Hombre al Agua','00:05:55',7,12),(24,'Helena','00:03:19',17,15),(25,'Aces High','00:04:31',1,3),(26,'Walk This Way','00:03:40',4,5),(27,'Last Child','00:03:26',2,6),(28,'Mustapha','00:03:01',1,7),(29,'Disco Eterno','00:05:46',2,9),(30,'Signos','00:05:43',8,11),(31,'Poison heart','00:04:03',3,13),(32,'I wanna be Sedated','00:02:29',7,14);
/*!40000 ALTER TABLE `canciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `discos_eps`
--

LOCK TABLES `discos_eps` WRITE;
/*!40000 ALTER TABLE `discos_eps` DISABLE KEYS */;
INSERT INTO `discos_eps` VALUES (1,'Bad','Pop',1987,1),(2,'Dangerous','Pop',1991,1),(3,'Powerslave','Heavy Metal',1984,3),(4,'Killers','Heavy Metal',1981,3),(5,'Toys in the Attic','Hard Rock',1975,5),(6,'Rocks','Hard Rock',1985,5),(7,'Jazz','Rock',1978,10),(8,'The Game','Rock',1980,10),(9,'Sueño Stereo','Rock',1995,12),(10,'Nada Personal','Rock',1985,12),(11,'Signos','Rock',1986,12),(12,'Cancion Animal','Rock',1990,12),(13,'Mondo Bizarro','Punk Rock',1992,14),(14,'Road to Ruin','Punk Rock',1978,14),(15,'Famous Monsters','Punk Rock',1999,15);
/*!40000 ALTER TABLE `discos_eps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `podcasts`
--

LOCK TABLES `podcasts` WRITE;
/*!40000 ALTER TABLE `podcasts` DISABLE KEYS */;
INSERT INTO `podcasts` VALUES (1,'Historia en Podcast','Podcast dedicado a la historia','05:16:01',1),(2,'Teoría musical sin límites','Aprendé musica con este podcast!','10:10:05',2),(3,'Historias innesesarias','Historias y sucesos curiosos','20:25:08',3),(4,'Filosofía y psicología','Relatos breves de psicología','04:12:45',4),(5,'Mitología','Mitos antiguos para la época moderna','02:04:03',5),(6,'Historias de canciones','Un repaso por las historias de distintas canciones','15:45:59',6),(7,'Teorías de conspiración','Eventos controverciales de la actualidad','03:45:45',7),(8,'PixelReviews','Encontrá las mejores reseñas de los videojuegos','24:23:33',8),(9,'Relatos futbolísticos','Las mejores experiencias en el fútbol','10:23:45',9),(10,'Lo esencial','Datos que tienes que saber antes de morir','12:32:12',10),(11,'Vive en verde','Tips y consejos para cuidar el medio ambiente','02:12:55',11),(12,'Nutrición perfecta','Aquí encontrarás las mejores recomendaciones acerca de la nutrición','21:32:44',12),(13,'ASMR para dormir','Sonidos tranquilizantes para dormir','10:10:21',13),(14,'Preguntas y respuestas','Podcast dedicado a la libertad de expresión','04:04:04',14),(15,'Conexión con el alma','Libera tu ser con este podcast','07:21:45',15);
/*!40000 ALTER TABLE `podcasts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `presentadores`
--

LOCK TABLES `presentadores` WRITE;
/*!40000 ALTER TABLE `presentadores` DISABLE KEYS */;
INSERT INTO `presentadores` VALUES (1,'Julio Osorio'),(2,'Jose Miguel Gonzales'),(3,'Jose Carlos Guillen'),(4,'Balbina Cubero'),(5,'Joaquina Torregrosa'),(6,'Mauro Lago'),(7,'Angel Gascon'),(8,'Nayra Olmos'),(9,'Marisol Martinez'),(10,'Luis Alfonso Anton'),(11,'Noelia Roig'),(12,'Jose Andres Lorente'),(13,'Jose Andres Puertas'),(14,'Maria Trinidad Ribas'),(15,'Lídia Naranjo');
/*!40000 ALTER TABLE `presentadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Jose'),(2,'James '),(3,'Juan Ignacio'),(4,'Maria'),(5,'Leonardo '),(6,'Lionel'),(7,'Patricio'),(8,'Lionel'),(9,'Juana'),(10,'Belen'),(11,'Nahuel'),(12,'Jason'),(13,'Robert'),(14,'Bruce'),(15,'Kevin');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'streaming_music_database'
--

--
-- Dumping routines for database 'streaming_music_database'
--
/*!50003 DROP FUNCTION IF EXISTS `artista_hace_rock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `artista_hace_rock`(id int) RETURNS varchar(2) CHARSET utf8mb3
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_dias_faltantes_concierto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_dias_faltantes_concierto`(id int) RETURNS int
    DETERMINISTIC
begin
	declare dias int;
	set dias = (select timestampdiff(DAY, CURDATE(), Fecha)  from `streaming_music_database`.`conciertos` where `idConciertos` = id);
    return dias;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_duracion_disco` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_duracion_disco`(num int) RETURNS time
    DETERMINISTIC
begin
	declare duracion_disco time;
	set duracion_disco = (select sum(Duracion)  from `streaming_music_database`.`canciones_discos` where `id` = num);
    return duracion_disco;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_genero_artista` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_genero_artista`(id int) RETURNS varchar(30) CHARSET utf8mb3
    DETERMINISTIC
begin
	declare Genero_banda varchar (30);
	set Genero_banda = (select Genero from `streaming_music_database`.`artista_banda` where `idArtista_Banda` = id);
    return Genero_banda;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_productos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_productos`(IN prod varchar(24))
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `eliminar_conciertos_pasados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_conciertos_pasados`()
BEGIN
	DECLARE cant_conciertos INT;
    DECLARE conciertos_eliminados VARCHAR (50);
    SET cant_conciertos = (select count(*) from conciertos WHERE (SELECT timestampdiff(DAY, CURDATE(), Fecha) < 0));
    SET conciertos_eliminados = concat ('Se eliminaron ', cant_conciertos, ' conciertos');
	DELETE FROM conciertos WHERE (SELECT timestampdiff(DAY, CURDATE(), Fecha)) < 0 ;
    SELECT conciertos_eliminados;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-06 21:40:53
