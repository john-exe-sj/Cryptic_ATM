use atmDb; 
-- /**** Language Insertions ****/
INSERT INTO Language (name) VALUES ("english"); 
INSERT INTO Language (name) VALUES ("french"); 
INSERT INTO Language (name) VALUES ("spanish"); 

-- /**** Country Insertions ****/
INSERT INTO Country (name, primary_language_id) VALUES ("united_states_of_america", 1); 
INSERT INTO Country (name, primary_language_id) VALUES ("canada", 2); 
INSERT INTO Country (name, primary_language_id) VALUES ("spain", 3); 
INSERT INTO Country (name, primary_language_id) VALUES ("united_kingdom", 1); 
INSERT INTO Country (name, primary_language_id) VALUES ("france", 2); 

-- /**** Language Updates ****/
UPDATE Language
SET country_origin_id = 4
WHERE language_id = 1; 

UPDATE Language
SET country_origin_id = 5
WHERE language_id = 2; 

UPDATE Language
SET country_origin_id = 3
WHERE language_id = 3; 

-- /**** LanguageDisplay Insertions ****/
INSERT INTO LanguageDisplay (country_id, language_id) VALUES (1, 1); 
INSERT INTO LanguageDisplay (country_id, language_id) VALUES (2, 3);
INSERT INTO LanguageDisplay (country_id, language_id) VALUES (4, 1); 
INSERT INTO LanguageDisplay (country_id, language_id) VALUES (1, 3); 

-- /**** Location Insertions ****/
INSERT INTO Location (street, city, geographical_coordinates, country_id, zip) VALUES ("Yeehaw road", "YeetYeet", "69:69:6", 1, "94444"); 
INSERT INTO Location (street, city, geographical_coordinates, country_id, zip) VALUES ("123 Wallaby Way", "B Sydney", "420:69:0", 1, "94441"); 
INSERT INTO Location (street, city, geographical_coordinates, country_id, zip) VALUES ("Your Grass Ave", "Is Glass City", "42:06:9", 1, "94442"); 
INSERT INTO Location (street, city, geographical_coordinates, country_id, zip) VALUES ("Yeeheee", "YeehYeeh", "420:420", 2, "94244"); 
INSERT INTO Location (street, city, geographical_coordinates, country_id, zip) VALUES ("1 Wallaby Way", "P Sydney", "420:69:0", 3, "94441"); 
INSERT INTO Location (street, city, geographical_coordinates, country_id, zip) VALUES ("Your Grass", "Is Glass City", "42:06:9", 4, "94442"); 
INSERT INTO Location (street, city, geographical_coordinates, country_id, zip) VALUES ("maint1", "maint_1_city", "47:47:47", 1, "94444"); 
INSERT INTO Location (street, city, geographical_coordinates, country_id, zip) VALUES ("maint2", "maint_2_city", "47:47:46", 1, "94434"); 
INSERT INTO Location (street, city, geographical_coordinates, country_id, zip) VALUES ("maint3", "maint_3_city", "47:47:45", 1, "94424"); 

-- /**** AlertSystem Insertions ****/ 
INSERT INTO AlertSystem (date_applied, company_name) VALUES ('1995-3-30', "Cisco");
INSERT INTO AlertSystem (date_applied, company_name) VALUES ('1995-3-30', "FireWire");
INSERT INTO AlertSystem (date_applied, company_name) VALUES ('1995-3-30', "AnonInc");

-- /**** PoliceStation Insertions ****/ 
INSERT INTO PoliceStation (phone_number, distance, chief_name, isActive) VALUES ("1234567", 100, "Albert", 0);
INSERT INTO PoliceStation (phone_number, distance, chief_name, isActive) VALUES ("1423453", 200, "Robert", 0);
INSERT INTO PoliceStation (phone_number, distance, chief_name, isActive) VALUES ("5689034", 100, "Bert", 0);

-- /**** ATM Insertions ****/
INSERT INTO ATM (location_id, language_display_id, police_station_id, alert_system_id) VALUES (1, 1, 1, 1); 
INSERT INTO ATM (location_id, language_display_id, police_station_id, alert_system_id) VALUES (2, 1, 2, 2); 
INSERT INTO ATM (location_id, language_display_id, police_station_id, alert_system_id) VALUES (3, 1, 3, 3); 
INSERT INTO ATM (location_id, language_display_id, police_station_id, alert_system_id) VALUES (4, 1, 1, 1); 
INSERT INTO ATM (location_id, language_display_id, police_station_id, alert_system_id) VALUES (5, 1, 2, 2); 
INSERT INTO ATM (location_id, language_display_id, police_station_id, alert_system_id) VALUES (6, 1, 3, 3); 

