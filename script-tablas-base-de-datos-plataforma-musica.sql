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
-- Table `Base-de-datos-plataforma-streaming`.`Locacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Locacion` (
  `idLocacion` INT NOT NULL AUTO_INCREMENT,
  `Lugar` VARCHAR(100) NOT NULL,
  `Capacidad` INT NOT NULL,
  `Sectores` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idLocacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Tickets` (
  `idTickets` INT NOT NULL AUTO_INCREMENT,
  `Precio` INT NOT NULL,
  `Sector` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTickets`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Conciertos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Conciertos` (
  `idConciertos` INT NOT NULL AUTO_INCREMENT,
  `nombreConcierto` VARCHAR(45) NOT NULL,
  `Fecha` VARCHAR(10) NOT NULL,
  `idArtista/Banda` INT NOT NULL,
  `idLocacion` INT NOT NULL,
  `idTickets` INT NOT NULL,
  PRIMARY KEY (`idConciertos`),
  UNIQUE INDEX `idConciertos_UNIQUE` (`idConciertos` ASC) VISIBLE,
  INDEX `Artista_idx` (`idArtista/Banda` ASC) VISIBLE,
  INDEX `lugar_concierto_idx` (`idLocacion` ASC) VISIBLE,
  INDEX `tickets_conciertos_idx` (`idTickets` ASC) VISIBLE,
  CONSTRAINT `Artista`
    FOREIGN KEY (`idArtista/Banda`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Artista/Banda` (`idArtista/Banda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `lugar_concierto`
    FOREIGN KEY (`idLocacion`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Locacion` (`idLocacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tickets_conciertos`
    FOREIGN KEY (`idTickets`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Tickets` (`idTickets`)
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


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Merchandising`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Merchandising` (
  `idMerchandising` INT NOT NULL AUTO_INCREMENT,
  `Producto` VARCHAR(45) NOT NULL,
  `Precio` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(200) NOT NULL,
  `idArtista/Banda` INT NOT NULL,
  PRIMARY KEY (`idMerchandising`),
  UNIQUE INDEX `idMerchandising_UNIQUE` (`idMerchandising` ASC) VISIBLE,
  INDEX `producto_artista_idx` (`idArtista/Banda` ASC) VISIBLE,
  CONSTRAINT `producto_artista`
    FOREIGN KEY (`idArtista/Banda`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Artista/Banda` (`idArtista/Banda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Videoclips`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Videoclips` (
  `idVideoclip` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Duracion` VARCHAR(5) NOT NULL,
  `idArtista/Banda` INT NOT NULL,
  `idCanciones` INT NOT NULL,
  PRIMARY KEY (`idVideoclip`),
  INDEX `artista_videoclip_idx` (`idArtista/Banda` ASC) VISIBLE,
  INDEX `cancion_videoclip_idx` (`idCanciones` ASC) VISIBLE,
  CONSTRAINT `artista_videoclip`
    FOREIGN KEY (`idArtista/Banda`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Artista/Banda` (`idArtista/Banda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cancion_videoclip`
    FOREIGN KEY (`idCanciones`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Canciones` (`idCanciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Presentadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Presentadores` (
  `idPresentador` INT NOT NULL AUTO_INCREMENT,
  `Nombres` VARCHAR(100) NULL,
  PRIMARY KEY (`idPresentador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Podcasts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Podcasts` (
  `idPodcast` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Descripcion` VARCHAR(200) NOT NULL,
  `Duracion` VARCHAR(5) NOT NULL,
  `idPresentador` INT NOT NULL,
  PRIMARY KEY (`idPodcast`),
  INDEX `nombre_presentador_idx` (`idPresentador` ASC) VISIBLE,
  CONSTRAINT `nombre_presentador`
    FOREIGN KEY (`idPresentador`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Presentadores` (`idPresentador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Base-de-datos-plataforma-streaming`.`Letras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Base-de-datos-plataforma-streaming`.`Letras` (
  `idLetra` INT NOT NULL AUTO_INCREMENT,
  `Letra` VARCHAR(500) NOT NULL,
  `idCanciones` INT NOT NULL,
  PRIMARY KEY (`idLetra`),
  INDEX `letra_cancion_idx` (`idCanciones` ASC) VISIBLE,
  CONSTRAINT `letra_cancion`
    FOREIGN KEY (`idCanciones`)
    REFERENCES `Base-de-datos-plataforma-streaming`.`Canciones` (`idCanciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
