import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/network/dio_client.dart';
import 'package:e_commerce_app/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:e_commerce_app/features/auth/data/models/user_model.dart';
import 'package:e_commerce_app/features/auth/domain/models/check_auth.dart';
import 'package:e_commerce_app/features/auth/domain/models/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/services/auth_service.dart';

class AuthServiceImpl implements AuthService {
  final DioClient _dioClient;
  final AuthLocalDataSource _localDataSource;

  AuthServiceImpl(this._dioClient, this._localDataSource);
  String auth = '/Auth';

  @override
  Future<UserEntity> login(String userName, String password) async {
    try {
      // Mock API call - replace with your actual endpoint
      final response = await _dioClient.post('/Auth/login',
        data: {
          'userName': userName,
          'password': password,
        },
      );
      final userModel = UserModel(
        id: response.data['id'],
        firstName: response.data['firstName'],
        lastName: response.data['lastName'],
        expiresIn: response.data['expiresIn'],
        refreshToken: response.data['refreshToken'],
        success: response.data['success'],
        errors: response.data['errors'],
        token: response.data['token'],
      );

      // Cache user locally
      await _localDataSource.cacheUser(userModel);

      return userModel;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<CheckAuth> checkAuth(String token, String userName) async {
    try {
      // Mock API call - replace with your actual endpoint
      final response = await _dioClient.post('$auth/check-auth',
        data: {
          'token': token,
          'userName': userName,
        },
      );
      final checkAuth = CheckAuth(
        isAuthenticated: response.data['isAuthenticated'],
      );

      return checkAuth;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserEntity> refresh(String token) async {
    try {
      final response = await _dioClient.post('$auth/refresh',
        data: { 'token': token },
      );
      final userModel = UserModel(
        id: response.data['id'],
        firstName: response.data['firstName'],
        lastName: response.data['lastName'],
        expiresIn: response.data['expiresIn'],
        refreshToken: response.data['refreshToken'],
        success: response.data['success'],
        errors: response.data['errors'],
        token: response.data['token'],
      );

      // Cache user locally
      await _localDataSource.clearCache();
      await _localDataSource.cacheUser(userModel);

      return userModel;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logout() async {
    await _localDataSource.clearCache();
  }

  @override
  Future<bool> isLoggedIn() async {
    final user = await _localDataSource.getCachedUser();
    return user != null;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return await _localDataSource.getCachedUser();
  }

  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return 'Invalid email or password';
        } else if (statusCode == 404) {
          return 'User not found';
        }
        return 'Server error: $statusCode';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      default:
        return 'Network error. Please check your connection.';
    }
  }

}