-- /**** Sensor Insertions ****/ 
INSERT INTO Sensor (atm_id, type, isTriggered) VALUES (1, "keypad", 0);
INSERT INTO Sensor (atm_id, type, isTriggered) VALUES (1, "rocker", 0);
INSERT INTO Sensor (atm_id, type, isTriggered) VALUES (1, "camera", 0);
INSERT INTO Sensor (atm_id, type, isTriggered) VALUES (2, "keypad", 0);
INSERT INTO Sensor (atm_id, type, isTriggered) VALUES (2, "rocker", 0);
INSERT INTO Sensor (atm_id, type, isTriggered) VALUES (2, "camera", 0);
INSERT INTO Sensor (atm_id, type, isTriggered) VALUES (3, "keypad", 0);
INSERT INTO Sensor (atm_id, type, isTriggered) VALUES (3, "rocker", 1);
INSERT INTO Sensor (atm_id, type, isTriggered) VALUES (3, "camera", 1);

-- /**** Person Insertions ****/ 
INSERT INTO Person (first_name, last_name, dob, age, gender) VALUES ("Bob", "Dylan", '1995-3-30', 42, "M"); 
INSERT INTO Person (first_name, last_name, dob, age, gender) VALUES ("Bob", "Warner", '1995-3-30', 43, "M"); 
INSERT INTO Person (first_name, last_name, dob, age, gender) VALUES ("Bob", "Richard", '1995-3-30', 44, "F"); 
INSERT INTO Person (first_name, last_name, dob, age, gender) VALUES ("Richard", "Snyder", '1995-3-30', 42, "M"); 
INSERT INTO Person (first_name, last_name, dob, age, gender) VALUES ("Richard", "Bobby", '1995-3-30', 42, "M"); 
INSERT INTO Person (first_name, last_name, dob, age, gender) VALUES ("Richard", "Dick", '1995-3-30', 42, "M"); 

-- /**** Phone Insertions ****/ 
INSERT INTO Phone (service_provider, phone_number, owner_id) VALUES ('at&t', "1302555697", 1);
INSERT INTO Phone (service_provider, phone_number, owner_id) VALUES ('tmobile', "1650551667", 2);
INSERT INTO Phone (service_provider, phone_number) VALUES ('cricket', "1650431627");

-- /**** Card Insertions ****/ 
INSERT INTO Card (card_number, pin, card_owner_id) VALUES ("1242-2421-1111", 1234, 1); 
INSERT INTO Card (card_number, pin, card_owner_id) VALUES ("1242-2421-1112", 9678, 2); 
INSERT INTO Card (card_number, pin, card_owner_id) VALUES ("1242-2421-1113", 2341, 3); 

-- /**** Currency Insertions ****/ 
INSERT INTO Currency (name, value_in_gold) VALUES ("USD", 12.00);
INSERT INTO Currency (name, value_in_gold) VALUES ("EURO", 5.00);
INSERT INTO Currency (name, value_in_gold) VALUES ("Peso", 1000.0);

-- /**** CryptoCurrency Insertions ****/ 
INSERT INTO CryptoCurrency (crypto_name, blockchain_address, value_usd) VALUES ("DOGE", "ADDY1", .25); 
INSERT INTO CryptoCurrency (crypto_name, blockchain_address, value_usd) VALUES ("SHIBA", "ADDY2", .00005); 
INSERT INTO CryptoCurrency (crypto_name, blockchain_address, value_usd) VALUES ("BTC", "ADDY3", 50000); 

-- /**** CryptoWallet Insertions ****/ 
INSERT INTO CryptoWallet (public_address, private_address, crypto_currency_id) VALUES ("pub_Add1", "priv_Add1", 1); 
INSERT INTO CryptoWallet (public_address, private_address, crypto_currency_id) VALUES ("pub_Add2", "priv_Add2", 2); 
INSERT INTO CryptoWallet (public_address, private_address, crypto_currency_id) VALUES ("pub_Add3", "priv_Add3", 3); 

-- /**** Bank Insertions ****/ 
INSERT INTO Bank (name, date_joined) VALUES ("wells fargo", '1995-3-30');
INSERT INTO Bank (name, date_joined) VALUES ("chase", '1995-3-30');
INSERT INTO Bank (name, date_joined) VALUES ("bank of america", '1995-3-30');

-- /**** BankAccount Insertions ****/ 
INSERT INTO BankAccount (routing_number, account_number, bank_id, isChecking, amount) VALUES (1, 1, 1, 1, 0); 
INSERT INTO BankAccount (routing_number, account_number, bank_id, isChecking, amount) VALUES (2, 2, 1, 1, 0); 
INSERT INTO BankAccount (routing_number, account_number, bank_id, isChecking, amount) VALUES (3, 3, 1, 1, 0); 


