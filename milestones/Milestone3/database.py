# database.py
# Handles all the methods interacting with the database of the application.
# Students must implement their own methods here to meet the project requirements.

import os
import pymysql.cursors

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']
PORT = int(os.environ['PORT'])

def connect():
    try:
        #print(os.environ)
        conn = pymysql.connect(host=db_host,
                               port=PORT,
                               user=db_username,
                               password=db_password,
                               db=db_name,
                               charset="utf8mb4",
                               cursorclass=pymysql.cursors.DictCursor)
        print("...connection established")
        return conn
    except Exception as e:
        print(e)
        print(
            "Bot failed to create a connection with your database because your secret environment variables "
            + "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set")
        print("\n")
# your code here

# helper functions
def parse_message(message): 
  return message.content.split(" ")

def retrieve_parameters(message):
  return parse_message(message)[1:]

def assemble_display_table(table_list):
  retVal = ""
  for row in table_list: 
    retVal += str(row) + "\n"
  return retVal

#TODO: Apply database guards when needed.
async def change_hash_alg_on_country(message, db_cursor):

  params = retrieve_parameters(message)
  if(len(params) != 2):
    return "improper amount of args on {}... try again".format(change_hash_alg_on_country.__name__)
  
  country_name = params[0]
  new_hash_alg = params[1]

  query = """
      SELECT keyring.digital_key_id FROM KeyRing keyring
      JOIN (
		      SELECT atm_id FROM Location location
		      JOIN ATM ON ATM.location_id = location.location_id
			    WHERE location.country_id = (
				  SELECT country.country_id 
				  FROM Country country 
				  WHERE country.name = %s
        )
      ) atmTable ON atmTable.atm_id = keyring.atm_id
      JOIN DigitalKey ON keyring.digital_key_id = DigitalKey.digital_key_id               
  """

  
  print(country_name)
  db_cursor.execute(query, 
    (
      country_name
    )
  )
  
  digital_key_ids = db_cursor.fetchall()
  print(digital_key_ids)
  query = """
        UPDATE DigitalKey SET hash_alg_used = %s 
        WHERE DigitalKey.digital_key_id = %s
  """

  count = 0
  for ele in digital_key_ids:
    db_cursor.execute(query, 
      (
        new_hash_alg, 
        ele["digital_key_id"]
      )
    )
    count += 1

  return "num rows affected " + str(count)

async def change_card_pin(message, db_cursor):
  
  params = retrieve_parameters(message)
  if(len(params) != 2):
    return "improper amount of args on {}... try again".format(change_card_pin.__name__)
  
  account_id = params[0]
  new_pin = params[1]

  query = """
      SELECT account.card_id FROM Account account
      JOIN Card ON account.card_id = Card.card_id
      WHERE account.account_id = %s 
  """

  db_cursor.execute( query, 
    (account_id)
  )

  result = db_cursor.fetchone()

  if(result is None): 
    return "A card does not exist for this specific account_id. No rows affected."

  query = """
      UPDATE Card SET pin = %s WHERE Card.card_id = %s
  """

  num_rows_affected = db_cursor.execute( query,
    (
      new_pin,
      result.get("card_id")
    )
  )

  return "num rows affected: " + str(num_rows_affected)

async def display_available_langauges(message, db_cursor):

  params = retrieve_parameters(message)
  if(len(params) != 1):
    return "improper amount of args on {}... try again".format(display_available_langauges.__name__)

  atm_id = params[0]

  query = '''
      SELECT Language.name FROM LanguageDisplay display
      JOIN Country ON display.country_id = Country.country_id
      JOIN Language ON display.language_id = Language.language_id
      JOIN Location ON Country.country_id = Location.country_id
      JOIN ATM ON Location.location_id = ATM.location_id
      WHERE ATM.atm_id = %s
  '''

  db_cursor.execute( query, 
    (
      atm_id
    )
  )

  language_display_table = db_cursor.fetchall()
    
  return  assemble_display_table(language_display_table)

async def display_accepted_currencies(message, db_cursor): 

  params = retrieve_parameters(message)
  if(len(params) != 1):
    return "improper amount of args on {}... try again".format(display_accepted_currencies.__name__)
    
  atm_id = params[0]

  query = '''
      SELECT currency.name FROM Currency currency
      JOIN AcceptedCurrency ON currency.currency_id = AcceptedCurrency.currency_id
      JOIN Country ON AcceptedCurrency.country_id = Country.country_id
      JOIN Location ON Country.country_id = Location.country_id
      JOIN ATM ON Location.location_id = ATM.location_id
      WHERE ATM.atm_id = %s
  '''

  db_cursor.execute( query,
    (
      atm_id
    )
  )

  available_currency_display_table = db_cursor.fetchall()
    
  return assemble_display_table(available_currency_display_table)

