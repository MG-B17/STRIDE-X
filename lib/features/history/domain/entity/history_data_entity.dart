import 'package:equatable/equatable.dart';
import 'package:stridex/features/history/domain/entity/achievement_entity.dart';

class HistoryDataEntity extends Equatable {
  final int currentStreak;
  final int longestStreak;
  final int totalWins;
  final double activeProgress;
  final int currentSteps;
  final double growthPercent;
  final List<AchievementEntity> achievements;

  const HistoryDataEntity({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalWins,
    required this.activeProgress,
    required this.currentSteps,
    required this.growthPercent,
    required this.achievements,
  });

  @override
  List<Object?> get props => [
    currentStreak,
    longestStreak,
    totalWins,
    activeProgress,
    currentSteps,
    growthPercent,
    achievements,
  ];
}