-- /**** Account Insertions ****/ 
INSERT INTO Account (username, password, date_joined, card_id) VALUES ("Bobby1", "somepassword2", '1995-3-30', 1); 
INSERT INTO Account (username, password, date_joined, card_id) VALUES ("Bobby2", "somepassword2", '1995-3-30', 2); 
INSERT INTO Account (username, password, date_joined, card_id) VALUES ("Bobby3", "somepassword3", '1995-3-30', 3); 

-- /**** AccountAssets Insertions ****/ 
INSERT INTO AccountAssets (account_asset_id, isBankAccount, account_id) VALUES (1, 1, 1); 
INSERT INTO AccountAssets (account_asset_id, isBankAccount, account_id) VALUES (1, 0, 2); 
INSERT INTO AccountAssets (account_asset_id, isBankAccount, account_id) VALUES (1, 0, 3); 

-- /**** BankComputer Insertions ****/ 
INSERT INTO BankComputer (mac_address, ip_address, bank_id) VALUES ("mac_1", "ip_1", 1);
INSERT INTO BankComputer (mac_address, ip_address, bank_id) VALUES ("mac_2", "ip_2", 2); 
INSERT INTO BankComputer (mac_address, ip_address, bank_id) VALUES ("mac_3", "ip_3", 3);  

-- /**** HostProcessor Insertions ****/ 
INSERT INTO HostProcessor (mac_address, ip_address, distance, isActive) VALUES ("mac_1", "ip_1", 100, 1);
INSERT INTO HostProcessor (mac_address, ip_address, distance, isActive) VALUES ("mac_2", "ip_2", 200, 1);
INSERT INTO HostProcessor (mac_address, ip_address, distance, isActive) VALUES ("mac_3", "ip_3", 300, 1); 

-- /**** BankConnections Insertions ****/ 
INSERT INTO BankConnections (host_processor_id, bank_computer_id, isConnected) VALUES (1, 1, 1);
INSERT INTO BankConnections (host_processor_id, bank_computer_id, isConnected) VALUES (2, 2, 1);
INSERT INTO BankConnections (host_processor_id, bank_computer_id, isConnected) VALUES (3, 3, 1);

-- /**** ATMConnections Insertions ****/ 
INSERT INTO ATMConnections (atm_id, host_processor_id, isConnected, port) VALUES (1, 1, 1, 3000);
INSERT INTO ATMConnections (atm_id, host_processor_id, isConnected, port) VALUES (2, 2, 1, 3000);
INSERT INTO ATMConnections (atm_id, host_processor_id, isConnected, port) VALUES (3, 3, 1, 3000);

-- /**** Refiller Insertions ****/
INSERT INTO Refiller (bank_id, atm_id) VALUES (1, 1);
INSERT INTO Refiller (bank_id, atm_id) VALUES (2, 2);
INSERT INTO Refiller (bank_id, atm_id) VALUES (3, 3);

-- /**** AcceptedCurrency Insertions ****/
INSERT INTO AcceptedCurrency (currency_id, country_id) VALUES (1, 1);
INSERT INTO AcceptedCurrency (currency_id, country_id) VALUES (2, 2);
INSERT INTO AcceptedCurrency (currency_id, country_id) VALUES (3, 3);
INSERT INTO AcceptedCurrency (currency_id, country_id) VALUES (2, 1);

-- /**** Keys Insertions ****/
INSERT INTO `Keys`(inUse, atm_id, type) VALUES (0, 1, "physical"); -- Keys is a reserved word in SQL
INSERT INTO `Keys`(inUse, atm_id, type) VALUES (0, 1, "digital"); -- Keys is a reserved word in SQL
INSERT INTO `Keys`(inUse, atm_id, type) VALUES (0, 2, "physical"); -- Keys is a reserved word in SQL
INSERT INTO `Keys`(inUse, atm_id, type) VALUES (0, 2, "digital"); -- Keys is a reserved word in SQL
INSERT INTO `Keys`(inUse, atm_id, type) VALUES (0, 3, "physical"); -- Keys is a reserved word in SQL
INSERT INTO `Keys`(inUse, atm_id, type) VALUES (0, 3, "digital"); -- Keys is a reserved word in SQL

