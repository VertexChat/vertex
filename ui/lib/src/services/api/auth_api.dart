part of openapi.api;

class AuthApi {
  final ApiClient apiClient;

  AuthApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Allows a user that is registered to login with HTTP info returned
  ///
  /// Allows a user that is register to login to the applcation
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

  /// Allows a user that is registered to login
  ///
  /// Allows a user that is register to login to the applcation
  Future login({Login login}) async {
    Response response = await loginWithHttpInfo(login: login);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
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
    print(user.toString());
    Response response = await registerWithHttpInfo(user: user);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }
}
