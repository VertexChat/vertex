import connexion
import mysql.connector

from swagger_server.models.login import Login  # noqa: E501
from . import user_controller as user_control
from ..services import hashing


def login(body=None):  # noqa: E501
    """Allows a user that is registered to login

    Allows a user that is register to login to the application # noqa: E501

    :param body: User to be authenticated
    :type body: dict | bytes

    :rtype: None
    """
    if connexion.request.is_json:
        body = Login.from_dict(connexion.request.get_json())  # noqa: E501

        try:
            cnx = mysql.connector.connect(option_files='config.ini')  # Start Connection
            cursor = cnx.cursor()
            # Query
            query = "SELECT * FROM user WHERE user_name =(%s)"
            parm = body.user_name
            cursor.execute(query, (parm,))  # Run query
            # Loop through to find user by username
            for val in cursor.fetchall():
                if body.user_name in val:
                    print(val[2])  # Grab value at index two which is the password
                    # Compare the password to the saved hash and salt
                    password_check = hashing.check_password(body.password, val[2])
                    if password_check:
                        print("User is authenticated!")
                    else:
                        print("Password incorrect")
                else:
                    print("User does not exist in the database")

        except mysql.connector.Error as error:
            print("Failed to query database: {}".format(error))
            return "Failed to query database: {}".format(error)
        finally:
            if cnx.is_connected():
                cnx.close()
                cursor.close()
                print("MySQL connection is closed")

    return 'do some magic!'


def register(body=None):  # noqa: E501
    """Allows a user register a new account

    Allow a user register a new account with the server # noqa: E501

    :param body: User to be registered
    :type body: dict | bytes

    :rtype: None
    """
    # Pass the body to the add_user method as it does the same thing
    return user_control.add_user(body)