-- /**** DigitalKey Insertions ****/
INSERT INTO DigitalKey (digital_key_id, hash_alg_used, last_rehash) VALUES (2, "sha256", '1995-3-30');
INSERT INTO DigitalKey (digital_key_id, hash_alg_used, last_rehash) VALUES (4, "sha256", '1995-3-30');
INSERT INTO DigitalKey (digital_key_id, hash_alg_used, last_rehash) VALUES (6, "sha256", '1995-3-30');

-- /**** PhysicalKey Insertions ****/
INSERT INTO PhysicalKey (physical_key_id, creation_date, maker) VALUES (1, '1995-3-30', "LockSmith_inc");
INSERT INTO PhysicalKey (physical_key_id, creation_date, maker) VALUES (3, '1995-3-30', "LockSmith_inc");
INSERT INTO PhysicalKey (physical_key_id, creation_date, maker) VALUES (5, '1995-3-30', "LockSmith_inc");

-- /**** KeyRing Insertions ****/
INSERT INTO KeyRing (physical_key_id, digital_key_id, atm_id) VALUES (1, 2, 1);
INSERT INTO KeyRing (physical_key_id, digital_key_id, atm_id) VALUES (3, 4, 2);
INSERT INTO KeyRing (physical_key_id, digital_key_id, atm_id) VALUES (5, 6, 3);

-- /**** Department Insertions ****/
INSERT INTO Department (date_established, address, number_employees) VALUES ('1995-3-30', "addy1", 5);
INSERT INTO Department (date_established, address, number_employees) VALUES ('1995-3-30', "addy1", 5);
INSERT INTO Department (date_established, address, number_employees) VALUES ('1995-3-30', "addy1", 0);

-- /**** GuestAssistance Insertions ****/
INSERT INTO GuestAssistance (dept_id, president_name, country_located_id) VALUES (1, "YeeYee Johnson", 1);
INSERT INTO GuestAssistance (dept_id, president_name, country_located_id) VALUES (1, "Walbert Ramos", 1);
INSERT INTO GuestAssistance (dept_id, president_name, country_located_id) VALUES (1, "Tibur Nesse", 2);

-- /**** GAEmployees Insertions ****/ (double check with professor if theyre running triggers.)
INSERT INTO GAEmployees (guest_assist_dept_id, ssn, date_of_birth, hire_date, firstname, lastname, position, salary) VALUES (1, 1266798, '1995-3-30', '1995-1-30', "John", "Gionolli", "phone_operator", 800.90); -- insertions for PhoneOperator as well (email unassigned)
INSERT INTO GAEmployees (guest_assist_dept_id, ssn, date_of_birth, hire_date, firstname, lastname, position, salary) VALUES (1, 1266718, '1995-3-30', '1996-2-15', "Waller", "Baker", "phone_operator", 900.00); -- insertions for PhoneOperator as well (email unassigned)
INSERT INTO GAEmployees (guest_assist_dept_id, ssn, date_of_birth, hire_date, firstname, lastname, position, salary) VALUES (1, 1266118, '1995-3-30', '1997-5-30', "Joe", "Bartelozzi", "phone_operator", 1000.00); -- insertions for PhoneOperator as well (email unassigned)
INSERT INTO GAEmployees (guest_assist_dept_id, ssn, date_of_birth, hire_date, firstname, lastname, position, salary) VALUES (1, 1266799, '1995-3-30', '1995-3-30', "Jan", "Giovani", "receptionist", 300.50);
INSERT INTO GAEmployees (guest_assist_dept_id, ssn, date_of_birth, hire_date, firstname, lastname, position, salary) VALUES (1, 1266800, '1995-3-30', '1995-3-30', "Berthold", "Gio", "janitor", 700.50);

-- /**** Maintenance Insertions ****/
INSERT INTO Maintenance (dept_id, president_name, isActive, location_id) VALUES (2, "Lue Vega", 1, 4);
INSERT INTO Maintenance (dept_id, president_name, isActive, location_id) VALUES (2, "Gua Luca", 1, 5);
INSERT INTO Maintenance (dept_id, president_name, isActive, location_id) VALUES (2, "Jose Fernandez", 1, 6);

