import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/core/widgets/section_header_widget.dart';
import 'package:stridex/core/widgets/stride_x_app_bar.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/features/history/presentation/widgets/active_badge_progress_card.dart';
import 'package:stridex/features/history/presentation/widgets/streak_card.dart';
import 'package:stridex/features/history/presentation/widgets/achievement_card.dart';
import 'package:stridex/features/history/presentation/widgets/legendary_badge_card.dart';
import 'package:stridex/features/history/presentation/widgets/growth_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StrideXAppBar(),
              VerticalSpacingWidget(value: 24),
              // 1. Streak Card
              const StreakCard(strak: 17,longestStreak: 24,totalWins: 6,),
              VerticalSpacingWidget(value: 16),
              // 2. Active Badge Progress
              const ActiveBadgeProgressCard(),
              // 3. Hall of Fame Section Header
              const SectionHeaderWidget(
                title: AppStrings.hallOfFame,
                trailingText: AppStrings.viewAllAchievements,
              ),
              // 4. Achievement Grid (2 columns)
              Row(
                children: [
                  Expanded(
                    child: AchievementCard(
                      title: AppStrings.first10k,
                      subtitle: AppStrings.unlockedJul12,
                      icon: Icons.military_tech_rounded,
                      iconColor: AppColors.kineticGreen,
                      isUnlocked: true,
                    ),
                  ),
                  HorizantilSpacingWidget(value: 12),
                  Expanded(
                    child: AchievementCard(
                      title: AppStrings.weekWarrior,
                      subtitle: AppStrings.unlockedYesterday,
                      icon: Icons.flash_on_rounded,
                      iconColor: AppColors.pulseBlue, // Mocking blue from image
                      isUnlocked: true,
                    ),
                  ),
                ],
              ),
              VerticalSpacingWidget(value: 12),
              Row(
                children: [
                  Expanded(
                    child: AchievementCard(
                      title: AppStrings.monthMarathon,
                      subtitle: AppStrings.eighteenDaysRemaining,
                      icon: Icons.lock_outline_rounded,
                      iconColor: Colors.grey,
                      isUnlocked: false,
                    ),
                  ),
                  HorizantilSpacingWidget(value: 12),
                  const Spacer(), // Empty space for incomplete grid
                ],
              ),
              VerticalSpacingWidget(value: 24),
              // 5. Legendary Badge
              const LegendaryBadgeCard(),
              VerticalSpacingWidget(value: 16),
              // 6. Growth Card (Half width)
              Row(
                children: [
                  const Expanded(
                    child: GrowthCard(),
                  ),
                  HorizantilSpacingWidget(value: 12),
                  const Spacer(),
                ],
              ),
              VerticalSpacingWidget(value: 40), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
