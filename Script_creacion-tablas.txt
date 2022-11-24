-- Miranda Patricio - Proyecto final de base de datos

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;SET SQL_SAFE_UPDATES = 0;
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

