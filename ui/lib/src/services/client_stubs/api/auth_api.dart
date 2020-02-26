part of openapi.api;

class AuthApi {
  //Variables
  final ApiClient apiClient;
  bool _isLoggedIn = false;

  AuthApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Allows a user that is registered to login with HTTP info returned
  ///
  /// Allows a user that is register to login to the application
  Future loginWithHttpInfo({Login login}) async {
    Object postBody = login;

    // verify required params are set

    // create path and map variables
    String path = "/login".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    // Added login_auth
    List<String> authNames = ['login_auth'];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Allows a user that is registered to login
  ///
  /// Allows a user that is register to login to the application
  Future login({Login login}) async {
    Response response = await loginWithHttpInfo(login: login);
    if (response.statusCode >= 400) {
      print(response.statusCode);
      isLoggedIn = false;
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
      isLoggedIn = true;
      print(isLoggedIn);
    } else {
      isLoggedIn = true;
      print(isLoggedIn);
      return;
    }
    return;
  }

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool value) {
    _isLoggedIn = value;
  }

  /// Allows a user register a new account with HTTP info returned
  ///
  /// Allow a user register a new account with the server
  Future registerWithHttpInfo({User user}) async {
    Object postBody = user;

    // verify required params are set

    // create path and map variables
    String path = "/register".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Allows a user register a new account
  ///
  /// Allow a user register a new account with the server
  Future register({User user}) async {
    Response response = await registerWithHttpInfo(user: user);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }
}
