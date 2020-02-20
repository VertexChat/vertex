# openapi.api.ChannelApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://localhost/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addChannel**](ChannelApi.md#addChannel) | **POST** /channels | Channel has been created
[**deleteChannelByID**](ChannelApi.md#deleteChannelByID) | **DELETE** /channels/{id} | Deletes an existing channel
[**getChannelByID**](ChannelApi.md#getChannelByID) | **GET** /channels/{id} | Get a channel by its ID
[**updateChannelByID**](ChannelApi.md#updateChannelByID) | **PUT** /channels/{id} | Updates an existing channel


# **addChannel**
> addChannel(channel)

Channel has been created

Channel has been created

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = ChannelApi();
var channel = Channel(); // Channel | The Channel to be created

try { 
    api_instance.addChannel(channel);
} catch (e) {
    print("Exception when calling ChannelApi->addChannel: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channel** | [**Channel**](Channel.md)| The Channel to be created | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteChannelByID**
> deleteChannelByID(id)

Deletes an existing channel

Deletes an existing channel

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = ChannelApi();
var id = 56; // int | The channel ID

try { 
    api_instance.deleteChannelByID(id);
} catch (e) {
    print("Exception when calling ChannelApi->deleteChannelByID: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| The channel ID | [default to null]

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChannelByID**
> Channel getChannelByID(id)

Get a channel by its ID

Returns a single Channel if it exists

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = ChannelApi();
var id = 56; // int | The channel ID

try { 
    var result = api_instance.getChannelByID(id);
    print(result);
} catch (e) {
    print("Exception when calling ChannelApi->getChannelByID: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| The channel ID | [default to null]

### Return type

[**Channel**](Channel.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateChannelByID**
> updateChannelByID(id, channel)

Updates an existing channel

Updates an existing channel

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = ChannelApi();
var id = 56; // int | The channel ID
var channel = Channel(); // Channel | Channel to be added

try { 
    api_instance.updateChannelByID(id, channel);
} catch (e) {
    print("Exception when calling ChannelApi->updateChannelByID: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| The channel ID | [default to null]
 **channel** | [**Channel**](Channel.md)| Channel to be added | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

