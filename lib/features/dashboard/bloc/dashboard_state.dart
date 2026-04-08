import 'package:metaupspace/data/models/dashboard_bundle.dart';

class DashboardInitial {}

class DashboardLoading {}

class DashboardReady {
  DashboardReady({required this.bundle, required this.expandedKeys});
  final DashboardBundle bundle;
  final Set<String> expandedKeys;
}

class DashboardError {
  DashboardError(this.message);
  final String message;
}

class DashboardEmpty {}
