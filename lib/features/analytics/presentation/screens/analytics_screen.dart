import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';
import 'package:stridex/core/widgets/stride_x_app_bar.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/features/analytics/presentation/widgets/analytics_header.dart';
import 'package:stridex/features/analytics/presentation/widgets/step_performance_card.dart';
import 'package:stridex/features/analytics/presentation/widgets/insight_card.dart';
import 'package:stridex/features/analytics/presentation/widgets/total_weekly_steps_card.dart';
import 'package:stridex/features/analytics/presentation/widgets/goal_completion_card.dart';
import 'package:stridex/features/analytics/presentation/widgets/active_burn_card.dart';
import 'package:stridex/features/analytics/presentation/widgets/consistency_section.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  bool isWeekly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StrideXAppBar(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpacingWidget(value: 20),
                    AnalyticsHeader(
                      title: AppStrings.analyticsTitle,
                      isWeekly: isWeekly,
                      onWeeklyTap: () => setState(() => isWeekly = true),
                      onMonthlyTap: () => setState(() => isWeekly = false),
                    ),
                    const VerticalSpacingWidget(value: 24),
                    const StepPerformanceCard(),
                    const VerticalSpacingWidget(value: 16),
                    const InsightCard(
                      icon: Icons.auto_awesome,
                      iconColor: AppColors.pulseBlue,
                      title: AppStrings.smartInsights,
                      content: TextSpan(
                        children: [
                          TextSpan(text: AppStrings.insightWalked),
                          TextSpan(
                            text: AppStrings.insightHighlight,
                            style: TextStyle(color: AppColors.kineticGreen, fontWeight: FontWeight.w700),
                          ),
                          TextSpan(text: AppStrings.insightRest),
                        ],
                      ),
                    ),
                    const VerticalSpacingWidget(value: 16),
                    const InsightCard(
                      icon: Icons.bolt,
                      iconColor: AppColors.warning,
                      title: AppStrings.peakActivity,
                      content: TextSpan(
                        children: [
                          TextSpan(
                            text: AppStrings.peakDay,
                            style: TextStyle(color: AppColors.warning, fontWeight: FontWeight.w700),
                          ),
                          TextSpan(text: AppStrings.peakRest),
                        ],
                      ),
                    ),
                    const VerticalSpacingWidget(value: 16),
                    const TotalWeeklyStepsCard(),
                    const VerticalSpacingWidget(value: 16),
                    const GoalCompletionCard(),
                    const VerticalSpacingWidget(value: 16),
                    const ActiveBurnCard(),
                    const VerticalSpacingWidget(value: 16),
                    const ConsistencySection(),
                    const VerticalSpacingWidget(value: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
