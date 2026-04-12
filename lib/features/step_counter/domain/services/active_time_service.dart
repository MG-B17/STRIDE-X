import 'package:stridex/features/step_counter/domain/entity/today_data_entity.dart';

class ActiveTimeService {
  int? _lastProcessedSteps;
  DateTime? _lastStepTime;


  TodayDataEntity updateActiveTime({
    required int currentSteps,
    required TodayDataEntity currentEntity,
  }) {
    final now = DateTime.now();
    int activeTimeSeconds = currentEntity.activeTimeSeconds;

    if (_lastProcessedSteps != null && _lastStepTime != null) {
      final int deltaSteps = currentSteps - _lastProcessedSteps!;
      final int timeDiffSeconds = now.difference(_lastStepTime!).inSeconds;

      if (deltaSteps > 0 && timeDiffSeconds > 0) {
        final double stepsPerSecond = deltaSteps / timeDiffSeconds;

        // Condition: Steps are within human range (0.5 to 3.5 steps/sec) 
        // and per-update delta is reasonable (< 20 steps)
        if (deltaSteps <= 20 && stepsPerSecond >= 0.5 && stepsPerSecond <= 3.5) {
          activeTimeSeconds += timeDiffSeconds;
        }
      }
    }

    _lastProcessedSteps = currentSteps;
    _lastStepTime = now;

    return TodayDataEntity(
      stepsCount: currentSteps,
      calories: currentEntity.calories,
      distance: currentEntity.distance,
      activeTimeSeconds: activeTimeSeconds,
      date: currentEntity.date,
    );
  }

  void reset() {
    _lastProcessedSteps = null;
    _lastStepTime = null;
  }
}


