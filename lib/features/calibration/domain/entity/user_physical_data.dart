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
    required this.stepGoal,
    this.strideLengthCm = 0.415,
  });

  UserPhysicalData copyWith({
    double? height,
    double? weight,
    Gender? gender,
    int? stepGoal,
    double? strideLengthCm,
  }) {
    return UserPhysicalData(
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      stepGoal: stepGoal ?? this.stepGoal,
      strideLengthCm: strideLengthCm ?? this.strideLengthCm,
    );
  }

  @override
  List<Object?> get props => [height, weight, gender, stepGoal, strideLengthCm];
}
