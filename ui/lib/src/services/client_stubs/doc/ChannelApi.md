# openapi.api.ChannelApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addUserToChannel**](ChannelApi.md#addUserToChannel) | **POST** /channels/{channelId}/members | 
[**createChannel**](ChannelApi.md#createChannel) | **POST** /channels | Create a Channel
[**createMessage**](ChannelApi.md#createMessage) | **POST** /channels/{channelId}/messages | Create a Message
[**deleteChannel**](ChannelApi.md#deleteChannel) | **DELETE** /channels/{channelId} | Delete a Channel
[**deleteMessage**](ChannelApi.md#deleteMessage) | **DELETE** /channels/{channelId}/messages/{messageId} | Delete a Message
[**getChannel**](ChannelApi.md#getChannel) | **GET** /channels/{channelId} | Get a Channel
[**getChannelMembers**](ChannelApi.md#getChannelMembers) | **GET** /channels/{channelId}/members | List All members
[**getChannels**](ChannelApi.md#getChannels) | **GET** /channels | List All channels
[**getMessage**](ChannelApi.md#getMessage) | **GET** /channels/{channelId}/messages/{messageId} | Get a Message
[**getMessages**](ChannelApi.md#getMessages) | **GET** /channels/{channelId}/messages | List All messages
[**removeChannelMember**](ChannelApi.md#removeChannelMember) | **DELETE** /channels/{channelId}/members/{userId} | Remove as User
[**updateChannel**](ChannelApi.md#updateChannel) | **PUT** /channels/{channelId} | Update a Channel
[**updateMessage**](ChannelApi.md#updateMessage) | **PUT** /channels/{channelId}/messages/{messageId} | Update a Message


# **addUserToChannel**
> addUserToChannel(channelId, user)



### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = ChannelApi();
var channelId = 56; // int | 
var user = User(); // User | 

try { 
    api_instance.addUserToChannel(channelId, user);
} catch (e) {
    print("Exception when calling ChannelApi->addUserToChannel: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **int**|  | [default to null]
 **user** | [**User**](User.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createChannel**
> createChannel(channel)

Create a Channel

Creates a new instance of a Channel.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channel = Channel(); // Channel | A new Channel to be created.

try { 
    api_instance.createChannel(channel);
} catch (e) {
    print("Exception when calling ChannelApi->createChannel: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channel** | [**Channel**](Channel.md)| A new Channel to be created. | 

### Return type

void (empty response body)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createMessage**
> createMessage(channelId, message)

Create a Message

Creates a new instance of a Message.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channelId = 56; // int | 
var message = Message(); // Message | A new Message to be created.

try { 
    api_instance.createMessage(channelId, message);
} catch (e) {
    print("Exception when calling ChannelApi->createMessage: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **int**|  | [default to null]
 **message** | [**Message**](Message.md)| A new Message to be created. | 

### Return type

void (empty response body)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteChannel**
> deleteChannel(channelId)

Delete a Channel

Deletes an existing Channel.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channelId = channelId_example; // String | A unique identifier for a Channel.

try { 
    api_instance.deleteChannel(channelId);
} catch (e) {
    print("Exception when calling ChannelApi->deleteChannel: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **String**| A unique identifier for a Channel. | [default to null]

### Return type

void (empty response body)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteMessage**
> deleteMessage(channelId, messageId)

Delete a Message

Deletes an existing Message.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channelId = channelId_example; // String | A unique identifier for a Message.
var messageId = 56; // int | 

try { 
    api_instance.deleteMessage(channelId, messageId);
} catch (e) {
    print("Exception when calling ChannelApi->deleteMessage: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **String**| A unique identifier for a Message. | [default to null]
 **messageId** | **int**|  | [default to null]

### Return type

void (empty response body)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChannel**
> Channel getChannel(channelId)

Get a Channel

Gets the details of a single instance of a Channel.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channelId = channelId_example; // String | A unique identifier for a Channel.

try { 
    var result = api_instance.getChannel(channelId);
    print(result);
} catch (e) {
    print("Exception when calling ChannelApi->getChannel: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **String**| A unique identifier for a Channel. | [default to null]

### Return type

[**Channel**](Channel.md)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChannelMembers**
> List<User> getChannelMembers(channelId)

List All members

Gets a list of all Users in a given Channel.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channelId = 56; // int | 

try { 
    var result = api_instance.getChannelMembers(channelId);
    print(result);
} catch (e) {
    print("Exception when calling ChannelApi->getChannelMembers: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **int**|  | [default to null]

### Return type

[**List<User>**](User.md)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChannels**
> List<Channel> getChannels()

List All channels

Gets a list of all Channel entities.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();

try { 
    var result = api_instance.getChannels();
    print(result);
} catch (e) {
    print("Exception when calling ChannelApi->getChannels: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<Channel>**](Channel.md)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessage**
> Message getMessage(channelId, messageId)

Get a Message

Gets the details of a single instance of a Message.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channelId = channelId_example; // String | A unique identifier for a Message.
var messageId = 56; // int | 

try { 
    var result = api_instance.getMessage(channelId, messageId);
    print(result);
} catch (e) {
    print("Exception when calling ChannelApi->getMessage: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **String**| A unique identifier for a Message. | [default to null]
 **messageId** | **int**|  | [default to null]

### Return type

[**Message**](Message.md)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessages**
> List<Message> getMessages(channelId)

List All messages

Gets a list of all Message entities.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channelId = 56; // int | 

try { 
    var result = api_instance.getMessages(channelId);
    print(result);
} catch (e) {
    print("Exception when calling ChannelApi->getMessages: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **int**|  | [default to null]

### Return type

[**List<Message>**](Message.md)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeChannelMember**
> removeChannelMember(channelId, userId)

Remove as User

Removes a User for a Channel

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channelId = 56; // int | 
var userId = 56; // int | 

try { 
    api_instance.removeChannelMember(channelId, userId);
} catch (e) {
    print("Exception when calling ChannelApi->removeChannelMember: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **int**|  | [default to null]
 **userId** | **int**|  | [default to null]

### Return type

void (empty response body)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateChannel**
> updateChannel(channelId, channel)

Update a Channel

Updates an existing Channel.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channelId = channelId_example; // String | A unique identifier for a Channel.
var channel = Channel(); // Channel | Updated Channel information.

try { 
    api_instance.updateChannel(channelId, channel);
} catch (e) {
    print("Exception when calling ChannelApi->updateChannel: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **String**| A unique identifier for a Channel. | [default to null]
 **channel** | [**Channel**](Channel.md)| Updated Channel information. | 

### Return type

void (empty response body)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMessage**
> updateMessage(channelId, messageId, message)

Update a Message

Updates an existing Message.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = ChannelApi();
var channelId = channelId_example; // String | A unique identifier for a Message.
var messageId = 56; // int | 
var message = Message(); // Message | Updated Message information.

try { 
    api_instance.updateMessage(channelId, messageId, message);
} catch (e) {
    print("Exception when calling ChannelApi->updateMessage: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channelId** | **String**| A unique identifier for a Message. | [default to null]
 **messageId** | **int**|  | [default to null]
 **message** | [**Message**](Message.md)| Updated Message information. | 

### Return type

void (empty response body)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

