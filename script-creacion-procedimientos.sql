-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema streaming_music_database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema streaming_music_database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `streaming_music_database` DEFAULT CHARACTER SET utf8 ;
USE `streaming_music_database` ;

-- -----------------------------------------------------
-- Table `streaming_music_database`.`artista_banda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`artista_banda` (
  `idArtista_Banda` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Genero` VARCHAR(30) NOT NULL,
  `AñoDeCreacion` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idArtista_Banda`),
  UNIQUE INDEX `idArtista/Banda_UNIQUE` (`idArtista_Banda` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`discos_EPs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`discos_EPs` (
  `idDiscos_EPs` INT NOT NULL AUTO_INCREMENT,
  `nombreDisco` VARCHAR(45) NOT NULL,
  `Genero` VARCHAR(45) NOT NULL,
  `Año` INT NOT NULL,
  `idArtista_Banda` INT NOT NULL,
  PRIMARY KEY (`idDiscos_EPs`),
  UNIQUE INDEX `idDiscos/EPs_UNIQUE` (`idDiscos_EPs` ASC) VISIBLE,
  INDEX `idArtista/Banda_idx` (`idArtista_Banda` ASC) VISIBLE,
  CONSTRAINT `idArtista/Banda`
    FOREIGN KEY (`idArtista_Banda`)
    REFERENCES `streaming_music_database`.`artista_banda` (`idArtista_Banda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Locacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Locacion` (
  `idLocacion` INT NOT NULL AUTO_INCREMENT,
  `Lugar` VARCHAR(100) NOT NULL,
  `Capacidad` INT NOT NULL,
  `Sectores` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idLocacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Tickets` (
  `idTickets` INT NOT NULL AUTO_INCREMENT,
  `Precio` INT NOT NULL,
  `Sector` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTickets`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Conciertos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Conciertos` (
  `idConciertos` INT NOT NULL AUTO_INCREMENT,
  `nombreConcierto` VARCHAR(45) NOT NULL,
  `Fecha` DATE NOT NULL,
  `idArtista_Banda` INT NOT NULL,
  `idLocacion` INT NOT NULL,
  `idTickets` INT NOT NULL,
  PRIMARY KEY (`idConciertos`),
  UNIQUE INDEX `idConciertos_UNIQUE` (`idConciertos` ASC) VISIBLE,
  INDEX `Artista_idx` (`idArtista_Banda` ASC) VISIBLE,
  INDEX `lugar_concierto_idx` (`idLocacion` ASC) VISIBLE,
  INDEX `tickets_conciertos_idx` (`idTickets` ASC) VISIBLE,
  CONSTRAINT `Artista`
    FOREIGN KEY (`idArtista_Banda`)
    REFERENCES `streaming_music_database`.`artista_banda` (`idArtista_Banda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `lugar_concierto`
    FOREIGN KEY (`idLocacion`)
    REFERENCES `streaming_music_database`.`Locacion` (`idLocacion`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `tickets_conciertos`
    FOREIGN KEY (`idTickets`)
    REFERENCES `streaming_music_database`.`Tickets` (`idTickets`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Canciones` (
  `idCanciones` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Duracion` TIME NOT NULL,
  `numCancion` INT NOT NULL,
  `idDiscos_EPs` INT NOT NULL,
  PRIMARY KEY (`idCanciones`),
  UNIQUE INDEX `idCanciones_UNIQUE` (`idCanciones` ASC) VISIBLE,
  INDEX `idDiscos/EPs_idx` (`idDiscos_EPs` ASC) VISIBLE,
  CONSTRAINT `idDiscos_EPs`
    FOREIGN KEY (`idDiscos_EPs`)
    REFERENCES `streaming_music_database`.`discos_EPs` (`idDiscos_EPs`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Playlists` (
  `idPlaylists` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `idCanciones` INT NOT NULL,
  `idUsuario` INT NULL,
  `idArtista_Banda` INT NULL,
  PRIMARY KEY (`idPlaylists`),
  UNIQUE INDEX `idPlaylists_UNIQUE` (`idPlaylists` ASC) VISIBLE,
  INDEX `idCanciones_idx` (`idCanciones` ASC) VISIBLE,
  INDEX `IdUsuario_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `Artistas_idx` (`idArtista_Banda` ASC) VISIBLE,
  CONSTRAINT `idCanciones`
    FOREIGN KEY (`idCanciones`)
    REFERENCES `streaming_music_database`.`Canciones` (`idCanciones`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `IdUsuario`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `streaming_music_database`.`Usuario` (`idUsuario`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Artistas`
    FOREIGN KEY (`idArtista_Banda`)
    REFERENCES `streaming_music_database`.`artista_banda` (`idArtista_Banda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Merchandising`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Merchandising` (
  `idMerchandising` INT NOT NULL AUTO_INCREMENT,
  `Producto` VARCHAR(45) NOT NULL,
  `Precio` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(200) NOT NULL,
  `idArtista_Banda` INT NOT NULL,
  PRIMARY KEY (`idMerchandising`),
  UNIQUE INDEX `idMerchandising_UNIQUE` (`idMerchandising` ASC) VISIBLE,
  INDEX `producto_artista_idx` (`idArtista_Banda` ASC) VISIBLE,
  CONSTRAINT `producto_artista`
    FOREIGN KEY (`idArtista_Banda`)
    REFERENCES `streaming_music_database`.`artista_banda` (`idArtista_Banda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Videoclips`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Videoclips` (
  `idVideoclip` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Duracion` TIME NOT NULL,
  `idArtista_Banda` INT NOT NULL,
  `idCanciones` INT NOT NULL,
  PRIMARY KEY (`idVideoclip`),
  INDEX `artista_videoclip_idx` (`idArtista_Banda` ASC) VISIBLE,
  INDEX `cancion_videoclip_idx` (`idCanciones` ASC) VISIBLE,
  CONSTRAINT `artista_videoclip`
    FOREIGN KEY (`idArtista_Banda`)
    REFERENCES `streaming_music_database`.`artista_banda` (`idArtista_Banda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `cancion_videoclip`
    FOREIGN KEY (`idCanciones`)
    REFERENCES `streaming_music_database`.`Canciones` (`idCanciones`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Presentadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Presentadores` (
  `idPresentador` INT NOT NULL AUTO_INCREMENT,
  `Nombres` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idPresentador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Podcasts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Podcasts` (
  `idPodcast` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(200) NOT NULL,
  `Duracion` TIME NOT NULL,
  `idPresentador` INT NOT NULL,
  PRIMARY KEY (`idPodcast`),
  INDEX `nombre_presentador_idx` (`idPresentador` ASC) VISIBLE,
  CONSTRAINT `nombre_presentador`
    FOREIGN KEY (`idPresentador`)
    REFERENCES `streaming_music_database`.`Presentadores` (`idPresentador`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `streaming_music_database`.`Letras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `streaming_music_database`.`Letras` (
  `idLetra` INT NOT NULL AUTO_INCREMENT,
  `Letra` VARCHAR(500) NOT NULL,
  `idCanciones` INT NOT NULL,
  PRIMARY KEY (`idLetra`),
  INDEX `letra_cancion_idx` (`idCanciones` ASC) VISIBLE,
  CONSTRAINT `letra_cancion`
    FOREIGN KEY (`idCanciones`)
    REFERENCES `streaming_music_database`.`Canciones` (`idCanciones`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Insercion de datos a las tablas
-- -----------------------------------------------------

INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (1,'Michael Jackson','Pop','1972');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (2,'The Beatles','Rock','1960');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (3,'Iron Maiden','Heavy Metal','1975');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (4,'Kiss','Hard Rock','1973');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (5,'Aerosmith','Hard Rock','1970');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (6,'Depeche Mode','Industrial','1980');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (7,'INXS','Pop Rock','1977');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (8,'Motley Crue','Hard Rock','1981');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (9,'Billy Idol','Hard Rock','1981');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (10,'Queen','Rock','1970');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (11,'Guns n\' Roses','Hard Rock','1985');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (12,'Soda Stereo ','Rock','1982');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (13,'Divididos','Rock','1988');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (14,'The Ramones','Punk Rock','1974');
INSERT INTO `artista_banda` (`idArtista_Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (15,'Misfits','Punk Rock','1977');


INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (1,'Bad','Pop',1987,1);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (2,'Dangerous','Pop',1991,1);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (3,'Powerslave','Heavy Metal',1984,3);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (4,'Killers','Heavy Metal',1981,3);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (5,'Toys in the Attic','Hard Rock',1975,5);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (6,'Rocks','Hard Rock',1985,5);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (7,'Jazz','Rock',1978,10);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (8,'The Game','Rock',1980,10);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (9,'Sueño Stereo','Rock',1995,12);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (10,'Nada Personal','Rock',1985,12);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (11,'Signos','Rock',1986,12);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (12,'Cancion Animal','Rock',1990,12);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (13,'Mondo Bizarro','Punk Rock',1992,14);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (14,'Road to Ruin','Punk Rock',1978,14);
INSERT INTO `discos_eps` (`IdDiscos_Eps`,`nombreDisco`,`Genero`,`Año`,`idArtista_Banda`) VALUES (15,'Famous Monsters','Punk Rock',1999,15);

INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (1,'Bad','00:04:08',1,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (2,'The Way You Make Me Feel','00:04:59',2,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (3,'Speed Demon','00:04:02',3,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (4,'Liberian Girl','00:04:01',4,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (5,'Just Good Friends','00:03:53',5,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (6,'Another Part of Me','00:04:07',6,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (7,'Man in the Mirror','00:03:54',7,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (8,'I Just Cant Stop Loving You','00:02:03',8,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (9,'Dirty Diana','00:03:17',9,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (10,'Smooth Criminal','00:04:27',10,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (11,'Leave Me Alone','00:05:07',11,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (12,'Jam','00:05:38',1,2);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (13,'Black or White','00:04:14',8,2);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (14,'Wrathchild','00:02:55',2,4);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (15,'Killers','00:05:01',7,4);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (16,'Another one Bites the Dust','00:03:34',3,8);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (17,'Save Me','00:03:49',10,8);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (18,'Nada Personal','00:04:52',1,10);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (19,'Danza Rota','00:03:31',4,10);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (20,'Ecos','00:04:57',10,10);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (21,'Cancion Animal','00:04:07',3,12);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (22,'De Musica Ligera','00:03:32',6,12);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (23,'Hombre al Agua','00:05:55',7,12);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (24,'Helena','00:03:19',17,15);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (25,'Aces High','00:04:31',1,3);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (26,'Walk This Way','00:03:40',4,5);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (27,'Last Child','00:03:26',2,6);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (28,'Mustapha','00:03:01',1,7);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (29,'Disco Eterno','00:05:46',2,9);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (30,'Signos','00:05:43',8,11);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (31,'Poison heart','00:04:03',3,13);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`IdDiscos_Eps`) VALUES (32,'I wanna be Sedated','00:02:29',7,14);

INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (1,'Jose');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (2,'James ');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (3,'Juan Ignacio');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (4,'Maria');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (5,'Leonardo ');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (6,'Lionel');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (7,'Patricio');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (8,'Lionel');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (9,'Juana');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (10,'Belen');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (11,'Nahuel');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (12,'Jason');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (13,'Robert');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (14,'Bruce');
INSERT INTO `usuario` (`idUsuario`,`Nombre`) VALUES (15,'Kevin');

INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (1,'The best of Michael jackson',1,NULL,1);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (2,'My Playlist 3',5,3,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (3,'Rock nacional',13,5,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (4,'Heavy Metal ',6,5,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (5,'Playlist privada 8',3,5,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (6,'Best of the best',7,NULL,10);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (7,'Early Years',7,NULL,10);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (8,'Queen essentials',7,NULL,10);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (9,'mi musica',11,7,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (10,'Mejores Canciones',15,8,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (11,'Rock & mas',4,5,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (12,'Misfits essentials',15,NULL,15);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (13,'Musica de Argentina',12,10,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (14,'Pop',4,11,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista_Banda`) VALUES (15,'Mejores Canciones de Soda Stereo',14,NULL,12);

INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (1,'Movistar Arena, AR',15000,'platea_campo');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (2,'Estadio Mâs Monumental, AR',72064,'platea_campo_campovip');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (3,'Luna Park, AR',11290,'platea_campo');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (4,'Estadio Centenario, UY',60235,'platea_campo_campovip');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (5,'Estadio Maracaná, BR',78838,'platea_campo');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (6,'Estadio Azteca, MX',87000,'platea_campo_campovip');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (7,'Wacken,GE',50000,'campo');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (8,'Parc des Princes, FR',75000,'platea_campo_campovip');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (9,'Allegiant Stadium, USA',65000,'platea_campo');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (10,'Ford Field, USA',65000,'platea_campo');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (11,'Commonwealth Stadium, CA',58000,'platea_campo_campovip');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (12,'Estadio José Amalfirani, AR',49747,'platea_campo');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (13,'Teatro Vorterix, AR',12000,'campo');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (14,'Teatro Gran Rex, AR',15000,'campo');
INSERT INTO locacion (`idLocacion`,`Lugar`,`Capacidad`,`Sectores`) VALUES (15,'Estadio Nacional, CH',60000,'platea_campo_campovip');

INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (1,5000,'campo_vip');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (2,100,'campo');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (3,500,'platea');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (4,1500,'platea');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (5,10000,'campo');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (6,100,'campo');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (7,50,'campo');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (8,70,'platea');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (9,80,'platea');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (10,2000,'campo_vip');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (11,3000,'campo_vip');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (12,4500,'campo_vip');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (13,900,'campo');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (14,520,'campo');
INSERT INTO tickets (`idTickets`,`Precio`,`Sector`) VALUES (15,600,'platea');

INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (1,'Wacken Open Air','2023-07-03',3,7,2);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (2,'Iron Maiden en Argentina','2023-02-03',3,2,5);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (3,'Rock in Rio','2023-03-15',3,5,3);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (4,'Hell & Heaven','2022-12-12',4,6,6);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (5,'Rock in Rio','2023-03-15',4,5,14);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (6,'Aerosmith in Las Vegas','2022-11-19',5,9,9);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (7,'Hell & Heaven','2022-12-12',5,6,13);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (8,'Guns n\\\' Roses en Argentina','2022-09-30',11,2,10);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (9,'Guns n\\\' Roses en Uruguay','2022-10-02',11,4,12);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (10,'Rock in Rio','2023-03-15',11,5,11);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (11,'Guns n\\\' Roses in France','2023-03-25',11,8,1);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (12,'Motley Crue Word Tour','2023-05-05',8,9,8);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (13,'Motley Crue Word Tour','2023-05-10',8,10,7);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (14,'Motley Crue Word Tour','2023-05-15',8,11,15);
INSERT INTO conciertos (`idConciertos`,`nombreConcierto`,`Fecha`,`idArtista_Banda`,`idLocacion`,`idTickets`) VALUES (15,'Divididos en Luna Park','2023-06-06',13,3,4);

INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (1,'Your Butt Is Mine',1);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (2,'Hey, pretty baby with the high heels on',2);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (3,'I\'m headed for the border',3);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (4,'Liberian girl',4);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (5,'I watched you on the floor',5);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (6,'We\'re takin\' over',6);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (7,'I\'m gonna make a change',7);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (8,'You\'ll never make me stay',8);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (9,'As he came into the window was a sound of a crescend',9);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (10,'I don\'t care what you talkin\' bout, baby',10);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (11,'Have you seen my Childhood?',11);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (12,'I took my baby on a Saturday ban',12);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (13,'I was born into a scene of angriness and greed',13);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (14,'You walk through the subway',14);
INSERT INTO letras (`idLetra`,`Letra`,`idCanciones`) VALUES (15,'Steve walks warily down the street',15);

INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (1,'Thriller One Step Vinyl Record','150','The Best-Selling Album of All Time Celebrates Its 40th Anniversary: Michael Jackson\'s Thriller Receives Definitive Treatment on Mobile Fidelity\'s UltraDisc One-Step',1);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (2,'Revolver White Photo T-Shirt','40','This soft white short sleeve t-shirt features a photo of the band and \"Revolver\"\" printed on the front.\"',2);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (3,'Exclusive Revolver Disc Vinyl','35','From “Taxman” to “Tomorrow Never Knows,” The Beatles’ Revolver has been newly mixed by producer Giles Martin and Sam Okell',2);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (4,'T Shirt - Powerslave Mummy','45','Officially LICENSED Band Merchandise T Shirt',3);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (5,'SEVENTH SON OF A SEVENTH SON Vinyl Record','50','Each record is protected within its record sleeve by a white vellum anti-dust sleeve.',3);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (6,'Truck Photo Long T-Shirt','40','Official Aerosmith Merchandise',5);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (7,'ROCKS Vinyl Record','50','Rocks is the fourth studio album by American rock band Aerosmith, released on 3 May 1976.',5);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (8,'GET YOUR WINGS Vinyl Record','50','Each record is protected within its record sleeve by a white vellum anti-dust sleeve.',5);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (9,'T-Shirt - Violator','45','Officially LICENSED Band Merchandise T Shirt',6);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (10,'T-Shirt - People Are People','45','Officially LICENSED Band Merchandise T Shirt',6);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (11,'USA 1988 T-Shirt','45','Officially LICENSED Band Merchandise T Shirt',6);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (12,' Destroyer Platinum Vinyl','300','Destroyer was KISS\'s 4th studio album released in 1976 under Casablanca Records.',4);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (13,'DYNAMO Vinyl Record','45','Each record is protected within its record sleeve by a white vellum anti-dust sleeve.',12);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (14,'SUENO STEREO Vinyl Record','45','Each record is protected within its record sleeve by a white vellum anti-dust sleeve.',12);
INSERT INTO merchandising (`idMerchandising`,`Producto`,`Precio`,`Descripcion`,`idArtista_Banda`) VALUES (15,'Johnny Ramone T-Shirt','50','Johnny Ramone was photographed in his “Chatterbox” tee while in Denmark, in his signature leather jacket, in 1977.',14);

INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (1,'Julio Osorio');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (2,'Jose Miguel Gonzales');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (3,'Jose Carlos Guillen');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (4,'Balbina Cubero');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (5,'Joaquina Torregrosa');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (6,'Mauro Lago');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (7,'Angel Gascon');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (8,'Nayra Olmos');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (9,'Marisol Martinez');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (10,'Luis Alfonso Anton');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (11,'Noelia Roig');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (12,'Jose Andres Lorente');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (13,'Jose Andres Puertas');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (14,'Maria Trinidad Ribas');
INSERT INTO presentadores (`idPresentador`,`Nombres`) VALUES (15,'Lídia Naranjo');

INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (1,'Historia en Podcast','Podcast dedicado a la historia','05:16:01',1);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (2,'Teoría musical sin límites','Aprendé musica con este podcast!','10:10:05',2);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (3,'Historias innesesarias','Historias y sucesos curiosos','20:25:08',3);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (4,'Filosofía y psicología','Relatos breves de psicología','04:12:45',4);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (5,'Mitología','Mitos antiguos para la época moderna','02:04:03',5);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (6,'Historias de canciones','Un repaso por las historias de distintas canciones','15:45:59',6);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (7,'Teorías de conspiración','Eventos controverciales de la actualidad','03:45:45',7);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (8,'PixelReviews','Encontrá las mejores reseñas de los videojuegos','24:23:33',8);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (9,'Relatos futbolísticos','Las mejores experiencias en el fútbol','10:23:45',9);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (10,'Lo esencial','Datos que tienes que saber antes de morir','12:32:12',10);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (11,'Vive en verde','Tips y consejos para cuidar el medio ambiente','02:12:55',11);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (12,'Nutrición perfecta','Aquí encontrarás las mejores recomendaciones acerca de la nutrición','21:32:44',12);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (13,'ASMR para dormir','Sonidos tranquilizantes para dormir','10:10:21',13);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (14,'Preguntas y respuestas','Podcast dedicado a la libertad de expresión','04:04:04',14);
INSERT INTO podcasts (`idPodcast`,`Nombre`,`Descripcion`,`Duracion`,`idPresentador`) VALUES (15,'Conexión con el alma','Libera tu ser con este podcast','07:21:45',15);

INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (1,'Bad (Official Video)','00:18:05',1,1);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (2,'Smooth Criminal (Official Video)','00:09:25',1,10);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (3,'Black Or White (Official Video)','00:06:22',1,13);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (4,'Another One Bites the Dust (Live)','00:03:45',10,16);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (5,'Queen - Save Me (Official Video)','00:04:01',10,17);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (6,'Soda Stereo - Nada Personal','00:06:14',12,18);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (7,'Soda Stereo - Hombre al Agua (Vivo)','00:06:40',12,23);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (8,'De Música Ligera (Official Video)','00:03:40',12,22);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (9,'Iron Maiden - Aces High (Official Video)','00:04:59',3,25);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (10,'Aerosmith - Walk This Way (Live)','00:04:25',5,26);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (11,'Ramones - Poison Heart(Music Video)','00:04:00',14,31);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (12,'Ramones - I Wanna Be Sedated','00:02:31',14,32);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (13,'Misfits - Helena (Official Video)','00:03:24',15,24);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (14,'Leave Me Alone (Official Video)','00:04:38',1,11);
INSERT INTO videoclips (`idVideoclip`,`Nombre`,`Duracion`,`idArtista_Banda`,`idCanciones`) VALUES (15,'Michael Jackson - Man In The Mirror','00:05:03',1,7);

-- -----------------------------------------------------------------------
-- Creacion de vistas
-- -----------------------------------------------------------------------

CREATE VIEW canciones_discos AS
select coalesce(T1.`idDiscos_EPs`, T2.`idDiscos_EPs`) id,
T1.nombreDisco, T2.numCancion, coalesce (T2.Nombre) nombre_cancion, T2.Duracion
from `discos_eps` T1 left join (select * from canciones) T2
on T1.`idDiscos_EPs` = T2.`idDiscos_EPs`
where T2.Nombre IS NOT NULL;

CREATE VIEW playlist_usuarios AS
select coalesce(T1.`idUsuario`, T2.`idUsuario`) id,
coalesce (T1.Nombre) usuario, coalesce (T2.Nombre) nombre_playlist
from `usuario` T1 left join (select * from playlists) T2
on T1.`idUsuario` = T2.`idUsuario`
where T2.Nombre IS NOT NULL;

CREATE VIEW playlists_artistas AS
select coalesce (T1.`idArtista_Banda`, T2.`idArtista_Banda`) id,
coalesce (T1.Nombre) artista, coalesce (T2.Nombre) nombre_playlist
from `artista_banda` T1 left join (select * from playlists) T2
on T1.`idArtista_Banda` = T2.`idArtista_Banda`
where T2.Nombre IS NOT NULL;

CREATE VIEW discos_artistas AS
select coalesce (T1.`idArtista_Banda`, T2.`idArtista_Banda`) id,
coalesce (T1.Nombre) nombre_artista, T2.nombreDisco, T2.`Año`
from `artista_banda` T1 left join (select * from `discos_eps`) T2
on T1.`idArtista_Banda` = T2.`idArtista_Banda`
where T2.nombreDisco IS NOT NULL;

CREATE VIEW conciertos_artistas AS
select coalesce (T1.`idArtista_Banda`, T2.`idArtista_Banda`) id,
T1.nombre, T2.nombreConcierto, T2.Fecha
from `artista_banda` T1 left join (select * from conciertos) T2
on T1.`idArtista_Banda` = T2.`idArtista_Banda`
where T2.nombreConcierto IS NOT NULL;

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

-- -----------------------------------------------------------------------
-- Creacion de procedimientos
-- -----------------------------------------------------------------------

/*Este procedimiento se encarga de eliminar las filas de la tabla 'conciertos' que posean fechas que ya hayan pasado. 
 Se usa la función CURDATE para verificar la fecha actual. Si la funcion timestampdiff (se encarga de calcular la diferencia de dias) 
devuelve un numero negativo, indica que el evento ya paso*/

DELIMITER //
CREATE PROCEDURE `eliminar_conciertos_pasados` ()
BEGIN
	DELETE FROM conciertos WHERE (SELECT timestampdiff(DAY, CURDATE(), Fecha)) < 0 ;
END
//


/*Este procedimiento se encarga de buscar valores en la tabla merchandising. En en primer tramo del proceso se le agrega dos '%' al varchar
para que al buscar, tenga en cuenta todo el campo. Luego se devuelve el nombre del producto, su artista relacionado de la tabla 'artista_banda' y 
se ordena por orden alfabetico la columna Nombre. Si no hay resultados, se ejecuta un if que notifica al usuario. 
  */

DELIMITER //
create procedure buscar_productos (IN prod varchar(24))
begin
    declare nombre_producto varchar(24);
    set nombre_producto = CONCAT ('%', prod, '%');
    select coalesce (T1.idMerchandising) id,
	T1.Producto, coalesce (T2.Nombre) nombre_artista
	from merchandising T1 left join (select * from artista_banda) T2
	on T1.idArtista_Banda = T2.idArtista_Banda
	where T1.Producto like nombre_producto
    order by Producto ASC;
    
    if (select Producto from merchandising where Producto like nombre_producto LIMIT 1) is null then
    select 'No se encontraron resultados';
    end if;
end
//

