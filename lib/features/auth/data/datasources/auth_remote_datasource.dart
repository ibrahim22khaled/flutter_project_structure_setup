import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/user_model.dart';

/// LEARNING NOTES:
/// Responsible for: API calls and local storage.
/// NOT allowed to: contain business logic or UI.
/// 
/// PURPOSE: Handles remote backend interactions for auth-related data.
abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await apiClient.dio.post(
      ApiConstants.loginEndpoint,
      data: {
        'email': email,
        'password': password,
      },
    );

    // Assuming the backend returns the user object inside a "user" key.
    return UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
  }
}
