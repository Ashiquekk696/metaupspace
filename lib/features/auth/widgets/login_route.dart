import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaupspace/core/di/service_locator.dart';
import 'package:metaupspace/features/auth/bloc/login_bloc.dart';
import 'package:metaupspace/features/auth/widgets/login_view.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: const LoginView(),
    );
  }
}

