# openapi.api.ServerApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://localhost/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**searchServer**](ServerApi.md#searchServer) | **GET** /server | Returns information about the server


# **searchServer**
> Server searchServer()

Returns information about the server

Returns information about the server like the version its on and amount of users on the server 

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = ServerApi();

try { 
    var result = api_instance.searchServer();
    print(result);
} catch (e) {
    print("Exception when calling ServerApi->searchServer: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Server**](Server.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

