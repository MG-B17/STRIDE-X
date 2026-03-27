import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stridex/core/navigation/app_route.dart';
import 'package:stridex/core/theme/app_theme.dart';
import 'package:stridex/core/theme/theme_controller.dart';


class StrideX extends StatelessWidget {
  const StrideX({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return ChangeNotifierProvider<ThemeProvider>(
          create: (context)=>ThemeProvider()..loadTheme(),
          child: Consumer<ThemeProvider>(
            builder: (context,themeProvider,_)=>MaterialApp.router(
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode:themeProvider.themeMode,
            ),
          ),
        );
      },
    );
  }
}