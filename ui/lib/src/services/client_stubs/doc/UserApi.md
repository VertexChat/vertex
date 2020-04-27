# openapi.api.UserApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createUser**](UserApi.md#createUser) | **POST** /users | Create a User
[**deleteUser**](UserApi.md#deleteUser) | **DELETE** /users/{userId} | Delete a User
[**getUser**](UserApi.md#getUser) | **GET** /users/{userId} | Get a User
[**getUsers**](UserApi.md#getUsers) | **GET** /users | List All users
[**updateUser**](UserApi.md#updateUser) | **PUT** /users/{userId} | Update a User


# **createUser**
> createUser(user)

Create a User

Creates a new instance of a User.

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = UserApi();
var user = User(); // User | A new User to be created.

try { 
    api_instance.createUser(user);
} catch (e) {
    print("Exception when calling UserApi->createUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **user** | [**User**](User.md)| A new User to be created. | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteUser**
> deleteUser(userId)

Delete a User

Deletes an existing User.

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = UserApi();
var userId = userId_example; // String | A unique identifier for a User.

try { 
    api_instance.deleteUser(userId);
} catch (e) {
    print("Exception when calling UserApi->deleteUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**| A unique identifier for a User. | [default to null]

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUser**
> User getUser(userId)

Get a User

Gets the details of a single instance of a User.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = UserApi();
var userId = userId_example; // String | A unique identifier for a User.

try { 
    var result = api_instance.getUser(userId);
    print(result);
} catch (e) {
    print("Exception when calling UserApi->getUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**| A unique identifier for a User. | [default to null]

### Return type

[**User**](User.md)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUsers**
> List<User> getUsers()

List All users

Gets a list of all User entities.

### Example 
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: LoginRequired
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('LoginRequired').apiKeyPrefix = 'Bearer';

var api_instance = UserApi();

try { 
    var result = api_instance.getUsers();
    print(result);
} catch (e) {
    print("Exception when calling UserApi->getUsers: $e\n");
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<User>**](User.md)

### Authorization

[LoginRequired](../README.md#LoginRequired)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateUser**
> updateUser(userId, user)

Update a User

Updates an existing User.

### Example 
```dart
import 'package:openapi/api.dart';

var api_instance = UserApi();
var userId = userId_example; // String | A unique identifier for a User.
var user = User(); // User | Updated User information.

try { 
    api_instance.updateUser(userId, user);
} catch (e) {
    print("Exception when calling UserApi->updateUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**| A unique identifier for a User. | [default to null]
 **user** | [**User**](User.md)| Updated User information. | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

