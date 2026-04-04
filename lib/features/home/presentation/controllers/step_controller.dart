import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/calibration/domain/entity/user_physical_data.dart';
import 'package:stridex/features/home/domain/entities/step_count.dart';
import 'package:stridex/features/home/domain/usecase/get_home_user_data_usecase.dart';
import 'package:stridex/features/home/domain/usecase/get_steps_usecase.dart';
import 'package:stridex/features/home/presentation/controllers/step_counter_state.dart';

class StepController extends Cubit<StepCounterState> {
  final GetStepsUsecase getStepsUsecase;
  final GetHomeUserDataUseCase getHomeUserDataUseCase;
  StreamSubscription<Either<Failure, StepCountEntity>>? subscription;

  StepController({
    required this.getStepsUsecase,
    required this.getHomeUserDataUseCase,
  }) : super(const Initial());

  static StepController get(context) => BlocProvider.of(context);

  void startListening() async {
    emit(const Loading());
    subscription?.cancel();

    // Fetch user data for the state
    UserPhysicalData? userData;
    final userDataResult = await getHomeUserDataUseCase();
    userDataResult.fold(
      (failure) => null, // Silently ignore if no user data
      (data) => userData = data,
    );

    subscription = getStepsUsecase().listen((either) {
      either.fold(
        (failure) {
          emit(Error(message: failure.message));
        },
        (stepCount) {
          emit(
            Loaded(
              dailyStep: stepCount.dailyStep,
              goalStep: stepCount.goalStep,
              progressStep: stepCount.reachedDayStep,
              calories: stepCount.calories,
              distance: stepCount.distance,
              activeTime: stepCount.activeTime,
              userPhysicalData: userData,
            ),
          );
        },
      );
    });
  }

  void cancelSubscription() {
    subscription?.cancel();
  }
}
