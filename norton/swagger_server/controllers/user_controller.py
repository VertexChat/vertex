import connexion
import six

from swagger_server.models.error import Error  # noqa: E501
from swagger_server.models.user import User  # noqa: E501
from swagger_server import util
import mysql.connector
from ..services import hashing


# https://dev.mysql.com/doc/connector-python/en/connector-python-api-errors-error.html
# https://dev.mysql.com/doc/connector-python/en/connector-python-example-cursor-transaction.html


def add_user(body=None):  # noqa: E501
    """User has been created

    User has been created # noqa: E501

    :param body: User to be added
    :type body: dict | bytes

    :rtype: None
    """
    if connexion.request.is_json:
        body = User.from_dict(connexion.request.get_json())  # noqa: E501
        # Hash password
        hashed_password = hashing.get_hashed_password(body.password)
        # Query
        query = "INSERT INTO user (user_name, password, display_name) VALUES (%s, %s, %s)"
        user_details = (body.username, hashed_password, body.display_name)
        try:
            cnx = mysql.connector.connect(option_files='config.ini')  # Start Connection
            cursor = cnx.cursor()
            cursor.execute(query, user_details)  # Run query
            cnx.commit()  # Commit
            return "New user registered", 201
        except mysql.connector.Error as error:
            if error.errno == 1062:
                return "Sorry that username already exists in the database", 401
            else:
                return "Failed to insert into MySQL table: {}".format(error)
        finally:
            if cnx.is_connected():
                cnx.close()
                cursor.close()
                print("MySQL connection is closed")

    return 'do some magic!'


def delete_user_by_id(id):  # noqa: E501
    """Deletes an existing User

    Deletes a user from the database # noqa: E501

    :param id: The User ID
    :type id: int

    :rtype: None
    """
    return 'do some magic!'


def get_user_by_id(id):  # noqa: E501
    """Returns a single User if it exists

    Returns a single User if it exists # noqa: E501

    :param id: The User ID
    :type id: int

    :rtype: User
    """

    return 'do some magic!'


def update_user_by_id(id, body=None):  # noqa: E501
    """Updates an existing User

    Updates an existing User # noqa: E501

    :param id: The User ID
    :type id: int
    :param body: User entity to be created
    :type body: dict | bytes

    :rtype: None
    """
    if connexion.request.is_json:
        body = User.from_dict(connexion.request.get_json())  # noqa: E501
    return 'do some magic!'
