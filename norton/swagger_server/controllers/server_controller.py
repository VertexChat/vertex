import connexion
import six

from swagger_server.models.error import Error  # noqa: E501
from swagger_server.models.server import Server  # noqa: E501
from swagger_server import util


def search_server():  # noqa: E501
    """Returns information about the serverd

    Returns information about the server like the version its on and amount of users on the server  # noqa: E501


    :rtype: Server
    """
    return 'do some magic!'
