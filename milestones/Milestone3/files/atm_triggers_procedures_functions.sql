use atmDb; 

-- TRIGGERS --
DELIMITER $$
-- insert cascade onto Payment when insertion at Transaction
CREATE TRIGGER generate_transaction_payment AFTER INSERT ON Transactions
	FOR EACH ROW
    BEGIN
		DECLARE transaction INT; 
        SET transaction = (SELECT COUNT(*) FROM Payment payment WHERE payment.transaction_id = NEW.transaction_id); 
        
        -- checks to seeif the transaction is type chargeable && if the specific payment already exists.  
        IF (NEW.isChargeable = 1 AND transaction = 0) THEN
			-- insertion of the amount payed to the renter, the renter_id and the transaction_id. 
			INSERT INTO Payment (amount, renter_id, transaction_id) VALUES (.05 * 
            (SELECT detail.amount FROM TransactionDetails detail WHERE detail.transaction_details_id = NEW.transaction_details_id),
            (SELECT atm.atm_renter_id FROM ATM atm WHERE atm.atm_id = NEW.atm_id), 
            NEW.transaction_id);
            END IF;
    END $$
DELIMITER ;


DELIMITER $$
-- INSERT into MaintenancePersonnel if they're a technician in the MaintenanceEmployees. 
CREATE TRIGGER insert_maintenance_personnel AFTER INSERT ON MaintenanceEmployees
	FOR EACH ROW
		BEGIN
			DECLARE maint_personnel INT; 
			SET maint_personnel = (SELECT COUNT(*) FROM MaintenancePersonnel personnel WHERE personnel.employee_id =  NEW.maint_employee_id); 
			-- matching the position string if the new employee is a 'technician' && checks to see if technician is already in the table. 
			IF (new.position LIKE 'technician' AND maint_personnel = 0) THEN
				INSERT INTO MaintenancePersonnel (employee_id) VALUES (new.maint_employee_id); 
                END IF;
		END $$
DELIMITER ; 


DELIMITER $$
-- INSERT into PhoneOperator if they're a 'phone_operator' in the GAEmployees. 
CREATE TRIGGER insert_phone_operator AFTER INSERT ON GAEmployees
	FOR EACH ROW
		BEGIN
			DECLARE phone_operator INT; 
            SET phone_operator = (SELECT COUNT(*) FROM PhoneOperator phone_op WHERE phone_op.employee_id = NEW.ga_employee_id); 
			-- checking to see if the employee currently exists as a phone_operator && matching the position string if the new employee is a 'phone_operator'. 
			IF (new.position LIKE 'phone_operator' AND phone_operator = 0) THEN
				INSERT INTO PhoneOperator (employee_id) VALUES (new.ga_employee_id); 
                END IF; 
		END $$
DELIMITER ; 
-- PROCEDURES --

-- currently not required for m2. --