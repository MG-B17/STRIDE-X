import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSpacingWidget extends StatelessWidget {
  const VerticalSpacingWidget({super.key,required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value.h,
    );
  }
}

class HorizantilSpacingWidget extends StatelessWidget {
  const HorizantilSpacingWidget({super.key,required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: value.w,
    );
  }
}