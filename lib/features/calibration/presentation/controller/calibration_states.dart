import 'package:equatable/equatable.dart';
import 'package:stridex/core/constant/stride_enum.dart';

abstract class CalibrationState extends Equatable {
  const CalibrationState();
  
  @override
  List<Object> get props => [];
}

class CalibrationInitial extends CalibrationState {
  const CalibrationInitial();
}

class CalibrationLoading extends CalibrationState {
  const CalibrationLoading();
}

class CalibrationSuccess extends CalibrationState {
  final double factor;
  const CalibrationSuccess(this.factor);
  
  @override
  List<Object> get props => [factor];
}

class CalibrationFailure extends CalibrationState {
  final String message;
  const CalibrationFailure(this.message);
  
  @override
  List<Object> get props => [message];
}

class LoadingCalibrationStream extends CalibrationState {
  const LoadingCalibrationStream();
}

class CalibrationStreamSuccess extends CalibrationState {
  final int steps;
  const CalibrationStreamSuccess(this.steps);
  
  @override
  List<Object> get props => [steps];
}

class CalibrationStreamFail extends CalibrationState {
  final String message;
  const CalibrationStreamFail(this.message);
  
  @override
  List<Object> get props => [message];
}

class SelectGender extends CalibrationState {
  final Gender gender ;
  const SelectGender({required this.gender});

  @override
  List<Object> get props => [gender];
}



