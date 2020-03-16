library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';

part 'api/auth_api.dart';
part 'api/channel_api.dart';
part 'api/message_api.dart';
part 'api/server_api.dart';
part 'api/user_api.dart';

part 'model/channel.dart';
part 'model/error.dart';
part 'model/login.dart';
part 'model/message.dart';
part 'model/server.dart';
part 'model/user.dart';


ApiClient defaultApiClient = ApiClient();
