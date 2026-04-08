import 'package:get_it/get_it.dart';
import 'package:metaupspace/core/network/http_portal.dart';
import 'package:metaupspace/data/repositories/employee_repository_impl.dart';
import 'package:metaupspace/domain/repositories/employee_repository.dart';
import 'package:metaupspace/features/auth/bloc/login_bloc.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  if (!getIt.isRegistered<HttpPortal>()) {
    getIt.registerLazySingleton<HttpPortal>(() => HttpPortal());
  }
  if (!getIt.isRegistered<EmployeeRepository>()) {
    getIt.registerLazySingleton<EmployeeRepository>(
      () => EmployeeRepositoryImpl(getIt<HttpPortal>()),
    );
  }
  if (!getIt.isRegistered<LoginBloc>()) {
    getIt.registerFactory<LoginBloc>(
      () => LoginBloc(getIt<EmployeeRepository>()),
    );
  }
  if (!getIt.isRegistered<DashboardBloc>()) {
    getIt.registerFactory<DashboardBloc>(
      () => DashboardBloc(getIt<EmployeeRepository>()),
    );
  }
}

