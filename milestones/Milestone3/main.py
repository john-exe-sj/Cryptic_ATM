# bot.py
# This file is intended to be a "getting started" code example for students.
# The code in this file is fully functional.
# Students are free to edit the code in the milestone 3 folder.
# Students are NOT allowed to distribute this code without the express permission of the class instructor
# IMPORTANT: How to set your secret environment variables? read README guidelines.

# imports
import os
import discord
import database as db
from datetime import datetime
# environment variables
token = os.environ['DISCORD_TOKEN']
server = os.environ['DISCORD_GUILD']
#server_id = os.environ['SERVER_ID']  # optional
#channel_id = os.environ['CHANNEL_ID']  # optional

# database connection
# secret keys related to your database must be updated. Otherwise, it won't work
# bot events
client = discord.Client()

async def runQuery(message, queryCallback): 
  
  # best practices https://stackoverflow.com/questions/5504340/python-mysqldb-connection-close-vs-cursor-close
  response = None
  try: 
    print("Bot connecting to the database...")
    db_conn = db.connect() # Create connection
    db_cursor = db_conn.cursor() # Create cursor

    print("User {} executing bot command {} at {}".format(
        str(message.author), 
        queryCallback.__name__, 
        datetime.now().strftime("%d/%m/%Y %H:%M:%S")
      )
    )

    print("Bot executing query to the database " 
          + runQuery.__name__ 
          + " -> " 
          + queryCallback.__name__)
    response = await queryCallback(message, db_cursor) # Create the queries string and Execute the query
    print("Bot successfully ran the query in " + queryCallback.__name__)
    response += "\nI successfully ran the query for: " + queryCallback.__name__ + ".\n Try another..."
    print("Bot committing changes to database and closing the cursor as well as connection")
    db_conn.commit() # Commit to the query
    db_cursor.close() # Close the cursor
    db_conn.close # Close the connection
  except Exception as e: 
    response = "Failure in " + runQuery.__name__ + " running: " + queryCallback.__name__
    print(response)
    print(e)
    response += "\nError message: " + str(e)
    response += "\nPlease try again with proper input or try another command."
  finally: 
    return response


@client.event
async def on_ready():
    """
    This method triggers with the bot connects to the server
    Note that the sample implementation here only prints the
    welcome message on the IDE console, not on Discord
    :return: VOID
    """
    print("{} has joined the server".format(client.user.name))


@client.event
async def on_message(message):
    """
    This method triggers when a user sends a message in any of your Discord server channels
    :param message: the message from the user. Note that this message is passed automatically by the Discord API
    :return: VOID
    """
    response = None # will save the response from the bot
    if message.author == client.user:
        return # the message was sent by the bot
    if message.type is discord.MessageType.new_member:
        response = "Welcome {}".format(message.author) # a new member joined the server. Welcome him.
    else:
        # A message was sent by the user.
        msg = message.content.lower()
        if "milestone3" in msg:
          print("Hello from m3")
          response = "I am alive. Signed: 'your bot'"
        elif "#change_hash_alg" in msg: 
          response = await runQuery(message, db.change_hash_alg_on_country)
        elif "#change_card_pin" in msg:
          response = await runQuery(message, db.change_card_pin)
        elif "#display_available_langauges" in msg: 
          response = await runQuery(message, db.display_available_langauges)
        elif "#display_accepted_currencies" in msg:
          response = await runQuery(message, db.display_accepted_currencies)
        elif "#update_location" in msg: 
          response = await runQuery(message, db.update_location)
        elif "#delete_account" in msg: 
          response = await runQuery(message, db.delete_account)
        elif "#change_card_number" in msg:
          response = await runQuery(message, db.change_card_number)
        elif "#show_atm_lang_display" in msg:
          response = await runQuery(message, db.show_atm_lang_display)
        elif "#assign_keyring" in msg: 
          response = await runQuery(message, db.assign_keyring)
        elif "#contact_authorities" in msg:
          response = await runQuery(message, db.contact_authorities)
        elif "#set_location_unauthorized" in msg: 
          response = await runQuery(message, db.set_location_unauthorized)
        elif "#uncertify_personnel" in msg: 
          response = await runQuery(message, db.uncertify_personnel)
        elif "#apply_raise" in msg:
          response = await runQuery(message, db.apply_raise)
        elif "test_query" in msg:
          response = await runQuery(message, db.test)

    if response:
        # bot sends response to the Discord API and the response is show
        # on the channel from your Discord server that triggered this method.
        embed = discord.Embed(description=response)
        await message.channel.send(embed=embed)

try:
    # start the bot and keep the above methods listening for new events
    # print(token)
    client.run(token)
except Exception as e:
    if "Access denied | discord.com used Cloudflare to restrict access" in str(e): 
      print("429 Too Many Requests (error code: 0): Access denied | discord.com used Cloudflare to restrict access")
    else: 
      print("Bot is offline because your secret environment variables are not set. Head to the left panel, " +
          "find the lock icon, and set your environment variables. For more details, read the README file in your " +
          "milestone 3 repository")