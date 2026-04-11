import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/features/step_counter/domian/entity/step_matrix_entity.dart';

class GetStepMatrix {

  StepMatrixEntity call({required int steps}) {
    final double distance = _calculateDistance(steps: steps, strideLengthCm:CachedData.userPhysicalData.strideLengthCm!);
    final calories = _calculateCalories(steps: steps, weight:CachedData.userPhysicalData.weight);
    return StepMatrixEntity(calories: calories, distance: distance);
  }


  double _calculateCalories({required int steps,required double weight}){
    return steps * weight* 0.00057;
  }

  double _calculateDistance({required int steps,required double strideLengthCm}){
    return steps * strideLengthCm  / 100000;
  }
}
