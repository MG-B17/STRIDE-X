import 'package:stridex/features/home/domain/entities/step_count.dart';

class StepCountModel extends StepCountEntity {
  StepCountModel({
    required super.dailyStep,
    required super.goalStep,
    required super.reachedDayStep,
  });

  factory StepCountModel.fromJson(Map<String, dynamic> json) {
    return StepCountModel(
      dailyStep: json['steps_count'] as int,
      goalStep: json['goal_step'] ?? 10000, // Default if not in DB
      reachedDayStep: (json['goal_reached_percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'steps_count': dailyStep,
      'goal_reached_percentage': reachedDayStep,
      // Date is usually handled by the helper or separate column
    };
  }
}