async def update_location(message, db_cursor): 

  params = retrieve_parameters(message)
  if(len(params) != 6):
    return "improper amount of args on {}... try again".format(display_accepted_currencies.__name__)
  
  atm_id = params[0]
  street_address = params[1]
  city = params[2]
  zip = params[3]
  country = params[4]
  geographical_coordinates = params[5]
  

  query = '''
      SELECT location.location_id FROM Location location
      JOIN ATM ON location.location_id = ATM.location_id
      WHERE ATM.atm_id = %s
  '''

  db_cursor.execute( query, 
    (
      atm_id
    )
  )

  result = db_cursor.fetchone()
  
  if(result is None): 
    return "Could not retrieve a Location this specific atm_id. This location may not exist. No rows affected."
    
  location_id = result.get("location_id")

  query = '''
      SELECT country.country_id FROM Country country 
      WHERE country.name = %s
  '''

  db_cursor.execute( query,
    (
      country
    )
  )

  result = db_cursor.fetchone()
  
  if(result is None): 
    return "Specified country may not exist. No rows affected."
  
  country_id = result.get('country_id')
  
  query = '''
      UPDATE Location 
      SET 
	      street = %s, 
	      city = %s, 
        country_id = %s, 
        zip = %s, 
        geographical_coordinates= %s
      WHERE Location.location_id = %s;
  '''

  num_rows_affected = db_cursor.execute( query,
    (
      street_address,
      city, 
      country_id,
      zip,
      geographical_coordinates, # Currently 8 bytes in the database... db needs a whole refactor.
      location_id
    )
  )

  return "num rows affected: " + str(num_rows_affected)
  
async def delete_account(message, db_cursor):

  params = retrieve_parameters(message)
  if(len(params) != 1):
    return "improper amount of args on {}... try again".format(delete_account.__name__)

  atm_id = params[0]

  query = """
    DELETE FROM Account WHERE account_id = %s;
  """

  num_rows_affected = db_cursor.execute(query, 
    (
      atm_id  
    )
  )

  return "num rows affected: " + str(num_rows_affected)

  
async def change_card_number(message, db_cursor):
  
  params = retrieve_parameters(message)
  if(len(params) != 2):
    return "improper amount of args on {}... try again".format(delete_account.__name__)
  account_id = params[0]
  new_card_number = params[1]

  query = """
    SELECT account.card_id FROM Account account
    JOIN Card ON account.card_id = Card.card_id
    WHERE account.account_id = %s
  """

  db_cursor.execute(query, 
    (
      account_id
    )
  )

  result =  db_cursor.fetchone()

  if(result is None):
    return "Could not retrieve a Card for this specific account_id. Card may not exist."
    
  card_id = result.get('card_id')

  query = """
    UPDATE Card 
    SET
      card_number = %s
    WHERE Card.card_id = %s
  """

  num_rows_affected = db_cursor.execute(query,
      (
        new_card_number,
        card_id
      )
  )

  return "num rows affected: " + str(num_rows_affected)

async def show_atm_lang_display(message, db_cursor):
  
  params = retrieve_parameters(message)
  if(len(params) != 1):
    return "improper amount of args on {}... try again".format(delete_account.__name__)

  atm_id = params[0]

  query = """
    SELECT language.name FROM Language language
    JOIN Country country ON country.primary_language_id = language.language_id
    JOIN Location location ON country.country_id = location.country_id
    JOIN ATM atm ON location.location_id = atm.location_id
    WHERE atm.atm_id = %s
  """

  db_cursor.execute(query, 
    (
      atm_id
    )
  )

  result = db_cursor.fetchone()
  
  if(result is None): 
    return "Could not retrieve a primary language specific to this atm. Language or Atm may not exist."
    
  atm_primary_language = result.get('name')

  return "Language in this atm is currently in: {}".format(atm_primary_language)

