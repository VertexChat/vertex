import connexion
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
