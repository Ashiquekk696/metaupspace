import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaupspace/core/theme/app_theme.dart';
import 'package:metaupspace/core/ui/screen.dart';
import 'package:metaupspace/data/models/dashboard_bundle.dart';
import 'package:metaupspace/data/models/user_profile.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_event.dart';
import 'package:metaupspace/features/dashboard/bloc/dashboard_state.dart';
import 'package:metaupspace/features/dashboard/widgets/hero_header.dart';
import 'package:metaupspace/features/dashboard/widgets/insight_rows.dart';
import 'package:metaupspace/shared/widgets/expandable_insight_card.dart';
import 'package:metaupspace/shared/widgets/stat_card.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({
    super.key,
    required this.profile,
    required this.bundle,
    required this.expandedKeys,
  });

  final UserProfile profile;
  final DashboardBundle bundle;
  final Set<String> expandedKeys;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.accent,
      backgroundColor: AppColors.surface,
      onRefresh: () async {
        context.read<DashboardBloc>().add(DashboardRefresh());
        await context.read<DashboardBloc>().stream.firstWhere(
              (s) => s is DashboardReady || s is DashboardError,
            );
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: HeroHeader(profile: profile)),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(Screen.of(context).gutter(), 8,
                Screen.of(context).gutter(), 12),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (context, c) {
                  final cols = Screen.of(context).statsColumns();
                  final stats = [
                    StatCard(
                      label: 'Attendance days',
                      value: '${bundle.stats.attendanceDays}',
                      icon: Icons.event_available_rounded,
                      accent: AppColors.accent,
                    ),
                    StatCard(
                      label: 'Leave balance',
                      value: '${bundle.stats.leaveBalance}',
                      icon: Icons.beach_access_rounded,
                      accent: AppColors.success,
                    ),
                    StatCard(
                      label: 'Open requests',
                      value: '${bundle.stats.pendingRequests}',
                      icon: Icons.mark_email_unread_rounded,
                      accent: AppColors.warning,
                    ),
                  ];
                  if (cols == 1) {
                    return Column(
                      children: [
                        for (var i = 0; i < stats.length; i++) ...[
                          if (i > 0) const SizedBox(height: 12),
                          stats[i],
                        ],
                      ],
                    );
                  }
                  final childAspectRatio = cols == 2 ? 2.15 : 1.15;
                  return GridView.count(
                    crossAxisCount: cols,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: childAspectRatio,
                    children: stats,
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              Screen.of(context).gutter(),
              4,
              Screen.of(context).gutter(),
              12,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                'People operations',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Screen.of(context).gutter()),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ExpandableInsightCard(
                    title: 'Leave ledger',
                    subtitle:
                        '${bundle.leaves.length} records · tap to expand',
                    expanded: expandedKeys.contains('leaves'),
                    onToggle: () => context
                        .read<DashboardBloc>()
                        .add(DashboardSectionToggled('leaves')),
                    leading: LeadingOrb(
                      icon: Icons.flight_takeoff_rounded,
                      color: AppColors.primarySoft,
                    ),
                    child: bundle.leaves.isEmpty
                        ? inlineEmpty('No leave requests yet')
                        : Column(
                            children: bundle.leaves
                                .map((e) => LeaveRow(item: e))
                                .toList(),
                          ),
                  ),
                  const SizedBox(height: 12),
                  ExpandableInsightCard(
                    title: 'Attendance trail',
                    subtitle: 'Recent check-ins and hours',
                    expanded: expandedKeys.contains('attendance'),
                    onToggle: () => context
                        .read<DashboardBloc>()
                        .add(DashboardSectionToggled('attendance')),
                    leading: LeadingOrb(
                      icon: Icons.schedule_rounded,
                      color: AppColors.accent,
                    ),
                    child: bundle.attendance.isEmpty
                        ? inlineEmpty('No attendance records yet')
                        : Column(
                            children: bundle.attendance
                                .map((e) => AttendanceRow(item: e))
                                .toList(),
                          ),
                  ),
                  const SizedBox(height: 12),
                  ExpandableInsightCard(
                    title: 'Upcoming holidays',
                    subtitle: 'Plan around shared time off',
                    expanded: expandedKeys.contains('holidays'),
                    onToggle: () => context
                        .read<DashboardBloc>()
                        .add(DashboardSectionToggled('holidays')),
                    leading: LeadingOrb(
                      icon: Icons.celebration_rounded,
                      color: AppColors.warning,
                    ),
                    child: bundle.holidays.isEmpty
                        ? inlineEmpty('No upcoming holidays')
                        : Column(
                            children: bundle.holidays
                                .map((e) => HolidayRow(item: e))
                                .toList(),
                          ),
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

