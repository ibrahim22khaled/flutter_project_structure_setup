import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

/// LEARNING NOTES:
/// Responsible for: API calls and local storage.
/// NOT allowed to: contain business logic or UI.
///
/// PURPOSE: Organizes remote and local data operations into a single repository layer.
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    // We check the internet BEFORE any remote call.
    // Why here?
    // This check belongs in the repository because the repository coordinates
    // WHERE the data comes from (remote vs local). The Cubit shouldn't care
    // about network state, and the datasource should just do its raw API call.
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final userModel = await remoteDataSource.login(email, password);
      // Hardcoded token extraction logic depends on API response.
      // E.g., if login returned a separate token field.
      // await localDataSource.cacheToken('fake_jwt_token_for_example');

      return Right(
        User(
          id: userModel.id,
          email: userModel.email,
          name: userModel.name,
        ),
      );
    } on DioException catch (e) {
      return Left(FailureHandler.handleDioException(e));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearToken();
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to clear local token.'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCachedUser() async {
    try {
      final token = await localDataSource.getCachedToken();
      if (token != null) {
        // You would typically decode the JWT or fetch the user profile here.
        return const Right(
          User(
            id: 1,
            email: 'cached@example.com',
            name: 'Cached User',
          ),
        );
      }
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to load cached token.'));
    }
  }
}
