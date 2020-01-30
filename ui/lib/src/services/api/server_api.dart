part of openapi.api;

class ServerApi {
  final ApiClient apiClient;

  ServerApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Returns information about the server with HTTP info returned
  ///
  /// Returns information about the server like the version its on and amount of users on the server
  Future<Response> searchServerWithHttpInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/server".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Returns information about the server
  ///
  /// Returns information about the server like the version its on and amount of users on the server
  Future<Server> searchServer() async {
    Response response = await searchServerWithHttpInfo();
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Server')
          as Server;
    } else {
      return null;
    }
  }
}
