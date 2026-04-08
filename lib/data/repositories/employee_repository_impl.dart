import 'package:dio/dio.dart';
import 'package:metaupspace/core/network/http_portal.dart';
import 'package:metaupspace/core/network/network_exception.dart';
import 'package:metaupspace/data/models/dashboard_bundle.dart';
import 'package:metaupspace/data/models/user_profile.dart';
import 'package:metaupspace/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl(this._portal);

  final HttpPortal _portal;

  @override
  Future<UserProfile> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _portal.client.post<dynamic>(
        '/auth/login',
        data: <String, dynamic>{'email': email, 'password': password},
      );
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw NetworkException('Unexpected response');
      }
      final userRaw = data['user'];
      if (userRaw is! Map<String, dynamic>) {
        throw NetworkException('Profile missing');
      }
      return UserProfile.fromJson(userRaw);
    } on DioException catch (e) {
      final message = e.error is String
          ? e.error as String
          : e.message ?? 'Sign-in failed';
      throw NetworkException(message);
    }
  }

  @override
  Future<DashboardBundle> fetchDashboard() async {
    try {
      final response = await _portal.client.get<dynamic>('/dashboard/summary');
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw NetworkException('Unexpected response');
      }
      return DashboardBundle.fromJson(data);
    } on DioException catch (e) {
      final message = e.error is String
          ? e.error as String
          : e.message ?? 'Could not load dashboard';
      throw NetworkException(message);
    }
  }
}

