import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/core/utils/extentions.dart';
import 'package:stridex/core/widgets/spacing_widget.dart';

class OnboardingTittleAndSubTittle extends StatelessWidget {
  const OnboardingTittleAndSubTittle({super.key,required this.tittle,required this.titleHighlight,required this.description});
  final String tittle ;
  final String titleHighlight;
  final String description;

  @override
  Widget build(BuildContext context) {
    return  Expanded(
          flex: 47,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacingWidget(value: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$tittle\n',
                        style: context
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 34.sp, height: 1.15),
                      ),
                      TextSpan(
                        text: titleHighlight,
                        style: context
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                              fontSize: 34.sp,
                              height: 1.15,
                              color:context.colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
                VerticalSpacingWidget(value: 14),
                Text(
                  description,
                  style:context.textTheme.bodyMedium,
                ),
                const Spacer(),
              ],
            ),
          ),
        );
  }
}



