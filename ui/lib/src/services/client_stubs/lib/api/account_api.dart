part of openapi.api;

class AccountApi {
  final ApiClient apiClient;
  bool isLoggedIn = false;


  AccountApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Log in with HTTP info returned
  ///
  /// Attempts to log a user in
  Future loginWithHttpInfo(InlineObject inlineObject) async {
    Object postBody = inlineObject;

    // verify required params are set
    if (inlineObject == null) {
      throw ApiException(400, "Missing required param: inlineObject");
    }

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

  /// Log in
  ///
  /// Attempts to log a user in
  Future login(InlineObject inlineObject) async {

    Response response = await loginWithHttpInfo(inlineObject);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }

  /// Registers User with HTTP info returned
  ///
  /// Attempts to register a new user
  Future registerWithHttpInfo(InlineObject inlineObject) async {
    Object postBody = inlineObject;

    // verify required params are set
    if (inlineObject == null) {
      throw ApiException(400, "Missing required param: inlineObject1");
    }

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

  /// Registers User
  ///
  /// Attempts to register a new user
  Future register(InlineObject inlineObject) async {
    print(inlineObject);
    Response response = await registerWithHttpInfo(inlineObject);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
      //TODO - Sort out session cookie with David
    } else {
      return;
    }
  }
}
