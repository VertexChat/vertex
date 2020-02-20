# openapi.model.User

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | [default to null]
**username** | **String** |  | [default to null]
**password** | **String** | In the case of user creation the password field will be the plaintext password in all other instances where the server returns a User object it will be a combination of the hash of the users password and associated salt | [default to null]
**displayName** | **String** |  | [default to null]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


