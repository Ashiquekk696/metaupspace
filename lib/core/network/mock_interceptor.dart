import 'package:dio/dio.dart';

class MockInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 550));
    final path = options.path;
    if (path.endsWith('/auth/login')) {
      final body = options.data;
      if (body is! Map) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            error: 'Invalid payload',
          ),
        );
      }
      final email = body['email'] as String? ?? '';
      final password = body['password'] as String? ?? '';
      if (email.isEmpty || password.isEmpty) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            error: 'Email and password are required',
          ),
        );
      }
      final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            error: 'Enter a valid email address',
          ),
        );
      }
      return handler.resolve(
        Response<dynamic>(
          requestOptions: options,
          statusCode: 200,
          data: <String, dynamic>{
            'user': <String, dynamic>{
              'id': 'usr_01',
              'name': 'Alex Rivera',
              'email': email,
              'role': 'Product Designer',
              'avatarUrl':
                  'https://api.dicebear.com/7.x/avataaars/png?seed=${Uri.encodeComponent(email)}',
            },
            'token': 'mock_jwt_${email.hashCode}',
          },
        ),
      );
    }
    if (path.endsWith('/dashboard/summary')) {
      return handler.resolve(
        Response<dynamic>(
          requestOptions: options,
          statusCode: 200,
          data: <String, dynamic>{
            'stats': <String, dynamic>{
              'attendanceDays': 21,
              'leaveBalance': 12,
              'pendingRequests': 3,
            },
            'leaves': <Map<String, dynamic>>[
              <String, dynamic>{
                'id': 'lv_1',
                'type': 'Annual',
                'range': 'Mar 12 – Mar 14',
                'status': 'Approved',
                'days': 3,
              },
              <String, dynamic>{
                'id': 'lv_2',
                'type': 'Sick',
                'range': 'Feb 02',
                'status': 'Approved',
                'days': 1,
              },
              <String, dynamic>{
                'id': 'lv_3',
                'type': 'Work from home',
                'range': 'Apr 01 – Apr 05',
                'status': 'Pending',
                'days': 5,
              },
            ],
            'attendance': <Map<String, dynamic>>[
              <String, dynamic>{
                'id': 'at_1',
                'date': 'Apr 07, 2026',
                'checkIn': '09:02',
                'checkOut': '18:14',
                'hours': '9h 12m',
                'status': 'Present',
              },
              <String, dynamic>{
                'id': 'at_2',
                'date': 'Apr 06, 2026',
                'checkIn': '08:55',
                'checkOut': '17:48',
                'hours': '8h 53m',
                'status': 'Present',
              },
              <String, dynamic>{
                'id': 'at_3',
                'date': 'Apr 05, 2026',
                'checkIn': '—',
                'checkOut': '—',
                'hours': '—',
                'status': 'Remote',
              },
            ],
            'holidays': <Map<String, dynamic>>[
              <String, dynamic>{
                'id': 'hd_1',
                'title': 'Spring company offsite',
                'date': 'Apr 18, 2026',
                'note': 'All offices closed',
              },
              <String, dynamic>{
                'id': 'hd_2',
                'title': 'Regional holiday',
                'date': 'May 01, 2026',
                'note': 'Paid holiday',
              },
              <String, dynamic>{
                'id': 'hd_3',
                'title': 'Wellness Friday',
                'date': 'May 16, 2026',
                'note': 'Optional half-day',
              },
            ],
          },
        ),
      );
    }
    return handler.reject(
      DioException(
        requestOptions: options,
        type: DioExceptionType.unknown,
        error: 'Unknown route',
      ),
    );
  }
}
