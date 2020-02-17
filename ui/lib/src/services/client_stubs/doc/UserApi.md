# openapi.api.UserApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *https://localhost/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addUser**](UserApi.md#addUser) | **POST** /users | User has been created
[**deleteUserByID**](UserApi.md#deleteUserByID) | **DELETE** /users/{id} | Deletes an existing User
[**getUserByID**](UserApi.md#getUserByID) | **GET** /users/{id} | Returns a single User if it exists
[**updateUserByID**](UserApi.md#updateUserByID) | **PUT** /users/{id} | Updates an existing User


# **addUser**
> addUser(user)

User has been created

User has been created

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = UserApi();
var user = User(); // User | User to be added

try { 
    api_instance.addUser(user);
} catch (e) {
    print("Exception when calling UserApi->addUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **user** | [**User**](User.md)| User to be added | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUserByID**
> deleteUserByID(id)

Deletes an existing User

Deletes a user from the database

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = UserApi();
var id = 56; // int | The User ID

try { 
    api_instance.deleteUserByID(id);
} catch (e) {
    print("Exception when calling UserApi->deleteUserByID: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| The User ID | [default to null]

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserByID**
> User getUserByID(id)

Returns a single User if it exists

Returns a single User if it exists

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = UserApi();
var id = 56; // int | The User ID

try { 
    var result = api_instance.getUserByID(id);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->getUserByID: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| The User ID | [default to null]

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUserByID**
> updateUserByID(id, user)

Updates an existing User

Updates an existing User

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = UserApi();
var id = 56; // int | The User ID
var user = User(); // User | User entity to be created

try { 
    api_instance.updateUserByID(id, user);
} catch (e) {
    print("Exception when calling UserApi->updateUserByID: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**| The User ID | [default to null]
 **user** | [**User**](User.md)| User entity to be created | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