-- /**** MaintenanceEmployees Insertions ****/
INSERT INTO MaintenanceEmployees (maint_dept_id, ssn, date_of_birth, hire_date, firstname, lastname, position, salary) VALUES (2, 1111111, '1995-3-30', '1995-1-30', "Kura", "Zimmer", "technician", 900.50); -- insertions for MaintenancePersonel as well (KeyRing unnassigned)
INSERT INTO MaintenanceEmployees (maint_dept_id, ssn, date_of_birth, hire_date, firstname, lastname, position, salary) VALUES (2, 1111112, '1995-3-30', '1996-2-15', "Quran", "Bimmer", "technician", 900.50); -- insertions for MaintenancePersonel as well (KeyRing unnassigned)
INSERT INTO MaintenanceEmployees (maint_dept_id, ssn, date_of_birth, hire_date, firstname, lastname, position, salary) VALUES (2, 1111113, '1995-3-30', '1997-5-30', "Karen", "Fischer", "technician", 1000.50); -- insertions for MaintenancePersonel as well (KeyRing unnassigned)
INSERT INTO MaintenanceEmployees (maint_dept_id, ssn, date_of_birth, hire_date, firstname, lastname, position, salary) VALUES (2, 1111114, '1995-3-30', '1995-3-30', "Casey", "Dobber", "janitor", 700.00); -- insertions for MaintenancePersonel as well
INSERT INTO MaintenanceEmployees (maint_dept_id, ssn, date_of_birth, hire_date, firstname, lastname, position, salary) VALUES (2, 1111115, '1995-3-30', '1995-3-30', "Hailey", "Zimmer", "receptionist", 300.00); -- insertions for MaintenancePersonel as well

UPDATE MaintenancePersonnel SET certified = 0 WHERE MaintenancePersonnel.operator_id = 1;

-- /**** PhoneAssistance Insertions ****/
INSERT INTO PhoneAssistance (phone_operator_id, atm_id) VALUES (1, 1); 
INSERT INTO PhoneAssistance (phone_operator_id, atm_id) VALUES (2, 2); 
INSERT INTO PhoneAssistance (phone_operator_id, atm_id) VALUES (3, 3); 

-- /**** Renter Insertions ****/
INSERT INTO Renter (date_joined, active, person_id, monthly_payment) VALUES ('1995-3-30', 1, 4, 500); 
INSERT INTO Renter (date_joined, active, person_id, monthly_payment) VALUES ('1995-3-30', 1, 5, 500); 
INSERT INTO Renter (date_joined, active, person_id, monthly_payment) VALUES ('1995-3-30', 1, 6, 500); 

UPDATE ATM
SET atm_renter_id = 1
WHERE atm_id = 1; 

UPDATE ATM
SET atm_renter_id = 2
WHERE atm_id = 2;

UPDATE ATM
SET atm_renter_id = 3
WHERE atm_id = 3;

-- /**** TransactionDetails Insertions ****/
INSERT INTO TransactionDetails (name, wasExchange, wasCryptoTransfer, amount, currency_id) VALUES ("withdraw", 0, 0, 200.00, 1); -- non cryptorelated
INSERT INTO TransactionDetails (name, wasExchange, wasCryptoTransfer, amount, currency_id) VALUES ("deposit", 0, 0, 400.00, 1); -- non cryptorelated
INSERT INTO TransactionDetails (name, wasExchange, wasCryptoTransfer, amount, cryptocurrency_id, currency_id) VALUES ("money_to_crypto", 1, 0, 500.00, 3, 1); -- Crypto BTC exchange 500.00 BTC -> USD (CHARGEABLE)
INSERT INTO TransactionDetails (name, wasExchange, wasCryptoTransfer, amount, cryptocurrency_id, currency_id) VALUES ("crypto_to_money", 1, 0, 500.00, 3, 1); -- Crypto BTC exchange 500.00 BTC <- USD (CHARGEABLE)
INSERT INTO TransactionDetails (name, wasExchange, wasCryptoTransfer, amount, cryptocurrency_id) VALUES ("crypto_wallet_transfer", 1, 0, 500.00, 3); -- Cryptowallet transfer BTC -> BTC (CHARGEABLE)

-- /**** Transaction Insertions ****/
INSERT INTO Transactions (sender_id, receiver_id, date_processed, transaction_details_id, atm_id, isChargeable) VALUES (1, 1, '1995-3-30', 1, 1, 0); -- withdraw
INSERT INTO Transactions (sender_id, receiver_id, date_processed, transaction_details_id, atm_id, isChargeable) VALUES (2, 2, '1995-3-30', 2, 1, 0); -- deposit
INSERT INTO Transactions (sender_id, receiver_id, date_processed, transaction_details_id, atm_id, isChargeable) VALUES (3, 3, '1995-3-30', 3, 1, 1); -- money to crypto
INSERT INTO Transactions (sender_id, receiver_id, date_processed, transaction_details_id, atm_id, isChargeable) VALUES (3, 3, '1995-3-30', 4, 1, 1); -- crypto to money
INSERT INTO Transactions (sender_id, receiver_id, date_processed, transaction_details_id, atm_id, isChargeable) VALUES (3, 3, '1995-3-30', 5, 1, 1); -- wallet exchange




