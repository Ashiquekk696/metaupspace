import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaupspace/core/di/service_locator.dart';
import 'package:metaupspace/data/models/user_profile.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_event.dart';
import 'package:metaupspace/features/dashboard/widgets/dashboard_scaffold.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<DashboardBloc>()..add(DashboardRequested()),
      child: DashboardScaffold(profile: profile),
    );
  }
}
