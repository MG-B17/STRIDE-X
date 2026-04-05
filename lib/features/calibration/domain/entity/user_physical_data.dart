import 'package:equatable/equatable.dart';
import 'package:stridex/core/constant/stride_enum.dart';

class UserPhysicalData extends Equatable {
  final double height;
  final double weight;
  final Gender gender;
  final int stepGoal;
  final double? strideLengthCm;

  const UserPhysicalData({
    required this.height,
    required this.weight,
    required this.gender,
    this.stepGoal = 2000,
    this.strideLengthCm = 0.415,
  });

  @override
  List<Object?> get props => [height, weight, gender, stepGoal, strideLengthCm];
}
