# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://localhost/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**login**](AuthApi.md#login) | **POST** /login | Allows a user that is registered to login
[**register**](AuthApi.md#register) | **POST** /register | Allows a user register a new account


# **login**
> login(login)

Allows a user that is registered to login

Allows a user that is register to login to the applcation

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = AuthApi();
var login = Login(); // Login | User to be authenticated

try { 
    api_instance.login(login);
} catch (e) {
    print("Exception when calling AuthApi->login: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **login** | [**Login**](Login.md)| User to be authenticated | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **register**
> register(user)

Allows a user register a new account

Allow a user register a new account with the server

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = AuthApi();
var user = User(); // User | User to be registered

try { 
    api_instance.register(user);
} catch (e) {
    print("Exception when calling AuthApi->register: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **user** | [**User**](User.md)| User to be registered | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

