-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Metro
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Metro` ;

-- -----------------------------------------------------
-- Schema Metro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Metro` DEFAULT CHARACTER SET utf8 ;
USE `Metro` ;

-- -----------------------------------------------------
-- Table `Metro`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Employees` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Employees` (
  `F.name` VARCHAR(12) NOT NULL,
  `M.name` VARCHAR(12) NOT NULL,
  `L.name` VARCHAR(12) NOT NULL,
  `SSN` VARCHAR(15) NOT NULL,
  `Bdata` DATE NOT NULL,
  `Employeecol` VARCHAR(45) NOT NULL,
  `id` VARCHAR(8) NOT NULL,
  `salary` INT NOT NULL,
  `Gender` ENUM('F', 'M') NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `streat_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`SSN`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Manger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Manger` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Manger` (
  `Manger_ssn` VARCHAR(15) NOT NULL,
  `Mg_start` DATETIME NOT NULL,
  `Mg_end` DATETIME NOT NULL,
  PRIMARY KEY (`Manger_ssn`),
  CONSTRAINT `fk_Manger_Employees`
    FOREIGN KEY (`Manger_ssn`)
    REFERENCES `Metro`.`Employees` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Engineer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Engineer` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Engineer` (
  `type` VARCHAR(15) NOT NULL,
  `Engineer_ssn` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Engineer_ssn`),
  CONSTRAINT `fk_Engineer_Employees1`
    FOREIGN KEY (`Engineer_ssn`)
    REFERENCES `Metro`.`Employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Security`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Security` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Security` (
  `Security_ssn` VARCHAR(15) NOT NULL,
  `rank_Security` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Security_ssn`),
  CONSTRAINT `fk_Security_Employees1`
    FOREIGN KEY (`Security_ssn`)
    REFERENCES `Metro`.`Employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Hunger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Hunger` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Hunger` (
  `H_Name` VARCHAR(30) NOT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`H_Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Stations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Stations` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Stations` (
  `name` VARCHAR(20) NOT NULL,
  `station_id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Line` INT NOT NULL,
  `Manger_ssn` VARCHAR(15) NOT NULL,
  `created_at` DATE NULL DEFAULT CURRENT_TIMESTAMP,
  `started_at` DATE NULL,
  PRIMARY KEY (`name`, `Manger_ssn`),
  INDEX `fk_Stations_Manger1_idx` (`Manger_ssn` ASC),
  CONSTRAINT `fk_Stations_Manger1`
    FOREIGN KEY (`Manger_ssn`)
    REFERENCES `Metro`.`Manger` (`Manger_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Route_station`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Route_station` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Route_station` (
  `code_route` INT NOT NULL,
  `R_number` INT NOT NULL,
  `Route_name` VARCHAR(45) NOT NULL,
  `Stations_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`code_route`),
  INDEX `fk_Route_Stations1_idx` (`Stations_name` ASC),
  CONSTRAINT `fk_Route_Stations1`
    FOREIGN KEY (`Stations_name`)
    REFERENCES `Metro`.`Stations` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Metros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Metros` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Metros` (
  `Code_metro` INT NOT NULL,
  `Metro_face` VARCHAR(45) NOT NULL,
  `Capacity` INT NOT NULL,
  `Hunger_H_Name` VARCHAR(30) NOT NULL,
  `Route_code` INT NOT NULL,
  PRIMARY KEY (`Code_metro`),
  INDEX `fk_Metros_Hunger1_idx` (`Hunger_H_Name` ASC),
  INDEX `fk_Metros_Route1_idx` (`Route_code` ASC),
  CONSTRAINT `fk_Metros_Hunger1`
    FOREIGN KEY (`Hunger_H_Name`)
    REFERENCES `Metro`.`Hunger` (`H_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Metros_Route1`
    FOREIGN KEY (`Route_code`)
    REFERENCES `Metro`.`Route_station` (`code_route`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Driver`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Driver` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Driver` (
  `Driver_ssn` VARCHAR(15) NOT NULL,
  `Number_of_Hours` VARCHAR(3) NOT NULL,
  `Metros_Code_metro` INT NOT NULL,
  PRIMARY KEY (`Driver_ssn`),
  INDEX `fk_Driver_Metros1_idx` (`Metros_Code_metro` ASC),
  CONSTRAINT `fk_Driver_Employees1`
    FOREIGN KEY (`Driver_ssn`)
    REFERENCES `Metro`.`Employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Driver_Metros1`
    FOREIGN KEY (`Metros_Code_metro`)
    REFERENCES `Metro`.`Metros` (`Code_metro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Ticket_officers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Ticket_officers` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Ticket_officers` (
  `TO_SSN` VARCHAR(15) NOT NULL,
  `Ticket_officer_idl` INT NOT NULL,
  PRIMARY KEY (`TO_SSN`),
  UNIQUE INDEX `Ticket_officer_idl_UNIQUE` (`Ticket_officer_idl` ASC),
  CONSTRAINT `fk_Ticket_officers_Employees1`
    FOREIGN KEY (`TO_SSN`)
    REFERENCES `Metro`.`Employees` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Ticket` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Ticket` (
  `Ticket_code` INT NOT NULL,
  `Color` VARCHAR(15) NOT NULL,
  `Price` INT NOT NULL,
  `Station_num` INT NOT NULL,
  `TO_id` VARCHAR(8) NOT NULL,
  `TO_ssn` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Ticket_code`, `TO_ssn`),
  INDEX `fk_Ticket_Ticket_officers1_idx` (`TO_ssn` ASC),
  CONSTRAINT `fk_Ticket_Ticket_officers1`
    FOREIGN KEY (`TO_ssn`)
    REFERENCES `Metro`.`Ticket_officers` (`TO_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Passenger`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Passenger` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Passenger` (
  `Type` VARCHAR(20) NOT NULL,
  `Subscription` VARCHAR(45) NOT NULL,
  `Age` INT NOT NULL,
  `Ticket_code` INT NOT NULL,
  `idMetro` INT NOT NULL,
  INDEX `fk_Passenger_Metros1_idx` (`idMetro` ASC),
  CONSTRAINT `fk_Passenger_Ticket1`
    FOREIGN KEY (`Ticket_code`)
    REFERENCES `Metro`.`Ticket` (`Ticket_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Passenger_Metros1`
    FOREIGN KEY (`idMetro`)
    REFERENCES `Metro`.`Metros` (`Code_metro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`route_lines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`route_lines` ;

CREATE TABLE IF NOT EXISTS `Metro`.`route_lines` (
  `id_route` INT NOT NULL,
  `S_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_route`, `S_name`),
  INDEX `fk_route_lines_Stations1_idx` (`S_name` ASC),
  CONSTRAINT `fk_route_lines_Stations1`
    FOREIGN KEY (`S_name`)
    REFERENCES `Metro`.`Stations` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Metro`.`Dependant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Metro`.`Dependant` ;

CREATE TABLE IF NOT EXISTS `Metro`.`Dependant` (
  `D_SSn` VARCHAR(15) NOT NULL,
  `F.name` VARCHAR(15) NOT NULL,
  `L.name` VARCHAR(15) NOT NULL,
  `Gender` ENUM('F', 'M') NOT NULL,
  `Employees_SSN` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`D_SSn`),
  INDEX `fk_Dependant_Employees1_idx` (`Employees_SSN` ASC),
  CONSTRAINT `fk_Dependant_Employees1`
    FOREIGN KEY (`Employees_SSN`)
    REFERENCES `Metro`.`Employees` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
