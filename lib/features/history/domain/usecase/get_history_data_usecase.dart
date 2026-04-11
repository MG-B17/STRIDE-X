import 'package:flutter/material.dart';
import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/core/theme/app_color.dart';
import 'package:stridex/features/history/domain/entity/achievement_entity.dart';
import 'package:stridex/features/history/domain/entity/history_data_entity.dart';
import 'package:stridex/features/step_counter/domian/entity/today_data_entity.dart';
import 'package:stridex/features/step_counter/domian/repositories/step_repositories.dart';

class GetHistoryDataUsecase {
  final StepRepositories stepRepositories;

  GetHistoryDataUsecase({required this.stepRepositories});

  Future<HistoryDataEntity> call() async {
    final List<TodayDataEntity> history = await stepRepositories.getAllHistoricalData();
    final int stepGoal = CachedData.userPhysicalData.stepGoal;
    final today = DateTime.now();
    final todayStr = _dateOnly(today);

    final streakData = _calculateStreaks(history, stepGoal, todayStr);
    final weeklySteps = _calculateWeeklySteps(history, todayStr);
    final currentSteps = _getTodaySteps(history, todayStr);
    final activeProgress = _calculateActiveProgress(currentSteps, stepGoal);
    final achievements = _evaluateAchievements(
      any10k: streakData.any10k,
      currentStreak: streakData.currentStreak,
      longestStreak: streakData.longestStreak,
      totalWins: streakData.totalWins,
    );

    return HistoryDataEntity(
      currentStreak: streakData.currentStreak,
      longestStreak: streakData.longestStreak,
      totalWins: streakData.totalWins,
      activeProgress: activeProgress,
      currentSteps: currentSteps,
      growthPercent: weeklySteps.growthPercent,
      achievements: achievements,
    );
  }


  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);


  /// Calculate streaks, total wins, and if any 10K steps achieved
  _StreakData _calculateStreaks(List<TodayDataEntity> history, int stepGoal, DateTime todayStr) {
    int currentStreak = 0;
    int longestStreak = 0;
    int totalWins = 0;
    int tempStreak = 0;
    bool any10k = false;
    DateTime? lastWinDate;

    for (final entry in history) {
      final goalMet = entry.stepsCount >= stepGoal;
      if (entry.stepsCount >= 10000) any10k = true;

      if (goalMet) {
        totalWins++;
        if (lastWinDate == null) {
          tempStreak = 1;
        } else {
          final diff = _dateOnly(entry.date).difference(_dateOnly(lastWinDate)).inDays;
          tempStreak = diff == 1 ? tempStreak + 1 : 1;
        }
        lastWinDate = entry.date;
        if (tempStreak > longestStreak) longestStreak = tempStreak;
      } else {
        tempStreak = 0;
        lastWinDate = null;
      }
    }

    if (lastWinDate != null) {
      final daysSinceLastWin = todayStr.difference(_dateOnly(lastWinDate)).inDays;
      currentStreak = daysSinceLastWin <= 1 ? tempStreak : 0;
    }

    return _StreakData(
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      totalWins: totalWins,
      any10k: any10k,
    );
  }

  /// Calculate this week and last week steps, and growth %
  _WeeklySteps _calculateWeeklySteps(List<TodayDataEntity> history, DateTime todayStr) {
    int thisWeekSteps = 0;
    int lastWeekSteps = 0;

    for (final entry in history) {
      final daysAgo = todayStr.difference(_dateOnly(entry.date)).inDays;
      if (daysAgo >= 0 && daysAgo <= 6) thisWeekSteps += entry.stepsCount;
      if (daysAgo >= 7 && daysAgo <= 13) lastWeekSteps += entry.stepsCount;
    }

    final double growthPercent = lastWeekSteps == 0
        ? 0.0
        : ((thisWeekSteps - lastWeekSteps) / lastWeekSteps) * 100;

    return _WeeklySteps(thisWeekSteps: thisWeekSteps, lastWeekSteps: lastWeekSteps, growthPercent: growthPercent);
  }

  /// Get today’s step count
  int _getTodaySteps(List<TodayDataEntity> history, DateTime todayStr) {
    for (final entry in history) {
      if (_dateOnly(entry.date) == todayStr) {
        return entry.stepsCount;
      }
    }
    return 0;
  }

  /// Calculate active progress towards step goal
  double _calculateActiveProgress(int currentSteps, int stepGoal) {
    return (currentSteps / (stepGoal == 0 ? 1 : stepGoal)).clamp(0.0, 1.0);
  }

  /// Evaluate achievements based on streaks, wins, 10k steps
  List<AchievementEntity> _evaluateAchievements({
    required bool any10k,
    required int currentStreak,
    required int longestStreak,
    required int totalWins,
  }) {
    return [
      AchievementEntity(
        title: 'First 10K',
        subtitle: any10k ? 'Unlocked' : 'Walk 10,000 steps in one day',
        icon: Icons.military_tech_rounded,
        iconColor: AppColors.kineticGreen,
        isUnlocked: any10k,
      ),
      AchievementEntity(
        title: 'Week Warrior',
        subtitle: longestStreak >= 7
            ? 'Unlocked'
            : '${7 - (longestStreak < 7 ? longestStreak : 6)} days to go',
        icon: Icons.flash_on_rounded,
        iconColor: AppColors.pulseBlue,
        isUnlocked: longestStreak >= 7,
      ),
      AchievementEntity(
        title: 'Month Marathon',
        subtitle: longestStreak >= 30
            ? 'Unlocked'
            : '${30 - longestStreak.clamp(0, 29)} days remaining',
        icon: Icons.lock_outline_rounded,
        iconColor: Colors.grey,
        isUnlocked: longestStreak >= 30,
      ),
    ];
  }
}

/// ------------------ Helper Data Classes ------------------

class _StreakData {
  final int currentStreak;
  final int longestStreak;
  final int totalWins;
  final bool any10k;

  _StreakData({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalWins,
    required this.any10k,
  });
}

class _WeeklySteps {
  final int thisWeekSteps;
  final int lastWeekSteps;
  final double growthPercent;

  _WeeklySteps({
    required this.thisWeekSteps,
    required this.lastWeekSteps,
    required this.growthPercent,
  });
}