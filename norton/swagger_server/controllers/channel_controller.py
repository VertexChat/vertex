import connexion
import mysql.connector
import six

from swagger_server.models.channel import Channel  # noqa: E501
from swagger_server.models.error import Error  # noqa: E501
from swagger_server import util


def add_channel(body=None):  # noqa: E501
    """Channel has been created

    Channel has been created # noqa: E501

    :param body: The Channel to be created
    :type body: dict | bytes

    :rtype: None
    """
    if connexion.request.is_json:
        body = Channel.from_dict(connexion.request.get_json())  # noqa: E501
    return 'do some magic!'


def delete_channel_by_id(id):  # noqa: E501
    """Deletes an existing channel

    Deletes an existing channel # noqa: E501

    :param id: The channel ID
    :type id: int

    :rtype: None
    """
    return 'do some magic!'


def get_channel_by_id(id):  # noqa: E501
    """Get a channel by its ID

    Returns a single Channel if it exists # noqa: E501

    :param id: The channel ID
    :type id: int

    :rtype: Channel
    """
    # Query
    query = "SELECT * FROM channel WHERE channel_name = 'VOICE'"

    try:
        cnx = mysql.connector.connect(option_files='config.ini')  # Start Connection
        cursor = cnx.cursor()
        cursor.execute(query)  # Run query

        result = cursor.fetchall()
        print(result)
        return result

    except mysql.connector.Error as error:
        return "Failed to query database: {}".format(error), 500
    finally:
        if cnx.is_connected():
            cnx.close()
            cursor.close()
            print("MySQL connection is closed")
            

    return 'do some magic!'


def update_channel_by_id(id, body=None):  # noqa: E501
    """Updates an existing channel

    Updates an existing channel # noqa: E501

    :param id: The channel ID
    :type id: int
    :param body: Channel to be added
    :type body: dict | bytes

    :rtype: None
    """
    if connexion.request.is_json:
        body = Channel.from_dict(connexion.request.get_json())  # noqa: E501
    return 'do some magic!'
