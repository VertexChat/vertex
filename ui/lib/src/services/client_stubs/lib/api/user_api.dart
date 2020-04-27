part of openapi.api;



class UserApi {
  final ApiClient apiClient;

  UserApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  /// Create a User with HTTP info returned
  ///
  /// Creates a new instance of a User.
  Future createUserWithHttpInfo(User user) async {
    Object postBody = user;

    // verify required params are set
    if(user == null) {
     throw ApiException(400, "Missing required param: user");
    }

    // create path and map variables
    String path = "/users".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'POST',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// Create a User
  ///
  /// Creates a new instance of a User.
  Future createUser(User user) async {
    Response response = await createUserWithHttpInfo(user);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

  /// Delete a User with HTTP info returned
  ///
  /// Deletes an existing User.
  Future deleteUserWithHttpInfo(String userId) async {
    Object postBody;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/users/{userId}".replaceAll("{format}","json").replaceAll("{" + "userId" + "}", userId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'DELETE',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// Delete a User
  ///
  /// Deletes an existing User.
  Future deleteUser(String userId) async {
    Response response = await deleteUserWithHttpInfo(userId);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

  /// Get a User with HTTP info returned
  ///
  /// Gets the details of a single instance of a User.
  Future<Response> getUserWithHttpInfo(String userId) async {
    Object postBody;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/users/{userId}".replaceAll("{format}","json").replaceAll("{" + "userId" + "}", userId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// Get a User
  ///
  /// Gets the details of a single instance of a User.
  Future<User> getUser(String userId) async {
    Response response = await getUserWithHttpInfo(userId);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'User') as User;
    } else {
      return null;
    }
  }

  /// List All users with HTTP info returned
  ///
  /// Gets a list of all User entities.
  Future<Response> getUsersWithHttpInfo() async {
    Object postBody;

    // verify required params are set

    // create path and map variables
    String path = "/users".replaceAll("{format}","json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'GET',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// List All users
  ///
  /// Gets a list of all User entities.
  Future<List<User>> getUsers() async {
    Response response = await getUsersWithHttpInfo();
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<User>') as List).map((item) => item as User).toList();
    } else {
      return null;
    }
  }

  /// Update a User with HTTP info returned
  ///
  /// Updates an existing User.
  Future updateUserWithHttpInfo(String userId, User user) async {
    Object postBody = user;

    // verify required params are set
    if(userId == null) {
     throw ApiException(400, "Missing required param: userId");
    }
    if(user == null) {
     throw ApiException(400, "Missing required param: user");
    }

    // create path and map variables
    String path = "/users/{userId}".replaceAll("{format}","json").replaceAll("{" + "userId" + "}", userId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType = contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = [];

    if(contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if(hasFields)
        postBody = mp;
    }
    else {
    }

    var response = await apiClient.invokeAPI(path,
                                             'PUT',
                                             queryParams,
                                             postBody,
                                             headerParams,
                                             formParams,
                                             contentType,
                                             authNames);
    return response;
  }

  /// Update a User
  ///
  /// Updates an existing User.
  Future updateUser(String userId, User user) async {
    Response response = await updateUserWithHttpInfo(userId, user);
    if(response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if(response.body != null) {
    } else {
      return;
    }
  }

}
