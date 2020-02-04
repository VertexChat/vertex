# coding: utf-8

from __future__ import absolute_import

from flask import json
from six import BytesIO

from swagger_server.models.error import Error  # noqa: E501
from swagger_server.models.server import Server  # noqa: E501
from swagger_server.test import BaseTestCase


class TestServerController(BaseTestCase):
    """ServerController integration test stubs"""

    def test_search_server(self):
        """Test case for search_server

        Returns information about the server
        """
        response = self.client.open(
            '/server',
            method='GET')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    import unittest
    unittest.main()
