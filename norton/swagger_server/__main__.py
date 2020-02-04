#!/usr/bin/env python3

import connexion
from flask_cors import CORS
from swagger_server import encoder


def main():
    app = connexion.App(__name__, specification_dir='./swagger/')
    CORS(app.app)  # Added to allow CORS
    app.app.json_encoder = encoder.JSONEncoder

    # validate_responses=True
    app.add_api('swagger.yaml', arguments={'title': 'Norton API'}, pythonic_params=True)
    app.run(port=8080)


if __name__ == '__main__':
    main()
