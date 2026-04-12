import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/di/injection.dart' as di;
import 'package:stridex/core/widgets/section_header_widget.dart';
import 'package:stridex/core/widgets/stride_x_app_bar.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/features/history/presentation/controller/history_cubit.dart';
import 'package:stridex/features/history/domain/entity/achievement_entity.dart';
import 'package:stridex/features/history/presentation/controller/history_states.dart';
import 'package:stridex/features/history/presentation/widgets/active_badge_progress_card.dart';
import 'package:stridex/features/history/presentation/widgets/streak_card.dart';
import 'package:stridex/features/history/presentation/widgets/achievement_card.dart';
import 'package:stridex/features/history/presentation/widgets/legendary_badge_card.dart';
import 'package:stridex/features/history/presentation/widgets/growth_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final HistoryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = di.init<HistoryCubit>()..loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HistoryCubit, HistoryState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state is HistoryLoading || state is HistoryInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryError) {
              return Center(child: Text(state.message));
            } else if (state is HistoryLoaded) {
              final data = state.data;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StrideXAppBar(),
                    const VerticalSpacingWidget(value: 24),
                    // 1. Streak Card
                    StreakCard(
                      strak: data.currentStreak,
                      longestStreak: data.longestStreak,
                      totalWins: data.totalWins,
                    ),
                    const VerticalSpacingWidget(value: 16),
                    // 2. Active Badge Progress
                    ActiveBadgeProgressCard(
                      progress: data.activeProgress,
                      currentSteps: data.currentSteps,
                      goalSteps: data.longestStreak, // shows personal best context
                    ),
                    // 3. Hall of Fame Section Header
                    const SectionHeaderWidget(
                      title: AppStrings.hallOfFame,
                      trailingText: AppStrings.viewAllAchievements,
                    ),
                    // 4. Achievement Grid (2 columns, built from domain entities)
                    _buildAchievementGrid(data.achievements),
                    const VerticalSpacingWidget(value: 24),
                    // 5. Legendary Badge — unlocked at totalWins >= 100
                    LegendaryBadgeCard(
                      isUnlocked: data.totalWins >= 100,
                    ),
                    const VerticalSpacingWidget(value: 16),
                    // 6. Growth Card (Half width)
                    Row(
                      children: [
                        Expanded(
                          child: GrowthCard(growthPercent: data.growthPercent),
                        ),
                        HorizantilSpacingWidget(value: 12),
                        const Spacer(),
                      ],
                    ),
                    const VerticalSpacingWidget(value: 40),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// Builds the 2-column achievement grid from the domain list.
  /// Pairs achievements into rows of 2.
  Widget _buildAchievementGrid(List<AchievementEntity> achievements) {
    final List<Widget> rows = [];
    for (int i = 0; i < achievements.length; i += 2) {
      final left = achievements[i];
      final right = i + 1 < achievements.length ? achievements[i + 1] : null;
      rows.add(
        Row(
          children: [
            Expanded(
              child: AchievementCard(
                title: left.title,
                subtitle: left.subtitle,
                icon: left.icon,
                iconColor: left.isUnlocked ? left.iconColor : Colors.grey,
                isUnlocked: left.isUnlocked,
              ),
            ),
            HorizantilSpacingWidget(value: 12),
            right != null
                ? Expanded(
                    child: AchievementCard(
                      title: right.title,
                      subtitle: right.subtitle,
                      icon: right.icon,
                      iconColor: right.isUnlocked ? right.iconColor : Colors.grey,
                      isUnlocked: right.isUnlocked,
                    ),
                  )
                : const Spacer(),
          ],
        ),
      );
      if (i + 2 < achievements.length) {
        rows.add(const VerticalSpacingWidget(value: 12));
      }
    }
    return Column(children: rows);
  }
}