async def assign_keyring(message, db_cursor):
  
  params = retrieve_parameters(message)
  if(len(params) != 2):
    return "improper amount of args on {}... try again".format(assign_keyring.__name__)

  operator_id = params[0]
  key_ring_id = params[1]

  query = """
    SELECT COUNT(personnel.operator_id) AS isInMaintenancePersonnelTableAndCertified
    FROM MaintenancePersonnel personnel
    WHERE personnel.operator_id = %s AND personnel.certified = 1 
  """
  db_cursor.execute(query,
    (
      operator_id
    )
  )

  result = db_cursor.fetchone()

  if(result is None): 
    return "Could not retrieve the count of certified Maintenance Personnel who is certified."

  #check to see if that personnel exists
  if(result.get("isInMaintenancePersonnelTableAndCertified") == 0):
    return "Maintenance personnel with the operator_id: " + operator_id + " does not exist or is not certified. Key ring assignment failed."

  query = """
    SELECT COUNT(keyRing.key_ring_id) AS isInKeyRingTable 
    FROM KeyRing keyRing
    WHERE keyRing.key_ring_id = %s;
  """
  db_cursor.execute(query,
    (
      key_ring_id
    )
  )

  result = db_cursor.fetchone()

  if(result is None): 
    return "Could not retrieve the key ring for a Maintenance Personnel who is certified."

  #check to see if that the keyring exists
  if(result.get("isInKeyRingTable") == 0):
    return "Specified key ring with the key_ring_id: " + key_ring_id + " does not exist. Key ring assignment failed."

  # so the personnel and the keyring exist, now we 'give' the operator the key ring. 
  query = """
    UPDATE MaintenancePersonnel
    SET 
      key_ring_id = %s
    WHERE MaintenancePersonnel.operator_id = %s
  """
  
  num_rows_affected = db_cursor.execute(query,
    (
      key_ring_id,
      operator_id
    )
  )
  
  return "num rows affected: " + str(num_rows_affected)

async def contact_authorities(message, db_cursor): 
  
  params = retrieve_parameters(message)
  if(len(params) != 1):
    return "improper amount of args on {}... try again".format(assign_keyring.__name__)
    
  atm_id = params[0]

  query = """
    SELECT COUNT(sensor.isTriggered) AS numSensorsTriggered From Sensor sensor
    JOIN ATM on sensor.atm_id = ATM.atm_id
    WHERE ATM.atm_id = %s AND sensor.isTriggered = 1
  """

  db_cursor.execute(query, 
    (
      atm_id
    )
  )

  result = db_cursor.fetchone()

  if(result is None):
    return "Could retrieve the total of sensors that are triggered for the specificied atm. This atm may not exist."

  if(result.get("numSensorsTriggered") == 0): 
    return "ATM with atm_id: " + atm_id + " does not have triggered sensors. No need to notify the authorities."
  

  query = """
    SELECT police.police_station_id AS station_id FROM PoliceStation police 
    JOIN ATM  ON police.police_station_id = ATM.atm_id
    WHERE ATM.atm_id = %s
  """

  db_cursor.execute(query, 
    (
      atm_id
    )
  )

  result = db_cursor.fetchone()

  if(result is None):
    return "Could not retrieve a police station for a specified atm"
    
  police_station_id = result.get("station_id")

  query = """
    UPDATE PoliceStation SET isActive = 1
    WHERE PoliceStation.police_station_id = %s
  """

  num_rows_affected = db_cursor.execute(query, 
    (
      police_station_id
    )
  )
  
  return "num rows affected: " + str(num_rows_affected)


async def set_location_unauthorized(message, db_cursor):
  
  params = retrieve_parameters(message)
  if(len(params) != 6):
    return "improper amount of args on {}... try again".format(set_location_unauthorized.__name__)

  atm_id = params[0]
  street_address = params[1]
  city = params[2]
  zip = params[3]
  country = params[4]
  geographical_coordinates = params[5]

  query = """
    SELECT location.location_id, atm.isAuthorizedToMove 
    FROM ATM atm, Location location
    WHERE atm.atm_id = %s AND atm.location_id = location.location_id
  """

  db_cursor.execute(query, 
    (
      atm_id
    )
  )
  
  result = db_cursor.fetchone()
  
  if(result is None): 
    return "Could not retrieve a location and the authorization for this specified atm"
    
  isAuthorizedToMove = result.get("isAuthorizedToMove")
  location_id = result.get("location_id")

  if(isAuthorizedToMove == 0):

    query = """
      SELECT sensor_id FROM ATM atm
      JOIN Sensor sensor ON atm.atm_id = sensor.atm_id
      WHERE sensor.type = "rocker" AND atm.atm_id = %s
    """
    db_cursor.execute(query, 
      (
        atm_id
      )
    )

    result = db_cursor.fetchone()
    
    if(result is None): 
      return "Senors for this atm may not exist."
      
    sensor_id = result.get("sensor_id")

    query = """
      UPDATE Sensor SET isTriggered = 1 WHERE Sensor.sensor_id = %s
    """

    num_rows_affected = db_cursor.execute(query, 
      (
        sensor_id
      )
    )

    return "Sensor of type 'rocker' is triggered: num rows affected: " + str(num_rows_affected)

  query = '''
      SELECT country.country_id FROM Country country 
      WHERE country.name = %s
  '''

  db_cursor.execute(query,
    (
      country
    )
  )

  result = db_cursor.fetchone()

  if(result is None): 
    return "Could not retrieve a this country by a specified name. Country may not exist."
  country_id = result.get('country_id')

  query = '''
      UPDATE Location 
      SET 
	      street = %s, 
	      city = %s, 
        country_id = %s, 
        zip = %s, 
        geographical_coordinates= %s
      WHERE Location.location_id = %s;
  '''

  num_rows_affected = db_cursor.execute(query,
    (
      street_address,
      city, 
      country_id,
      zip,
      geographical_coordinates,
      location_id
    )
  )
    
  return "ATM authorized to move, location was updated. Sensor type 'rocker' was not triggered: num rows affected: " + str(num_rows_affected)


