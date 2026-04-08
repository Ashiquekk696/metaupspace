import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaupspace/core/network/network_exception.dart';
import 'package:metaupspace/domain/repositories/employee_repository.dart';
import 'package:metaupspace/features/auth/bloc/login_event.dart';
import 'package:metaupspace/features/auth/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginAttempted, Object> {
  LoginBloc(this._repo) : super(LoginIdle()) {
    on<LoginAttempted>(_onAttempted);
  }

  final EmployeeRepository _repo;

  Future<void> _onAttempted(
    LoginAttempted event,
    Emitter<Object> emit,
  ) async {
    emit(LoginBusy());
    try {
      final profile = await _repo.signIn(
        email: event.email.trim(),
        password: event.password,
      );
      emit(LoginOk(profile));
    } on NetworkException catch (e) {
      emit(LoginBad(e.message));
    } catch (_) {
      emit(LoginBad('Something went wrong. Try again.'));
    }
  }
}
