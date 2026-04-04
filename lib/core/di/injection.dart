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
import 'package:stridex/features/calibration/domain/usecase/save_user_physical_data_usecase.dart';
import 'package:stridex/features/calibration/presentation/controller/calibration_cubit.dart';
import 'package:stridex/features/home/data/local_data/baseline_local_data.dart';
import 'package:stridex/features/home/data/local_data/step_counter_local_data.dart';
import 'package:stridex/features/home/data/local_data/user_step_goal_local.dart';
import 'package:stridex/features/home/data/repositories/step_repository_impl.dart';
import 'package:stridex/features/home/domain/repositories/step_repository.dart';
import 'package:stridex/features/home/domain/usecase/get_home_user_data_usecase.dart';
import 'package:stridex/features/home/domain/usecase/get_steps_usecase.dart';
import 'package:stridex/features/home/presentation/controllers/step_controller.dart';

final init = GetIt.instance;

Future<void> initDependencies() async {
  //Cubit
  init.registerFactory<StepController>(
    () => StepController(
      getStepsUsecase: init(),
      getHomeUserDataUseCase: init(),
    ),
  );
  init.registerFactory<CalibrationCubit>(
    () => CalibrationCubit(
      calibrateUseCase: init(),
      calibrationRepository: init(),
      calibrationStreamUsecase: init(),
      saveUserPhysicalDataUseCase: init(),
    ),
  );

  //UseCase
  init.registerLazySingleton(() => GetStepsUsecase(repository: init()));
  init.registerLazySingleton(() => GetHomeUserDataUseCase(repository: init()));
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

  //Repository
  init.registerLazySingleton<StepRepository>(
    () => StepRepositoryImpl(
      dateHelper: init(),
      stepCounterLocalData: init(),
      baselineLocalData: init(),
      userStepGoalLocal: init(),
      activityPremssionService: init<ActivityPremssionService>(),
      calibrationLocalData: init()
    ),
  );
  init.registerLazySingleton<CalibrationRepository>(
    () => CalibrationRepositoryImpl(localData: init()),
  );
  init.registerLazySingleton<CalibrationStreamRepository>(
    () => CalibrationStreamRepositoryImpl(activityPremssionService: init<ActivityPremssionService>()),
  );

  // DataSource
  init.registerLazySingleton<BaselineLocalData>(() => BaselineLocalDataImpl());
  init.registerLazySingleton<UserStepGoalLocal>(() => UserstePGoalLocalImple());
  init.registerLazySingleton<StepCounterLocalData>(
    () => StepCounterLocalDataImpl(databaseService: init(), dateHelper: init()),
  );
  init.registerLazySingleton<DateHelper>(() => DateHelperImpl());
  init.registerFactory<CalibrationLocalData>(
    () => CalibrationLocalDataImpl(databaseService: init()),
  );

  // Services
  init.registerLazySingleton<DatabaseService>(() => StepDatabaseHelper());
  init.registerLazySingleton<ActivityPremssionService>(
    () => ActivityPremssionService(),
  );
}
 