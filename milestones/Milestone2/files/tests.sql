/**** test scripts ***/
USE atmDb; 

-- AcceptedCurrency DELETE/UPDATE
 DELETE FROM AcceptedCurrency WHERE accepted_curr_id = 1;
 UPDATE AcceptedCurrency SET currency_id = 3 WHERE accepted_curr_id = 2;

-- Account DELETE/UPDATE
DELETE FROM Account WHERE account_id = 1; -- FIXED 
UPDATE Account SET password = "YeetYeetJohnson" WHERE account_id = 2;

-- AccountAssets DELETE/UPDATE
DELETE FROM AccountAssets WHERE asset_id = 1;
UPDATE AccountAssets SET isBankAccount = 1 WHERE account_id = 2;

-- ATM DELETE/UPDATE
-- DELETE FROM ATM WHERE atm_id = 1; -- -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`transactions`, CONSTRAINT `FK_transactions_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `atm` (`atm_id`))
UPDATE ATM SET machine_balance = 200 WHERE atm_id = 2;

-- ATMConnections DELETE/UPDATE
DELETE FROM ATMConnections WHERE connection_id = 1;
UPDATE ATMConnections SET isConnected = 0 WHERE atm_id = 2;

-- Bank DELETE/UPDATE
-- DELETE FROM Bank WHERE bank_id = 1; -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`accountassets`, CONSTRAINT `FK_asset_bank_account_id` FOREIGN KEY (`account_asset_id`) REFERENCES `bankaccount` (`bank_account_id`) ON UPDATE CASCADE)
UPDATE Bank SET name = "Capitol One" WHERE bank_id = 2;

-- BankAccount DELETE/UPDATE
-- DELETE FROM BankAccount WHERE bank_account_id = 1; -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`accountassets`, CONSTRAINT `FK_asset_bank_account_id` FOREIGN KEY (`account_asset_id`) REFERENCES `bankaccount` (`bank_account_id`) ON UPDATE CASCADE)
UPDATE BankAccount SET amount = 500000 WHERE bank_account_id = 2;

-- BankComputer DELETE/UPDATE
DELETE FROM BankComputer WHERE bank_computer_id = 1;
UPDATE BankComputer SET ip_address = "123.27.111" WHERE bank_computer_id = 2;

-- BankConnections DELETE/UPDATE
DELETE FROM BankConnections WHERE bank_connection_id = 1;
UPDATE BankConnections SET isConnected = 0 WHERE bank_computer_id = 2;

-- Card DELETE/UPDATE
-- DELETE FROM Card WHERE card_id = 1; -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`transactions`, CONSTRAINT `FK_transactions_receiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `account` (`account_id`))
UPDATE Card SET pin = 2564 WHERE card_id = 2;

-- Country DELETE/UPDATE
-- DELETE FROM Country WHERE country_id = 1; -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`languagedisplay`, CONSTRAINT `FK_language_display_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`)
-- UPDATE Country SET primary_language_id = 4 WHERE country_id = 2; -- FAIL: Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`atmdb`.`country`, CONSTRAINT `PK_FK_country_primary_language_id` FOREIGN KEY (`primary_language_id`) REFERENCES `language` (`language_id`))

-- CryptoCurrency DELETE/UPDATE
-- DELETE FROM CryptoCurrency WHERE crypto_currency_id = 1; -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`cryptowallet`, CONSTRAINT `PK_FK_wallet_cryptocurrency_id` FOREIGN KEY (`crypto_currency_id`) REFERENCES `cryptocurrency` (`crypto_currency_id`))
UPDATE CryptoCurrency SET blockchain_address = "addyRandom" WHERE crypto_currency_id = 2;

-- CryptoWallet DELETE/UPDATE
-- DELETE FROM CryptoWallet WHERE wallet_id = 1; -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`cryptowallet`, CONSTRAINT `PK_FK_wallet_cryptocurrency_id` FOREIGN KEY (`crypto_currency_id`) REFERENCES `cryptocurrency` (`crypto_currency_id`))
UPDATE CryptoWallet SET public_address = "addyRandom" WHERE wallet_id = 2;

-- Currency DELETE/UPDATE
-- DELETE FROM Currency WHERE currency_id = 1; -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`transactiondetails`, CONSTRAINT `FK_transaction_details_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currency` (`currency_id`))
UPDATE Currency SET value_in_gold = .50 WHERE currency_id = 2;

-- Department DELETE/UPDATE
DELETE FROM Department WHERE department_id = 1;
UPDATE Department SET address = "NewAddress Lane" WHERE department_id = 2;

-- DigitalKey DELETE/UPDATE
DELETE FROM DigitalKey WHERE digital_key_id = 1;
UPDATE DigitalKey SET hash_alg_used = "new_hash_256" WHERE digital_key_id = 2;

-- GAEmployees DELETE/UPDATE
DELETE FROM GAEmployees WHERE ga_employee_id = 1;
UPDATE GAEmployees SET firstname = "Jacob" WHERE ga_employee_id = 2;

-- GuestAssistance DELETE/UPDATE
DELETE FROM GuestAssistance WHERE guest_assist_dept_id = 1;
UPDATE GuestAssistance SET president_name = "Carlos Flask" WHERE guest_assist_dept_id = 2;

-- HostProcessor DELETE/UPDATE
DELETE FROM HostProcessor WHERE host_processor_id = 1;
UPDATE HostProcessor SET isActive = 0 WHERE host_processor_id = 2;

