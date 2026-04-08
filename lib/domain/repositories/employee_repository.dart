import 'package:metaupspace/data/models/dashboard_bundle.dart';
import 'package:metaupspace/data/models/user_profile.dart';

abstract class EmployeeRepository {
  Future<UserProfile> signIn({required String email, required String password});
  Future<DashboardBundle> fetchDashboard();
}

