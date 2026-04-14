import 'package:stridex/core/constant/stride_enum.dart';

class UserPhysicalData  {
   double height;
   double weight;
   Gender gender;
   int stepGoal;
   double? strideLengthCm;

   UserPhysicalData({
    required this.height,
    required this.weight,
    required this.gender,
    required this.stepGoal,
    this.strideLengthCm = 0.415,
  });


}



