-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

SET SQL_SAFE_UPDATES = 0;
-- -----------------------------------------------------
-- Schema ATMManagementDB
-- -----------------------------------------------------
DROP DATABASE IF EXISTS atmDb; 
CREATE DATABASE IF NOT EXISTS atmDb; 
USE atmDb;
-- -----------------------------------------------------
-- Table `Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Person` (
  `person_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `age` INT NOT NULL,
  `gender` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`person_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Phone` (
  `phone_id` INT NOT NULL AUTO_INCREMENT,
  `service_provider` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `owner_id` INT NULL,
  PRIMARY KEY (`phone_id`),
  INDEX `PK_FK_owner_person_id_idx` (`owner_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_phone_owner_person_id`
    FOREIGN KEY (`owner_id`)
    REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Card` (
  `card_id` INT NOT NULL AUTO_INCREMENT,
  `card_number` VARCHAR(45) NOT NULL,
  `pin` INT(4) NOT NULL,
  `card_owner_id` INT NOT NULL,
  PRIMARY KEY (`card_id`, `card_owner_id`),
  INDEX `FK_cardOwner_person_id_idx` (`card_owner_id` ASC) VISIBLE,
  UNIQUE INDEX `cardnumber_UNIQUE` (`card_number` ASC) VISIBLE,
  CONSTRAINT `FK_card_owner_person_id`
    FOREIGN KEY (`card_owner_id`)
    REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Account` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `date_joined` DATE NOT NULL,
  `card_id` INT NOT NULL,
  `phone_id` INT NULL,
  PRIMARY KEY (`account_id`, `card_id`),
  INDEX `PK_FK_card_id_idx` (`card_id` ASC) VISIBLE,
  INDEX `FK_phone_id_idx` (`phone_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_card_id`
    FOREIGN KEY (`card_id`)
    REFERENCES `Card` (`card_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_phone_id`
    FOREIGN KEY (`phone_id`)
    REFERENCES `Phone` (`phone_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Bank` (
  `bank_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `date_joined` DATE NOT NULL,
  PRIMARY KEY (`bank_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BankAccount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BankAccount` (
  `bank_account_id` INT NOT NULL AUTO_INCREMENT,
  `routing_number` INT(12) NOT NULL,
  `account_number` INT NOT NULL,
  `bank_id` INT NOT NULL,
  `isChecking` TINYINT NULL DEFAULT 0,
  `isSaving` TINYINT NULL DEFAULT 0,
  `amount` FLOAT NOT NULL,
  PRIMARY KEY (`bank_account_id`),
  UNIQUE INDEX `routing_number_UNIQUE` (`routing_number` ASC) VISIBLE,
  UNIQUE INDEX `account_number_UNIQUE` (`account_number` ASC) VISIBLE,
  INDEX `FK_bank_id_idx` (`bank_id` ASC) VISIBLE,
  CONSTRAINT `FK_bank_account_bank_id`
    FOREIGN KEY (`bank_id`)
    REFERENCES `Bank` (`bank_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptoCurrency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CryptoCurrency` (
  `crypto_currency_id` INT NOT NULL AUTO_INCREMENT,
  `crypto_name` VARCHAR(45) NOT NULL,
  `blockchain_address` VARCHAR(35) NOT NULL,
  `value_usd` FLOAT NOT NULL,
  PRIMARY KEY (`crypto_currency_id`),
  UNIQUE INDEX `crypto_name_UNIQUE` (`crypto_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CryptoWallet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CryptoWallet` (
  `wallet_id` INT NOT NULL AUTO_INCREMENT,
  `public_address` VARCHAR(35) NOT NULL,
  `private_address` VARCHAR(32) NOT NULL,
  `crypto_currency_id` INT NOT NULL,
  PRIMARY KEY (`wallet_id`, `crypto_currency_id`),
  INDEX `PK_FK_cryptoCurrency_id_idx` (`crypto_currency_id` ASC) VISIBLE,
  UNIQUE INDEX `private_address_UNIQUE` (`private_address` ASC) VISIBLE,
  CONSTRAINT `PK_FK_wallet_cryptocurrency_id`
    FOREIGN KEY (`crypto_currency_id`)
    REFERENCES `CryptoCurrency` (`crypto_currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AccountAssets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AccountAssets` (
  `asset_id` INT NOT NULL AUTO_INCREMENT,
  `account_asset_id` INT NOT NULL,
  `isBankAccount` TINYINT NOT NULL,
  `account_id` INT NOT NULL,
  PRIMARY KEY (`asset_id`),
  INDEX `FK_asset_bank_account_id_idx` (`account_asset_id` ASC) VISIBLE,
  INDEX `FK_account_id_idx` (`account_id` ASC) VISIBLE,
  CONSTRAINT `FK_asset_bank_account_id`
    FOREIGN KEY (`account_asset_id`)
    REFERENCES `BankAccount` (`bank_account_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_asset_cryptoWallet_id`
    FOREIGN KEY (`account_asset_id`)
    REFERENCES `CryptoWallet` (`wallet_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_assets_account_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `Account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Renter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Renter` (
  `renter_id` INT NOT NULL AUTO_INCREMENT,
  `date_joined` DATE NOT NULL,
  `active` TINYINT NOT NULL,
  `person_id` INT NOT NULL,
  `monthly_payment` INT NOT NULL,
  PRIMARY KEY (`renter_id`, `person_id`),
  INDEX `PK_FK_renter_person_id_idx` (`person_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_renter_person_id`
    FOREIGN KEY (`person_id`)
    REFERENCES `Person` (`person_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Language` (
  `language_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `country_origin_id` INT NULL,
  PRIMARY KEY (`language_id`),
  INDEX `FK_country_id_idx` (`country_origin_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `FK_lang_disp_country_id`
    FOREIGN KEY (`country_origin_id`)
    REFERENCES `Country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Country` (
  `country_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `primary_language_id` INT NULL,
  PRIMARY KEY (`country_id`),
  INDEX `PK_FK_primary_language_id_idx` (`primary_language_id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `PK_FK_country_primary_language_id`
    FOREIGN KEY (`primary_language_id`)
    REFERENCES `Language` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `geographical_coordinates` VARCHAR(36) NOT NULL,
  `location_description` TEXT NULL,
  `country_id` INT NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `FK_country_id_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `FK_location_start_country_id`
    FOREIGN KEY (`country_id`)
    REFERENCES `Country` (`country_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LanguageDisplay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LanguageDisplay` (
  `language_display_id` INT NOT NULL AUTO_INCREMENT,
  `country_id` INT NOT NULL,
  `language_id` INT NOT NULL,
  PRIMARY KEY (`language_display_id`),
  INDEX `FK_country_id_idx` (`country_id` ASC) VISIBLE,
  INDEX `FK_language_id_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `FK_language_display_country_id`
    FOREIGN KEY (`country_id`)
    REFERENCES `Country` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_display_language_id`
    FOREIGN KEY (`language_id`)
    REFERENCES `Language` (`language_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AlertSystem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AlertSystem` (
  `alert_system_id` INT NOT NULL AUTO_INCREMENT,
  `date_applied` DATE NOT NULL,
  `company_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`alert_system_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PoliceStation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PoliceStation` (
  `police_station_id` INT NOT NULL AUTO_INCREMENT,
  `phone_number` VARCHAR(15) NOT NULL,
  `distance` INT NOT NULL,
  `isActive` TINYINT NOT NULL,
  `chief_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`police_station_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ATM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ATM` (
  `atm_id` INT NOT NULL AUTO_INCREMENT,
  `machine_balance` INT NULL DEFAULT 0,
  `isAuthorizedToMove` TINYINT NULL DEFAULT 0,
  `isEmpty` TINYINT NULL DEFAULT 1,
  `account_id` INT NULL,
  `atm_renter_id` INT NULL,
  `location_id` INT NOT NULL,
  `language_display_id` INT NOT NULL,
  `alert_system_id` INT NOT NULL,
  `police_station_id` INT NOT NULL,
  PRIMARY KEY (`atm_id`, `location_id`, `language_display_id`),
  INDEX `FK_account_id_idx` (`account_id` ASC) VISIBLE,
  INDEX `FK_renter_id_idx` (`atm_renter_id` ASC) VISIBLE,
  INDEX `FK_language_display_id_idx` (`language_display_id` ASC) VISIBLE,
  INDEX `FK_atm_location_id_idx` (`location_id` ASC) VISIBLE,
  INDEX `FK_atm_alert_system_id_idx` (`alert_system_id` ASC) VISIBLE,
  INDEX `FK_atm_police_station_id_idx` (`police_station_id` ASC) VISIBLE,
  CONSTRAINT `FK_atm_machine_account_id`
    FOREIGN KEY (`account_id`)
    REFERENCES `Account` (`account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_atm_renter_id`
    FOREIGN KEY (`atm_renter_id`)
    REFERENCES `Renter` (`renter_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_atm_location_id`
    FOREIGN KEY (`location_id`)
    REFERENCES `Location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_atm_language_display_id`
    FOREIGN KEY (`language_display_id`)
    REFERENCES `LanguageDisplay` (`language_display_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_atm_alert_system_id`
    FOREIGN KEY (`alert_system_id`)
    REFERENCES `AlertSystem` (`alert_system_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_atm_police_station_id`
    FOREIGN KEY (`police_station_id`)
    REFERENCES `PoliceStation` (`police_station_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Currency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Currency` (
  `currency_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `value_in_gold` FLOAT NOT NULL,
  PRIMARY KEY (`currency_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AcceptedCurrency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AcceptedCurrency` (
  `accepted_curr_id` INT NOT NULL AUTO_INCREMENT,
  `currency_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`accepted_curr_id`),
  INDEX `FK_country_id_idx` (`country_id` ASC) VISIBLE,
  INDEX `FK_currency_id_idx` (`currency_id` ASC) VISIBLE,
  CONSTRAINT `FK_country_id`
    FOREIGN KEY (`country_id`)
    REFERENCES `Country` (`country_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_currency_id`
    FOREIGN KEY (`currency_id`)
    REFERENCES `Currency` (`currency_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BankComputer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BankComputer` (
  `bank_computer_id` INT NOT NULL AUTO_INCREMENT,
  `mac_address` VARCHAR(6) NOT NULL,
  `ip_address` VARCHAR(16) NOT NULL,
  `bank_id` INT NOT NULL,
  PRIMARY KEY (`bank_computer_id`),
  INDEX `FK_bank_id_idx` (`bank_id` ASC) VISIBLE,
  UNIQUE INDEX `mac_address_UNIQUE` (`mac_address` ASC) VISIBLE,
  UNIQUE INDEX `ip_address()_UNIQUE` (`ip_address` ASC) VISIBLE,
  CONSTRAINT `FK_computer_bank_id`
    FOREIGN KEY (`bank_id`)
    REFERENCES `Bank` (`bank_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HostProcessor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HostProcessor` (
  `host_processor_id` INT NOT NULL AUTO_INCREMENT,
  `ip_address` VARCHAR(16) NOT NULL,
  `distance` INT NOT NULL,
  `isActive` TINYINT NOT NULL,
  `mac_address` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`host_processor_id`),
  UNIQUE INDEX `mac_address_UNIQUE` (`mac_address` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ATMConnections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ATMConnections` (
  `connection_id` INT NOT NULL AUTO_INCREMENT,
  `atm_id` INT NOT NULL,
  `host_processor_id` INT NOT NULL,
  `isConnected` TINYINT NOT NULL,
  `last_conn_established` DATE NULL,
  `port` INT NOT NULL,
  PRIMARY KEY (`connection_id`, `atm_id`),
  INDEX `FK_atm_id_idx` (`atm_id` ASC) VISIBLE,
  INDEX `FK_host_proccessor_id_idx` (`host_processor_id` ASC) VISIBLE,
  CONSTRAINT `FK_connections_atm_id`
    FOREIGN KEY (`atm_id`)
    REFERENCES `ATM` (`atm_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_connections_host_proccessor_id`
    FOREIGN KEY (`host_processor_id`)
    REFERENCES `HostProcessor` (`host_processor_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BankConnections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BankConnections` (
  `bank_connection_id` INT NOT NULL AUTO_INCREMENT,
  `host_processor_id` INT NOT NULL,
  `bank_computer_id` INT NOT NULL,
  `isConnected` TINYINT NOT NULL,
  PRIMARY KEY (`bank_connection_id`),
  INDEX `FK_host_processor_id_idx` (`host_processor_id` ASC) VISIBLE,
  INDEX `FK_bank_computer_id_idx` (`bank_computer_id` ASC) VISIBLE,
  CONSTRAINT `FK_bank_host_processor_id`
    FOREIGN KEY (`host_processor_id`)
    REFERENCES `HostProcessor` (`host_processor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_bank_computer_id`
    FOREIGN KEY (`bank_computer_id`)
    REFERENCES `BankComputer` (`bank_computer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Refiller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Refiller` (
  `refiller_id` INT NOT NULL AUTO_INCREMENT,
  `bank_id` INT NOT NULL,
  `atm_id` INT NOT NULL,
  PRIMARY KEY (`refiller_id`),
  INDEX `FK_ban_id_idx` (`bank_id` ASC) VISIBLE,
  INDEX `FK_atm_id_idx` (`atm_id` ASC) VISIBLE,
  CONSTRAINT `FK_refiller_bank_id`
    FOREIGN KEY (`bank_id`)
    REFERENCES `Bank` (`bank_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_refiller_atm_id`
    FOREIGN KEY (`atm_id`)
    REFERENCES `ATM` (`atm_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `date_established` DATE NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `number_employees` INT NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GuestAssistance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GuestAssistance` (
  `guest_assist_dept_id` INT NOT NULL AUTO_INCREMENT,
  `president_name` VARCHAR(45) NOT NULL,
  `country_located_id` INT NOT NULL,
  `dept_id` INT NOT NULL,
  PRIMARY KEY (`guest_assist_dept_id`),
  INDEX `FK_country_id_idx` (`country_located_id` ASC) VISIBLE,
  INDEX `PK_FK_dept_id_idx` (`dept_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_dept_id`
    FOREIGN KEY (`dept_id`)
    REFERENCES `Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_country_located_country_id`
    FOREIGN KEY (`country_located_id`)
    REFERENCES `Country` (`country_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Maintenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Maintenance` (
  `maintenance_dept_id` INT NOT NULL AUTO_INCREMENT,
  `president_name` VARCHAR(45) NOT NULL,
  `isActive` TINYINT NOT NULL,
  `location_id` INT NOT NULL,
  `dept_id` INT NOT NULL,
  PRIMARY KEY (`maintenance_dept_id`),
  UNIQUE INDEX `location_id_UNIQUE` (`location_id` ASC) VISIBLE,
  INDEX `PK_FK_maintenance_department_id_idx` (`dept_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_maintenance_department_id`
    FOREIGN KEY (`dept_id`)
    REFERENCES `Department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_location_maintenance_dep`
    FOREIGN KEY (`location_id`)
    REFERENCES `Location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MaintenanceEmployees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MaintenanceEmployees` (
  `maint_employee_id` INT NOT NULL AUTO_INCREMENT,
  `maint_dept_id` INT NOT NULL,
  `ssn` INT NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `hire_date` DATE NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `salary` FLOAT NOT NULL,
  PRIMARY KEY (`maint_employee_id`),
  INDEX `FK_dept_id_idx` (`maint_dept_id` ASC) VISIBLE,
  UNIQUE INDEX `ssn_UNIQUE` (`ssn` ASC) VISIBLE,
  CONSTRAINT `FK_maint_emp_dept_id`
    FOREIGN KEY (`maint_dept_id`)
    REFERENCES `Maintenance` (`maintenance_dept_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GAEmployees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GAEmployees` (
  `ga_employee_id` INT NOT NULL AUTO_INCREMENT,
  `guest_assist_dept_id` INT NOT NULL,
  `ssn` INT(9) ZEROFILL NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `hire_date` DATE NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `salary` FLOAT NOT NULL,
  PRIMARY KEY (`ga_employee_id`),
  INDEX `FK_dept_id_idx` (`guest_assist_dept_id` ASC) VISIBLE,
  UNIQUE INDEX `ssn_UNIQUE` (`ssn` ASC) VISIBLE,
  CONSTRAINT `FK_GA_dept_id`
    FOREIGN KEY (`guest_assist_dept_id`)
    REFERENCES `GuestAssistance` (`guest_assist_dept_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Keys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Keys` (
  `key_id` INT NOT NULL AUTO_INCREMENT,
  `inUse` TINYINT NOT NULL,
  `atm_id` INT NOT NULL,
  `last_used` DATE NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`key_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `KeyRing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `KeyRing` (
  `key_ring_id` INT NOT NULL AUTO_INCREMENT,
  `physical_key_id` INT NOT NULL,
  `digital_key_id` INT NOT NULL,
  `atm_id` INT NOT NULL,
  PRIMARY KEY (`key_ring_id`, `atm_id`),
  INDEX `FK_key_id_digital_idx` (`digital_key_id` ASC) VISIBLE,
  INDEX `FK_key_id_physical_idx` (`physical_key_id` ASC) VISIBLE,
  INDEX `PK_FK_atm_id_idx` (`atm_id` ASC) VISIBLE,
  UNIQUE INDEX `physical_key_id_UNIQUE` (`physical_key_id` ASC) VISIBLE,
  UNIQUE INDEX `digital_key_id_UNIQUE` (`digital_key_id` ASC) VISIBLE,
  UNIQUE INDEX `atm_id_UNIQUE` (`atm_id` ASC) VISIBLE,
  CONSTRAINT `FK_ring_key_id_physical`
    FOREIGN KEY (`physical_key_id`)
    REFERENCES `Keys` (`key_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_ring_key_id_digital`
    FOREIGN KEY (`digital_key_id`)
    REFERENCES `Keys` (`key_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PK_FK_keyring_atm_id`
    FOREIGN KEY (`atm_id`)
    REFERENCES `ATM` (`atm_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MaintenancePersonnel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MaintenancePersonnel` (
  `operator_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT NOT NULL,
  `certified` TINYINT NULL DEFAULT 1,
  `key_ring_id` INT NULL,
  PRIMARY KEY (`operator_id`),
  INDEX `PK_FK_employee_id_idx` (`employee_id` ASC) VISIBLE,
  INDEX `FK_key_ring_id_idx` (`key_ring_id` ASC) VISIBLE,
  UNIQUE INDEX `keyring_id_UNIQUE` (`key_ring_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_maint_personel_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `MaintenanceEmployees` (`maint_employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_personel_key_ring_id`
    FOREIGN KEY (`key_ring_id`)
    REFERENCES `KeyRing` (`key_ring_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PhysicalKey`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PhysicalKey` (
  `physical_key_id` INT NOT NULL,
  `creation_date` DATE NOT NULL,
  `maker` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`physical_key_id`),
  CONSTRAINT `PK_FK_key_physical_id`
    FOREIGN KEY (`physical_key_id`)
    REFERENCES `Keys` (`key_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DigitalKey`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DigitalKey` (
  `digital_key_id` INT NOT NULL,
  `hash_alg_used` VARCHAR(45) NOT NULL,
  `last_rehash` DATE NOT NULL,
  PRIMARY KEY (`digital_key_id`),
  CONSTRAINT `PK_FK_key_digital_key_id`
    FOREIGN KEY (`digital_key_id`)
    REFERENCES `Keys` (`key_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PhoneOperator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PhoneOperator` (
  `phone_operator_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`phone_operator_id`),
  INDEX `FK_employee_id_idx` (`employee_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  CONSTRAINT `FK_phone_op_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `GAEmployees` (`ga_employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PhoneAssistance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PhoneAssistance` (
  `phone_assist_id` INT NOT NULL AUTO_INCREMENT,
  `phone_operator_id` INT NOT NULL,
  `atm_id` INT NOT NULL,
  PRIMARY KEY (`phone_assist_id`),
  INDEX `FK_phone_op_id_idx` (`phone_operator_id` ASC) VISIBLE,
  INDEX `FK_atm_id_idx` (`atm_id` ASC) VISIBLE,
  CONSTRAINT `FK_assist_phone_op_id`
    FOREIGN KEY (`phone_operator_id`)
    REFERENCES `PhoneOperator` (`phone_operator_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_phone_assist_atm_id`
    FOREIGN KEY (`atm_id`)
    REFERENCES `ATM` (`atm_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TransactionDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TransactionDetails` (
  `transaction_details_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `wasExchange` TINYINT NOT NULL,
  `wasCryptoTransfer` TINYINT NOT NULL,
  `amount` FLOAT NOT NULL,
  `cryptocurrency_id` INT NULL,
  `currency_id` INT NULL,
  PRIMARY KEY (`transaction_details_id`),
  INDEX `FK_cryptocurrency_id_idx` (`cryptocurrency_id` ASC) VISIBLE,
  INDEX `FK_transaction_details_currency_id_idx` (`currency_id` ASC) VISIBLE,
  CONSTRAINT `FK_transaction_details_cryptocurrency_id`
    FOREIGN KEY (`cryptocurrency_id`)
    REFERENCES `CryptoCurrency` (`crypto_currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_transaction_details_currency_id`
    FOREIGN KEY (`currency_id`)
    REFERENCES `Currency` (`currency_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `sender_id` INT NULL,
  `receiver_id` INT NULL,
  `date_processed` DATE NOT NULL,
  `transaction_details_id` INT NOT NULL,
  `atm_id` INT NOT NULL,
  `isChargeable` TINYINT NOT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `type_id_idx` (`transaction_details_id` ASC) VISIBLE,
  INDEX `FK_sender_account_id_idx` (`sender_id` ASC) VISIBLE,
  INDEX `FK_receiver_id_idx` (`receiver_id` ASC) VISIBLE,
  INDEX `FK_atm_id_idx` (`atm_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_transaction_details`
    FOREIGN KEY (`transaction_details_id`)
    REFERENCES `TransactionDetails` (`transaction_details_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_transactions_sender_account_id`
    FOREIGN KEY (`sender_id`)
    REFERENCES `Account` (`account_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_transactions_receiver_id`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `Account` (`account_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_transactions_atm_id`
    FOREIGN KEY (`atm_id`)
    REFERENCES `ATM` (`atm_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `amount` FLOAT NULL DEFAULT 0,
  `renter_id` INT NOT NULL,
  `transaction_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`, `transaction_id`),
  INDEX `PK_FK_transaction_details_id_idx` (`transaction_id` ASC) VISIBLE,
  INDEX `PK_FK_renter_id_idx` (`renter_id` ASC) VISIBLE,
  CONSTRAINT `PK_FK_payment_transaction_details_id`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `Transactions` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PK_FK_payment_renter_id`
    FOREIGN KEY (`renter_id`)
    REFERENCES `Renter` (`renter_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sensor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sensor` (
  `sensor_id` INT NOT NULL AUTO_INCREMENT,
  `atm_id` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `isTriggered` TINYINT NOT NULL,
  PRIMARY KEY (`sensor_id`),
  INDEX `FK_sensor_atim_id_idx` (`atm_id` ASC) VISIBLE,
  CONSTRAINT `FK_sensor_atim_id`
    FOREIGN KEY (`atm_id`)
    REFERENCES `ATM` (`atm_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
