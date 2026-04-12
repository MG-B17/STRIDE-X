import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/features/onboarding/widgets/custom_image.dart';
import 'package:stridex/features/onboarding/widgets/onboarding_tittle_and_sub_tittle.dart';
import 'package:stridex/features/onboarding/widgets/pace_chip.dart';
import 'package:stridex/features/onboarding/models/onboarding_model.dart';

class OnboardingPageView extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageView({super.key, required this.page});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 53,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CustomImage(image: page.imagePath,),
              Padding(
                padding: EdgeInsets.only(right: 20.w, bottom: 20.h),
                child: const PaceChip(),
              ),
            ],
          ),
        ),
        
       OnboardingTittleAndSubTittle(
           tittle: page.title, 
           titleHighlight: page.titleHighlight, 
           description: page.description
       )
      ],
    );
  }
}



