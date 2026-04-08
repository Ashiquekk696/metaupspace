sealed class DashboardEvent {}

class DashboardRequested extends DashboardEvent {}

class DashboardRefresh extends DashboardEvent {}

class DashboardSectionToggled extends DashboardEvent {
  DashboardSectionToggled(this.sectionId);
  final String sectionId;
}
