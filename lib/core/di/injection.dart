import 'package:get_it/get_it.dart';
import 'package:stridex/core/services/activity_premssion_service.dart';
import 'package:stridex/core/services/database_service.dart';
import 'package:stridex/core/services/step_database_helper.dart';
import 'package:stridex/core/utils/date_helper.dart';
import 'package:stridex/features/calibration/data/local_data/calibration_local_data.dart';
import 'package:stridex/features/calibration/data/repo_impl/calibration_factor_repository_impl.dart';
import 'package:stridex/features/calibration/data/repo_impl/calibration_stream_repository_impl.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_factor_repository.dart';
import 'package:stridex/features/calibration/domain/repo/calibration_stream_repository.dart';
import 'package:stridex/features/calibration/domain/usecase/calibrate_steps_usecase.dart';
import 'package:stridex/features/calibration/domain/usecase/calibration_stream_usecase.dart';
import 'package:stridex/features/calibration/domain/usecase/get_user_physical_data_usecase.dart';
import 'package:stridex/features/analytics/domain/usecase/get_analytics_data_usecase.dart';
import 'package:stridex/features/analytics/presentation/controller/analytics_cubit.dart';
import 'package:stridex/features/history/domain/usecase/get_history_data_usecase.dart';
import 'package:stridex/features/history/presentation/controller/history_cubit.dart';
import 'package:stridex/features/calibration/domain/usecase/save_user_physical_data_usecase.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_cubit.dart';
import 'package:stridex/features/step_counter/data/local_data/baseline.dart';
import 'package:stridex/features/step_counter/data/local_data/sensor_step.dart';
import 'package:stridex/features/step_counter/data/local_data/today_steps.dart';
import 'package:stridex/features/step_counter/data/repositories_implement/today_steps_repositories_implement.dart';
import 'package:stridex/features/step_counter/domian/repositories/step_repositories.dart';
import 'package:stridex/features/step_counter/domian/usecase/distance_and_cal_usecase.dart';
import 'package:stridex/features/step_counter/domian/usecase/today_steps_usecase.dart';
import 'package:stridex/features/step_counter/domian/usecase/weekly_progress_usecase.dart';
import 'package:stridex/features/step_counter/presentation/controller/step_counter_cubit.dart';

final init = GetIt.instance;

Future<void> initDependencies() async {
  //Cubit
  init.registerFactory<StepCounterCubit>(()=>StepCounterCubit(todayStepsUsecase: init(), getStepMatrix: init(), weeklyProgressUsecase: init()));
  init.registerFactory<AnalyticsCubit>(()=>AnalyticsCubit(getAnalyticsDataUsecase: init()));
  init.registerFactory<HistoryCubit>(()=>HistoryCubit(getHistoryDataUsecase: init()));
  init.registerFactory<CalibrationCubit>(
    () => CalibrationCubit(
      calibrateUseCase: init(),
      calibrationRepository: init(),
      calibrationStreamUsecase: init(),
      saveUserPhysicalDataUseCase: init(),
    ),
  );

  //UseCase
  init.registerLazySingleton(()=>GetStepMatrix());
  init.registerLazySingleton(()=>TodayStepsUsecase(stepRepositories: init()));
  init.registerLazySingleton(()=>GetAnalyticsDataUsecase(stepRepositories: init()));
  init.registerLazySingleton(()=>GetHistoryDataUsecase(stepRepositories: init()));
  init.registerLazySingleton(()=>WeeklyProgressUsecase(stepRepositories: init()));
  init.registerLazySingleton<CalibrateStepsUseCase>(
    () => CalibrateStepsUseCaseImpl(),
  );
  init.registerLazySingleton<CalibrationStreamUsecase>(
    () => CalibrationStreamUsecase(repository: init()),
  );
  init.registerLazySingleton<SaveUserPhysicalDataUseCase>(
    () => SaveUserPhysicalDataUseCase(repository: init()),
  );
  init.registerLazySingleton<GetUserPhysicalDataUseCase>(
    () => GetUserPhysicalDataUseCase(repository: init()),
  );

  /// repositories 
  init.registerLazySingleton<StepRepositories>(()=>TodyStepsRepositoriesImplement(baselineLocalData: init(), getStepDataFormSensor: init(), todayStepLocalData: init()));
  init.registerLazySingleton<CalibrationRepository>(
    () => CalibrationRepositoryImpl(localData: init()),
  );
  init.registerLazySingleton<CalibrationStreamRepository>(
    () => CalibrationStreamRepositoryImpl(
      activityPremssionService: init<ActivityPremssionService>(),
    ),
  );
  init.registerLazySingleton<GetStepDataFormSensor>(
    () => GetStepDataFormSensorImpl(activityPremssionService: init()),
  );

  // DataSource
  init.registerLazySingleton<BaselineLocalData>(() => BaselineLocalDataImpl());
  init.registerLazySingleton<TodayStepLocalData>(()=>StepCounterLocalDataImpl(databaseService: init(), dateHelper: init()));
  init.registerLazySingleton<DateHelper>(() => DateHelperImpl());
  init.registerLazySingleton<CalibrationLocalData>(
    () => CalibrationLocalDataImpl(databaseService: init()),
  );

  // Services
  init.registerLazySingleton<DatabaseService>(() => StepDatabaseHelper());
  init.registerLazySingleton<ActivityPremssionService>(
    () => ActivityPremssionService(),
  );

  // 
}
 