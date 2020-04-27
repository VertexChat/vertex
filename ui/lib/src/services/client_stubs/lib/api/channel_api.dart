part of openapi.api;

class ChannelApi {
  final ApiClient apiClient;

  ChannelApi([ApiClient apiClient]) : apiClient = apiClient ?? defaultApiClient;

  ///  with HTTP info returned
  ///
  ///
  Future addUserToChannelWithHttpInfo(int channelId, User user) async {
    Object postBody = user;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }
    if (user == null) {
      throw ApiException(400, "Missing required param: user");
    }

    // create path and map variables
    String path = "/channels/{channelId}/members"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString());

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

  ///
  ///
  ///
  Future addUserToChannel(int channelId, User user) async {
    Response response = await addUserToChannelWithHttpInfo(channelId, user);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }

  /// Create a Channel with HTTP info returned
  ///
  /// Creates a new instance of a Channel.
  Future createChannelWithHttpInfo(Channel channel) async {
    Object postBody = channel;

    // verify required params are set
    if (channel == null) {
      throw ApiException(400, "Missing required param: channel");
    }

    // create path and map variables
    String path = "/channels".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Create a Channel
  ///
  /// Creates a new instance of a Channel.
  Future createChannel(Channel channel) async {
    Response response = await createChannelWithHttpInfo(channel);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }

  /// Create a Message with HTTP info returned
  ///
  /// Creates a new instance of a Message.
  Future createMessageWithHttpInfo(int channelId, Message message) async {
    Object postBody = message;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }
    if (message == null) {
      throw ApiException(400, "Missing required param: message");
    }

    // create path and map variables
    String path = "/channels/{channelId}/messages"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'POST', queryParams,
        postBody, headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Create a Message
  ///
  /// Creates a new instance of a Message.
  Future createMessage(int channelId, Message message) async {
    Response response = await createMessageWithHttpInfo(channelId, message);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }

  /// Delete a Channel with HTTP info returned
  ///
  /// Deletes an existing Channel.
  Future deleteChannelWithHttpInfo(String channelId) async {
    Object postBody;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }

    // create path and map variables
    String path = "/channels/{channelId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'DELETE', queryParams,
        postBody, headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Delete a Channel
  ///
  /// Deletes an existing Channel.
  Future deleteChannel(String channelId) async {
    Response response = await deleteChannelWithHttpInfo(channelId);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }

  /// Delete a Message with HTTP info returned
  ///
  /// Deletes an existing Message.
  Future deleteMessageWithHttpInfo(String channelId, int messageId) async {
    Object postBody;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }
    if (messageId == null) {
      throw ApiException(400, "Missing required param: messageId");
    }

    // create path and map variables
    String path = "/channels/{channelId}/messages/{messageId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString())
        .replaceAll("{" + "messageId" + "}", messageId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'DELETE', queryParams,
        postBody, headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Delete a Message
  ///
  /// Deletes an existing Message.
  Future deleteMessage(String channelId, int messageId) async {
    Response response = await deleteMessageWithHttpInfo(channelId, messageId);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }

  /// Get a Channel with HTTP info returned
  ///
  /// Gets the details of a single instance of a Channel.
  Future<Response> getChannelWithHttpInfo(String channelId) async {
    Object postBody;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }

    // create path and map variables
    String path = "/channels/{channelId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Get a Channel
  ///
  /// Gets the details of a single instance of a Channel.
  Future<Channel> getChannel(String channelId) async {
    Response response = await getChannelWithHttpInfo(channelId);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Channel')
          as Channel;
    } else {
      return null;
    }
  }

  /// List All members with HTTP info returned
  ///
  /// Gets a list of all Users in a given Channel.
  Future<Response> getChannelMembersWithHttpInfo(int channelId) async {
    Object postBody;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }

    // create path and map variables
    String path = "/channels/{channelId}/members"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);
    return response;
  }

  /// List All members
  ///
  /// Gets a list of all Users in a given Channel.
  Future<List<User>> getChannelMembers(int channelId) async {
    Response response = await getChannelMembersWithHttpInfo(channelId);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<User>')
              as List)
          .map((item) => item as User)
          .toList();
    } else {
      return null;
    }
  }

  /// List All channels with HTTP info returned
  ///
  /// Gets a list of all Channel entities.
  Future<Response> getChannelsWithHttpInfo() async {
    Object postBody;

    // TODO Configure Session id for authorization: LoginRequired
   // defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey =
//        'session_id=hello';

    // create path and map variables
    String path = "/channels".replaceAll("{format}", "json");

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};
//    headerParams["Access-Control-Allow-Origin"] = "";
//    headerParams["Access-Control-Allow-Methods"] = "POST,GET,DELETE,PUT,OPTIONS";
//    headerParams["Access-Control-Allow-Credentials"] = "true";
    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);
    return response;
  }

  /// List All channels
  ///
  /// Gets a list of all Channel entities.
  Future<List<Channel>> getChannels() async {
    Response response = await getChannelsWithHttpInfo();

    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<Channel>')
              as List)
          .map((item) => item as Channel)
          .toList();
    } else {
      return null;
    }
  }

  /// Get a Message with HTTP info returned
  ///
  /// Gets the details of a single instance of a Message.
  Future<Response> getMessageWithHttpInfo(
      String channelId, int messageId) async {
    Object postBody;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }
    if (messageId == null) {
      throw ApiException(400, "Missing required param: messageId");
    }

    // create path and map variables
    String path = "/channels/{channelId}/messages/{messageId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString())
        .replaceAll("{" + "messageId" + "}", messageId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Get a Message
  ///
  /// Gets the details of a single instance of a Message.
  Future<Message> getMessage(String channelId, int messageId) async {
    Response response = await getMessageWithHttpInfo(channelId, messageId);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
      return apiClient.deserialize(_decodeBodyBytes(response), 'Message')
          as Message;
    } else {
      return null;
    }
  }

  /// List All messages with HTTP info returned
  ///
  /// Gets a list of all Message entities.
  Future<Response> getMessagesWithHttpInfo(int channelId) async {
    Object postBody;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }

    // create path and map variables
    String path = "/channels/{channelId}/messages"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'GET', queryParams, postBody,
        headerParams, formParams, contentType, authNames);
    return response;
  }

  /// List All messages
  ///
  /// Gets a list of all Message entities.
  Future<List<Message>> getMessages(int channelId) async {
    Response response = await getMessagesWithHttpInfo(channelId);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
      return (apiClient.deserialize(_decodeBodyBytes(response), 'List<Message>')
              as List)
          .map((item) => item as Message)
          .toList();
    } else {
      return null;
    }
  }

  /// Remove as User with HTTP info returned
  ///
  /// Removes a User for a Channel
  Future removeChannelMemberWithHttpInfo(int channelId, int userId) async {
    Object postBody;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }
    if (userId == null) {
      throw ApiException(400, "Missing required param: userId");
    }

    // create path and map variables
    String path = "/channels/{channelId}/members/{userId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString())
        .replaceAll("{" + "userId" + "}", userId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = [];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'DELETE', queryParams,
        postBody, headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Remove as User
  ///
  /// Removes a User for a Channel
  Future removeChannelMember(int channelId, int userId) async {
    Response response =
        await removeChannelMemberWithHttpInfo(channelId, userId);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }

  /// Update a Channel with HTTP info returned
  ///
  /// Updates an existing Channel.
  Future updateChannelWithHttpInfo(String channelId, Channel channel) async {
    Object postBody = channel;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }
    if (channel == null) {
      throw ApiException(400, "Missing required param: channel");
    }

    // create path and map variables
    String path = "/channels/{channelId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'PUT', queryParams, postBody,
        headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Update a Channel
  ///
  /// Updates an existing Channel.
  Future updateChannel(String channelId, Channel channel) async {
    Response response = await updateChannelWithHttpInfo(channelId, channel);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }

  /// Update a Message with HTTP info returned
  ///
  /// Updates an existing Message.
  Future updateMessageWithHttpInfo(
      String channelId, int messageId, Message message) async {
    Object postBody = message;

    // verify required params are set
    if (channelId == null) {
      throw ApiException(400, "Missing required param: channelId");
    }
    if (messageId == null) {
      throw ApiException(400, "Missing required param: messageId");
    }
    if (message == null) {
      throw ApiException(400, "Missing required param: message");
    }

    // create path and map variables
    String path = "/channels/{channelId}/messages/{messageId}"
        .replaceAll("{format}", "json")
        .replaceAll("{" + "channelId" + "}", channelId.toString())
        .replaceAll("{" + "messageId" + "}", messageId.toString());

    // query params
    List<QueryParam> queryParams = [];
    Map<String, String> headerParams = {};
    Map<String, String> formParams = {};

    List<String> contentTypes = ["application/json"];

    String contentType =
        contentTypes.isNotEmpty ? contentTypes[0] : "application/json";
    List<String> authNames = ["LoginRequired"];

    if (contentType.startsWith("multipart/form-data")) {
      bool hasFields = false;
      MultipartRequest mp = MultipartRequest(null, null);
      if (hasFields) postBody = mp;
    } else {}

    var response = await apiClient.invokeAPI(path, 'PUT', queryParams, postBody,
        headerParams, formParams, contentType, authNames);
    return response;
  }

  /// Update a Message
  ///
  /// Updates an existing Message.
  Future updateMessage(String channelId, int messageId, Message message) async {
    Response response =
        await updateMessageWithHttpInfo(channelId, messageId, message);
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, _decodeBodyBytes(response));
    } else if (response.body != null) {
    } else {
      return;
    }
  }
}
