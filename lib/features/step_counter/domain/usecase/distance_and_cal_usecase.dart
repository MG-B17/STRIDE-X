import 'package:stridex/features/step_counter/domain/entity/step_matrix_entity.dart';

class DistanceAndCalUsecase {

  StepMatrixEntity call({
    required int steps,
    required double weight,
    required double strideLengthCm,
  }) {
    final double distance = _calculateDistance(steps: steps, strideLengthCm: strideLengthCm);
    final calories = _calculateCalories(steps: steps, weight: weight);
    return StepMatrixEntity(calories: calories, distance: distance);
  }

  double _calculateCalories({required int steps, required double weight}) {
    return steps * weight * 0.00057;
  }

  double _calculateDistance({required int steps, required double strideLengthCm}) {
    return steps * strideLengthCm / 100000;
  }
}



