import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stridex/bloc_observer.dart';
import 'package:stridex/core/data/calibration_data.dart';
import 'package:stridex/core/di/injection.dart';
import 'package:stridex/core/services/database_service.dart';
import 'package:stridex/core/services/notification_service.dart';
import 'package:stridex/core/utils/cache_helper.dart';
import 'package:stridex/stride_x.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  Bloc.observer = MyBlocObserver();
  await ScreenUtil.ensureScreenSize();
  await CacheHelper.init();
  await initDependencies();
  await init<DatabaseService>().initDatabase();
  await init<NotificationService>().init();
  runApp(
    const StrideX(),
  );
}
