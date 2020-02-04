# coding: utf-8

from __future__ import absolute_import

from flask import json
from six import BytesIO

from swagger_server.models.channel import Channel  # noqa: E501
from swagger_server.models.error import Error  # noqa: E501
from swagger_server.test import BaseTestCase


class TestChannelController(BaseTestCase):
    """ChannelController integration test stubs"""

    def test_add_channel(self):
        """Test case for add_channel

        Channel has been created
        """
        body = Channel()
        response = self.client.open(
            '/channels',
            method='POST',
            data=json.dumps(body),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_delete_channel_by_id(self):
        """Test case for delete_channel_by_id

        Deletes an existing channel
        """
        response = self.client.open(
            '/channels/{id}'.format(id=56),
            method='DELETE')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_channel_by_id(self):
        """Test case for get_channel_by_id

        Get a channel by its ID
        """
        response = self.client.open(
            '/channels/{id}'.format(id=56),
            method='GET')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_update_channel_by_id(self):
        """Test case for update_channel_by_id

        Updates an existing channel
        """
        body = Channel()
        response = self.client.open(
            '/channels/{id}'.format(id=56),
            method='PUT',
            data=json.dumps(body),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    import unittest
    unittest.main()
