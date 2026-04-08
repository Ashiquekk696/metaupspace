import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaupspace/core/theme/app_theme.dart';
import 'package:metaupspace/data/models/user_profile.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_event.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_state.dart';
import 'package:metaupspace/features/dashboard/widgets/dashboard_content.dart';
import 'package:metaupspace/features/dashboard/widgets/dashboard_skeleton.dart';
import 'package:metaupspace/shared/widgets/empty_state_view.dart';

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1B4B), AppColors.background],
            stops: [0.0, 0.35],
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<DashboardBloc, Object>(
            listener: (context, state) {
              if (state is DashboardError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is DashboardLoading || state is DashboardInitial) {
                return const DashboardSkeleton();
              }
              if (state is DashboardError) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: EmptyStateView(
                    title: 'We couldn’t load your dashboard',
                    message: state.message,
                    actionLabel: 'Retry',
                    onAction: () => context
                        .read<DashboardBloc>()
                        .add(DashboardRequested()),
                  ),
                );
              }
              if (state is DashboardEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: EmptyStateView(
                    title: 'No activity yet',
                    message: 'Your updates will appear here as they come in.',
                    actionLabel: 'Refresh',
                    onAction: () =>
                        context.read<DashboardBloc>().add(DashboardRefresh()),
                  ),
                );
              }
              if (state is DashboardReady) {
                return DashboardContent(
                  profile: profile,
                  bundle: state.bundle,
                  expandedKeys: state.expandedKeys,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