-- KeyRing DELETE/UPDATE
DELETE FROM KeyRing WHERE key_ring_id = 1;
-- UPDATE KeyRing SET atm_id = 3 WHERE key_ring_id = 2; -- FAIL: Error Code: 1062. Duplicate entry '3' for key 'keyring.atm_id_UNIQUE' (NO REASSINGMENT OF KEYS ALLOWED)

-- Keys DELETE/UPDATE
DELETE FROM `Keys` WHERE key_id = 1;
UPDATE `Keys` SET inUse = 1 WHERE key_id = 2; 

-- Language DELETE/UPDATE
-- DELETE FROM Language WHERE language_id = 1; -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`languagedisplay`, CONSTRAINT `FK_display_language_id` FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`))
UPDATE Language SET name = "NewLangName" WHERE language_id = 2; 

-- LanguageDisplay DELETE/UPDATE
-- DELETE FROM LanguageDisplay WHERE language_display_id = 1; -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`atm`, CONSTRAINT `FK_atm_language_display_id` FOREIGN KEY (`language_display_id`) REFERENCES `languagedisplay` (`language_display_id`) ON UPDATE CASCADE)
UPDATE LanguageDisplay SET country_id = 3 WHERE language_display_id = 2; 

-- Location DELETE/UPDATE
-- DELETE FROM Location WHERE location_id = 1; -- FAIL: Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`atm`, CONSTRAINT `FK_atm_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON UPDATE CASCADE)
UPDATE Location SET street = "NewStreet", city = "NewCity", geographical_coordinates = "RadaRada" WHERE location_id = 2; 

-- Maintenance DELETE/UPDATE
DELETE FROM Maintenance WHERE maintenance_dept_id = 1;
UPDATE Maintenance SET president_name = "New President Name" WHERE maintenance_dept_id = 2; 

-- MaintenanceEmployees DELETE/UPDATE
DELETE FROM MaintenanceEmployees WHERE maint_employee_id = 1;
UPDATE MaintenanceEmployees SET ssn = 32349924 WHERE maint_employee_id = 2; 

-- MaintenancePersonnel DELETE/UPDATE
DELETE FROM MaintenancePersonnel WHERE operator_id = 1;
UPDATE MaintenancePersonnel SET certified = false WHERE operator_id = 2; 

-- Payment DELETE/UPDATE
DELETE FROM Payment WHERE payment_id = 1;
UPDATE Payment SET amount = 2000 WHERE payment_id = 2; 

-- Person DELETE/UPDATE
-- DELETE FROM Person WHERE person_id = 1; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`transactions`, CONSTRAINT `FK_transactions_receiver_id` FOREIGN KEY (`receiver_id`) REFERENCES `account` (`account_id`))
UPDATE Person SET first_name = "NewFirstName" WHERE person_id = 2; 

-- Phone DELETE/UPDATE
DELETE FROM Phone WHERE phone_id = 1;
UPDATE Phone SET service_provider = "cricketNew" WHERE phone_id = 2; 

-- PhoneAssistance DELETE/UPDATE
DELETE FROM PhoneAssistance WHERE phone_assist_id = 1;
UPDATE PhoneAssistance SET atm_id = 3 WHERE phone_assist_id = 2; 

-- PhoneOperator DELETE/UPDATE
DELETE FROM PhoneOperator WHERE phone_operator_id = 1;
UPDATE PhoneOperator SET employee_id = 3 WHERE phone_operator_id = 2; 

-- PhysicalKey DELETE/UPDATE
DELETE FROM PhysicalKey WHERE physical_key_id = 1;
UPDATE PhysicalKey SET creation_date = '1996-3-30' WHERE physical_key_id = 2;

-- Refiller DELETE/UPDATE
DELETE FROM Refiller WHERE refiller_id = 1;
UPDATE Refiller SET bank_id = 3 WHERE refiller_id = 2;

-- Renter DELETE/UPDATE
-- DELETE FROM Renter WHERE renter_id = 1; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`atm`, CONSTRAINT `FK_atm_renter_id` FOREIGN KEY (`atm_renter_id`) REFERENCES `renter` (`renter_id`))
UPDATE Renter SET active = false WHERE renter_id = 2;

-- TransactionDetails DELETE/UPDATE
-- DELETE FROM TransactionDetails WHERE transaction_details_id = 1; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`transactions`, CONSTRAINT `PK_FK_transaction_details` FOREIGN KEY (`transaction_details_id`) REFERENCES `transactiondetails` (`transaction_details_id`))
UPDATE TransactionDetails SET amount = 99999 WHERE transaction_details_id = 2;

-- Transaction DELETE/UPDATE
DELETE FROM Transactions WHERE transaction_id = 1;
UPDATE Transactions SET isChargeable = true WHERE transaction_id = 2;

-- AlertSystem DELETE/UPDATE
-- DELETE FROM AlertSystem WHERE alert_system_id = 1; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`atm`, CONSTRAINT `FK_atm_alert_system_id` FOREIGN KEY (`alert_system_id`) REFERENCES `alertsystem` (`alert_system_id`) ON UPDATE CASCADE)
UPDATE AlertSystem SET company_name = "newName" WHERE alert_system_id = 2;

-- PoliceStation DELETE/UPDATE
-- DELETE FROM PoliceStation WHERE police_station_id = 1; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`atmdb`.`atm`, CONSTRAINT `FK_atm_police_station_id` FOREIGN KEY (`police_station_id`) REFERENCES `policestation` (`police_station_id`))
UPDATE PoliceStation SET isActive = false WHERE police_station_id = 2;

-- Sensor DELETE/UPDATE
DELETE FROM Sensor WHERE sensor_id = 1;
UPDATE Sensor SET isTriggered = true WHERE sensor_id = 2;



