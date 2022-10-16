-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Base-de-datos-plataforma-streaming
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Base-de-datos-plataforma-streaming
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Base-de-datos-plataforma-streaming` DEFAULT CHARACTER SET utf8 ;
USE `Base-de-datos-plataforma-streaming` ;

-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Artista/Banda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Artista/Banda` (
  `idArtista/Banda` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Genero` VARCHAR(30) NOT NULL,
  `AñoDeCreacion` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idArtista/Banda`),
  UNIQUE INDEX `idArtista/Banda_UNIQUE` (`idArtista/Banda` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Discos/EPs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Discos/EPs` (
  `idDiscos/EPs` INT NOT NULL AUTO_INCREMENT,
  `nombreDisco` VARCHAR(45) NOT NULL,
  `Genero` VARCHAR(45) NOT NULL,
  `Año` INT NOT NULL,
  `idArtista/Banda` INT NOT NULL,
  PRIMARY KEY (`idDiscos/EPs`),
  UNIQUE INDEX `idDiscos/EPs_UNIQUE` (`idDiscos/EPs` ASC) VISIBLE,
  INDEX `idArtista/Banda_idx` (`idArtista/Banda` ASC) VISIBLE,
  CONSTRAINT `idArtista/Banda`
    FOREIGN KEY (`idArtista/Banda`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Artista/Banda` (`idArtista/Banda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Conciertos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Conciertos` (
  `idConciertos` INT NOT NULL AUTO_INCREMENT,
  `nombreConcierto` VARCHAR(45) NOT NULL,
  `Fecha` VARCHAR(10) NOT NULL,
  `Lugar` VARCHAR(45) NOT NULL,
  `precioEntradas` INT NOT NULL,
  `idArtista/Banda` INT NOT NULL,
  PRIMARY KEY (`idConciertos`),
  UNIQUE INDEX `idConciertos_UNIQUE` (`idConciertos` ASC) VISIBLE,
  INDEX `Artista_idx` (`idArtista/Banda` ASC) VISIBLE,
  CONSTRAINT `Artista`
    FOREIGN KEY (`idArtista/Banda`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Artista/Banda` (`idArtista/Banda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Canciones` (
  `idCanciones` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Duracion` VARCHAR(5) NOT NULL,
  `numCancion` INT NOT NULL,
  `idDiscos/EPs` INT NOT NULL,
  PRIMARY KEY (`idCanciones`),
  UNIQUE INDEX `idCanciones_UNIQUE` (`idCanciones` ASC) VISIBLE,
  INDEX `idDiscos/EPs_idx` (`idDiscos/EPs` ASC) VISIBLE,
  CONSTRAINT `idDiscos/EPs`
    FOREIGN KEY (`idDiscos/EPs`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Discos/EPs` (`idDiscos/EPs`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Playlists` (
  `idPlaylists` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `idCanciones` INT NOT NULL,
  `idUsuario` INT NULL,
  `idArtista/Banda` INT NULL,
  PRIMARY KEY (`idPlaylists`),
  UNIQUE INDEX `idPlaylists_UNIQUE` (`idPlaylists` ASC) VISIBLE,
  INDEX `idCanciones_idx` (`idCanciones` ASC) VISIBLE,
  INDEX `IdUsuario_idx` (`idUsuario` ASC) VISIBLE,
  INDEX `Artistas_idx` (`idArtista/Banda` ASC) VISIBLE,
  CONSTRAINT `idCanciones`
    FOREIGN KEY (`idCanciones`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Canciones` (`idCanciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdUsuario`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Artistas`
    FOREIGN KEY (`idArtista/Banda`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Artista/Banda` (`idArtista/Banda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (1,'Michael Jackson','Pop','1972');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (2,'The Beatles','Rock','1960');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (3,'Iron Maiden','Heavy Metal','1975');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (4,'Kiss','Hard Rock','1973');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (5,'Aerosmith','Hard Rock','1970');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (6,'Depeche Mode','Industrial','1980');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (7,'INXS','Pop Rock','1977');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (8,'Motley Crue','Hard Rock','1981');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (9,'Billy Idol','Hard Rock','1981');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (10,'Queen','Rock','1970');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (11,'Guns n\' Roses','Hard Rock','1985');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (12,'Soda Stereo ','Rock','1982');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (13,'Divididos','Rock','1988');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (14,'The Ramones','Punk Rock','1974');
INSERT INTO `artista/banda` (`idArtista/Banda`,`Nombre`,`Genero`,`AñoDeCreacion`) VALUES (15,'Misfits','Punk Rock','1977');


INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (1,'Bad','Pop',1987,1);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (2,'Dangerous','Pop',1991,1);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (3,'Powerslave','Heavy Metal',1984,3);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (4,'Killers','Heavy Metal',1981,3);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (5,'Toys in the Attic','Hard Rock',1975,5);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (6,'Rocks','Hard Rock',1985,5);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (7,'Jazz','Rock',1978,10);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (8,'The Game','Rock',1980,10);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (9,'Sueño Stereo','Rock',1995,12);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (10,'Nada Personal','Rock',1985,12);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (11,'Signos','Rock',1986,12);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (12,'Cancion Animal','Rock',1990,12);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (13,'Mondo Bizarro','Punk Rock',1992,14);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (14,'Road to Ruin','Punk Rock',1978,14);
INSERT INTO `discos/eps` (`idDiscos/eps`,`nombreDisco`,`Genero`,`Año`,`idArtista/Banda`) VALUES (15,'Famous Monsters','Punk Rock',1999,15);

INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (1,'Bad','04:07',1,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (2,'Speed Demon','04:02',3,1);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (3,'Jam','05:38',1,2);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (4,'Black or White','04:14',8,2);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (5,'Wrathchild','02:55',2,4);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (6,'Killers','05:01',7,4);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (7,'Another one Bites the Dust','03:34',3,8);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (8,'Save Me','03:49',10,8);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (9,'Nada Personal','04:52',1,10);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (10,'Danza Rota','03:31',4,10);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (11,'Ecos','04:57',10,10);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (12,'Cancion Animal','04:07',3,12);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (13,'De Musica Ligera','03:32',6,12);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (14,'Hombre al Agua','05:55',7,12);
INSERT INTO `canciones` (`idCanciones`,`Nombre`,`Duracion`,`numCancion`,`idDiscos/eps`) VALUES (15,'Helena','03:19',17,15);

INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (1,'Wacken Open air','2/7/2023','Munich, Alemania',100,3);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (2,'Iron Maiden en Argentina','2/3/2023','Buenos Aires, Argentina',3000,3);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (3,'Rock in Rio','15/3/2023','Rio de Janeiro, Brasil',500,3);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (4,'Hell & Heaven','12/12/2022','Toluca, Mexico',2000,4);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (5,'Rock in Rio','15/3/2023','Rio de Janeiro, Brasil',500,4);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (6,'Aerosmith in Las Vegas','19/11/2022','Las Vegas, USA',100,5);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (7,'Hell & Heaven','12/12/2022','Toluca, Mexico',2000,5);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (8,'Guns n\' Roses en Argentina','30/9/2022','Buenos Aires, Argentina',3000,11);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (9,'Guns n\' Roses en Uruguay','2/10/2022','Montevideo, Uruguay',200,11);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (10,'Rock in Rio','15/3/2023','Rio de Janeiro, Brasil',500,11);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (11,'Guns n\' Roses in France','25/3/2023','Paris, Francia',100,11);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (12,'Motley Crue Word Tour','5/5/2023','Detroit, USA',90,8);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (13,'Motley Crue Word Tour','10/5/2023','Kansas, USA',90,8);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (14,'Motley Crue Word Tour','25/5/2023','Otawa, Canada',100,8);
INSERT INTO `conciertos` (`idConciertos`,`nombreConcierto`,`Fecha`,`Lugar`,`precioEntradas`,`idArtista/Banda`) VALUES (15,'Divididos en Luna Park','6/6/2023','Buenos Aires, Argentina',600,13);

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

INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (1,'The best of Michael jackson',1,NULL,1);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (2,'My Playlist 3',5,3,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (3,'Rock nacional',13,5,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (4,'Heavy Metal ',6,5,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (5,'Playlist privada 8',3,5,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (6,'Best of the best',7,NULL,10);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (7,'Early Years',7,NULL,10);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (8,'Queen essentials',7,NULL,10);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (9,'mi musica',11,7,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (10,'Mejores Canciones',15,8,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (11,'Rock & mas',4,5,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (12,'Misfits essentials',15,NULL,15);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (13,'Musica de Argentina',12,10,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (14,'Pop',4,11,NULL);
INSERT INTO `playlists` (`idPlaylists`,`Nombre`,`idCanciones`,`idUsuario`,`idArtista/Banda`) VALUES (15,'Mejores Canciones de Soda Stereo',14,NULL,12);

CREATE VIEW canciones_discos AS
select coalesce(T1.`idDiscos/EPs`, T2.`idDiscos/EPs`) id,
T1.nombreDisco, T2.numCancion, coalesce (T2.Nombre) nombre_cancion, T2.Duracion
from `discos/eps` T1 left join (select * from canciones) T2
on T1.`idDiscos/EPs` = T2.`idDiscos/EPs`
where T2.Nombre IS NOT NULL;

CREATE VIEW conciertos_artistas AS
select coalesce (T1.`idArtista/Banda`, T2.`idArtista/Banda`) id,
T1.nombre, T2.nombreConcierto, T2.Fecha, T2.Lugar
from `artista/banda` T1 left join (select * from conciertos) T2
on T1.`idArtista/Banda` = T2.`idArtista/Banda`
where T2.nombreConcierto IS NOT NULL;

CREATE VIEW playlist_usuarios AS
select coalesce(T1.`idUsuario`, T2.`idUsuario`) id,
coalesce (T1.Nombre) usuario, coalesce (T2.Nombre) nombre_playlist
from `usuario` T1 left join (select * from playlists) T2
on T1.`idUsuario` = T2.`idUsuario`
where T2.Nombre IS NOT NULL;

CREATE VIEW playlists_artistas AS
select coalesce (T1.`idArtista/Banda`, T2.`idArtista/Banda`) id,
coalesce (T1.Nombre) artista, coalesce (T2.Nombre) nombre_playlist
from `artista/banda` T1 left join (select * from playlists) T2
on T1.`idArtista/Banda` = T2.`idArtista/Banda`
where T2.Nombre IS NOT NULL;

CREATE VIEW discos_artistas AS
select coalesce (T1.`idArtista/Banda`, T2.`idArtista/Banda`) id,
coalesce (T1.Nombre) nombre_artista, T2.nombreDisco, T2.`Año`
from `artista/banda` T1 left join (select * from `discos/eps`) T2
on T1.`idArtista/Banda` = T2.`idArtista/Banda`
where T2.nombreDisco IS NOT NULL;

