import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaupspace/core/network/network_exception.dart';
import 'package:metaupspace/domain/repositories/employee_repository.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_event.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, Object> {
  DashboardBloc(this._repo) : super(DashboardInitial()) {
    on<DashboardRequested>(_onRequested);
    on<DashboardRefresh>(_onRefresh);
    on<DashboardSectionToggled>(_onSectionToggled);
  }

  final EmployeeRepository _repo;

  Future<void> _onRequested(
    DashboardRequested event,
    Emitter<Object> emit,
  ) async {
    emit(DashboardLoading());
    await _load(emit);
  }

  Future<void> _onRefresh(
    DashboardRefresh event,
    Emitter<Object> emit,
  ) async {
    final current = state;
    await _load(
      emit,
      preserveExpansion:
          current is DashboardReady ? current.expandedKeys : <String>{},
    );
  }

  Future<void> _onSectionToggled(
    DashboardSectionToggled event,
    Emitter<Object> emit,
  ) async {
    final current = state;
    if (current is! DashboardReady) return;
    final next = Set<String>.from(current.expandedKeys);
    if (next.contains(event.sectionId)) {
      next.remove(event.sectionId);
    } else {
      next.add(event.sectionId);
    }
    emit(
      DashboardReady(
        bundle: current.bundle,
        expandedKeys: next,
      ),
    );
  }

  Future<void> _load(
    Emitter<Object> emit, {
    Set<String> preserveExpansion = const <String>{},
  }) async {
    try {
      final bundle = await _repo.fetchDashboard();
      final hasContent = bundle.leaves.isNotEmpty ||
          bundle.attendance.isNotEmpty ||
          bundle.holidays.isNotEmpty;
      if (!hasContent &&
          bundle.stats.attendanceDays == 0 &&
          bundle.stats.leaveBalance == 0 &&
          bundle.stats.pendingRequests == 0) {
        emit(DashboardEmpty());
        return;
      }
      emit(
        DashboardReady(
          bundle: bundle,
          expandedKeys: preserveExpansion,
        ),
      );
    } on NetworkException catch (e) {
      emit(DashboardError(e.message));
    } catch (_) {
      emit(DashboardError('Unable to refresh. Check your connection.'));
    }
  }
}
