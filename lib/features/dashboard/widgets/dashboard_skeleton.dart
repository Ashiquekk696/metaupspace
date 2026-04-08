import 'package:flutter/material.dart';
import 'package:metaupspace/core/theme/app_theme.dart';

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final narrow = c.maxWidth < 560;
        final statRow = narrow
            ? Column(
                children: const [
                  SkelBox(height: 110),
                  SizedBox(height: 12),
                  SkelBox(height: 110),
                  SizedBox(height: 12),
                  SkelBox(height: 110),
                ],
              )
            : const Row(
                children: [
                  Expanded(child: SkelBox(height: 110)),
                  SizedBox(width: 12),
                  Expanded(child: SkelBox(height: 110)),
                  SizedBox(width: 12),
                  Expanded(child: SkelBox(height: 110)),
                ],
              );
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SkelBox(height: 140),
            const SizedBox(height: 16),
            statRow,
            const SizedBox(height: 20),
            const SkelBox(height: 72),
            const SizedBox(height: 12),
            const SkelBox(height: 72),
            const SizedBox(height: 12),
            const SkelBox(height: 72),
          ],
        );
      },
    );
  }
}

class SkelBox extends StatelessWidget {
  const SkelBox({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColors.surfaceElevated,
        border: Border.all(color: AppColors.border),
      ),
    );
  }
}

