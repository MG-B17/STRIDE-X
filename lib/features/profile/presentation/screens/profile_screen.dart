import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/constant/app_strings.dart';
import 'package:stridex/features/profile/presentation/widgets/daily_goal_card.dart';
import 'package:stridex/features/profile/presentation/widgets/notifications_card.dart';
import 'package:stridex/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:stridex/core/widgets/section_header_widget.dart';
import 'package:stridex/features/profile/presentation/widgets/settings_action_button.dart';
import 'package:stridex/features/profile/presentation/widgets/sign_out_section.dart';
import 'package:stridex/features/profile/presentation/widgets/theme_selection_card.dart';
import 'package:stridex/features/profile/presentation/widgets/units_toggle_card.dart';
import 'package:stridex/core/theme/text_styles.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeaderWidget(image: 'assets/images/Professional athlete running.png',level: "5",name: "Mostafa Galal",),
              // Account Settings
              const SectionHeaderWidget(
                title: AppStrings.accountSettings,
                trailingText: AppStrings.personalization,
              ),
              const DailyGoalCard(steps: "10000",),
              VerticalSpacingWidget(value: 16),
              const UnitsToggleCard(),
              // Notifications
              const SectionHeaderWidget(
                title: AppStrings.notifications,
                icon: Icons.notifications_none_outlined,
              ),
              const NotificationsCard(),
              // Visual Theme
              const SectionHeaderWidget(title: AppStrings.visualTheme),
              const ThemeSelectionCard(),
              // Language
              const SectionHeaderWidget(title: AppStrings.language),
              SettingsActionButton(
                icon: Icons.language_rounded,
                label: AppStrings.englishArabic,
                onTap: () {},
              ),
              // Sign Out Base
              const SignOutSection(),
            ],
          ),
        ),
      ),
    );
  }
}
