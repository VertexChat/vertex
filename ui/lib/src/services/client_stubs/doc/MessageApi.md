# openapi.api.MessageApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://localhost/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addMessage**](MessageApi.md#addMessage) | **POST** /messages | Message has been created
[**deleteMessageByID**](MessageApi.md#deleteMessageByID) | **DELETE** /messages/{id} | Deletes an existing message
[**getAllMessages**](MessageApi.md#getAllMessages) | **GET** /messages | Returns all messages
[**getMessageByID**](MessageApi.md#getMessageByID) | **GET** /messages/{id} | Get a message by its ID
[**updateMessageByID**](MessageApi.md#updateMessageByID) | **PUT** /messages/{id} | Updates an existing message


# **addMessage**
> addMessage(message)

Message has been created

Message has been created

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = MessageApi();
var message = Message(); // Message | Message to be added

try { 
    api_instance.addMessage(message);
} catch (e) {
    print("Exception when calling MessageApi->addMessage: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **message** | [**Message**](Message.md)| Message to be added | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteMessageByID**
> deleteMessageByID(id)

Deletes an existing message

Deletes an existing message

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = MessageApi();
var id = 56; // int | The message ID

try { 
    api_instance.deleteMessageByID(id);
} catch (e) {
    print("Exception when calling MessageApi->deleteMessageByID: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| The message ID | [default to null]

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllMessages**
> List<Message> getAllMessages()

Returns all messages

Returns all messages in a channel

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = MessageApi();

try { 
    var result = api_instance.getAllMessages();
    print(result);
} catch (e) {
    print("Exception when calling MessageApi->getAllMessages: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<Message>**](Message.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMessageByID**
> Message getMessageByID(id)

Get a message by its ID

Returns a single message if it exists

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = MessageApi();
var id = 56; // int | The message ID

try { 
    var result = api_instance.getMessageByID(id);
    print(result);
} catch (e) {
    print("Exception when calling MessageApi->getMessageByID: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| The message ID | [default to null]

### Return type

[**Message**](Message.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMessageByID**
> updateMessageByID(id, message)

Updates an existing message

Updates an existing message

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = MessageApi();
var id = 56; // int | The message ID
var message = Message(); // Message | Message to be added

try { 
    api_instance.updateMessageByID(id, message);
} catch (e) {
    print("Exception when calling MessageApi->updateMessageByID: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| The message ID | [default to null]
 **message** | [**Message**](Message.md)| Message to be added | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