async def uncertify_personnel(message, db_cursor):
  
  params = retrieve_parameters(message)
  if(len(params) != 1):
    return "improper amount of args on {}... try again".format(uncertify_personnel.__name__)
  date = params[0]

  query = """
    SELECT operator_id FROM MaintenanceEmployees employee
    JOIN MaintenancePersonnel ON employee.maint_employee_id = MaintenancePersonnel.employee_id
    WHERE hire_date > %s 
  """

  db_cursor.execute(query,
    (
      date
    )
  )

  operator_ids = db_cursor.fetchall()

  query = """
    UPDATE MaintenancePersonnel 
    SET 
      certified = 0
    WHERE MaintenancePersonnel.operator_id = %s
  """
  
  num_rows_affected = 0
  for id_container in operator_ids: 
    db_cursor.execute(query,
      (
        id_container.get('operator_id')
      )
    )
    num_rows_affected += 1
    
  return "num rows affected: " + str(num_rows_affected)

async def apply_raise(message, db_cursor):
# IMPLEMENT
  params = retrieve_parameters(message)
  if(len(params) != 2):
    return "improper amount of args on {}... try again".format(apply_raise.__name__)
  date = params[0]
  percent_increase = float(params[1])

  query_maint_employee_id = """
    SELECT 
      employee.maint_employee_id AS employee_id, 
      employee.salary AS salary 
    FROM Department department, MaintenanceEmployees employee
    WHERE department.department_id = employee.maint_dept_id AND hire_date < %s
  """

  db_cursor.execute(query_maint_employee_id,
    (
      date
    )
  )
  
  maint_employee_ids_and_salaries = db_cursor.fetchall()


  num_rows_affected = 0
  for employee in maint_employee_ids_and_salaries: 
    query = """
      UPDATE MaintenanceEmployees employee
      SET
	      salary = %s
      WHERE employee.maint_employee_id = %s
    """
    
    salary_bump = (float(employee.get('salary')) * percent_increase)
    old_salary = float(employee.get('salary'))
    new_salary = old_salary + salary_bump
    employee_id = employee.get('employee_id')

    db_cursor.execute(query,
      (
        new_salary,
        employee_id
      )
    )
    num_rows_affected += 1
  
  query_ga_employee_id = """
    SELECT 
      employee.ga_employee_id AS employee_id, 
      employee.salary AS salary 
    FROM Department department, GAEmployees employee
    WHERE department.department_id = employee.guest_assist_dept_id AND hire_date < %s
  """

  db_cursor.execute(query_ga_employee_id,
    (
      date
    )
  )

  ga_employee_ids_and_salaries = db_cursor.fetchall()

  for employee in ga_employee_ids_and_salaries: 
    query = """
      UPDATE GAEmployees employee
      SET
	      salary = %s
      WHERE employee.ga_employee_id = %s
    """

    salary_bump = (float(employee.get('salary')) * percent_increase)
    old_salary = float(employee.get('salary'))
    new_salary = old_salary + salary_bump
    employee_id = employee.get('employee_id')

    db_cursor.execute(query,
      (
        new_salary,
        employee_id
      )
    )
    num_rows_affected += 1
  
  return "num rows affected: " + str(num_rows_affected)
  
async def test(message, db_cursor):
  query = '''
      SELECT * FROM Country country 
  '''
  db_cursor.execute(query)

  result_table = db_cursor.fetchall()

  return assemble_display_table(result_table)