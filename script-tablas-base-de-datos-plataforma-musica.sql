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

