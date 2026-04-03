import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stridex/core/errors/failure.dart';
import 'package:stridex/features/home/domain/entities/step_count.dart';
import 'package:stridex/features/home/domain/usecase/get_steps_usecase.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stridex/features/home/presentation/controllers/step_counter_state.dart';

class StepController extends Cubit<StepCounterState> {
  final GetStepsUsecase getStepsUsecase;
  StreamSubscription<Either<Failure, StepCountEntity>>? subscription;

  StepController({required this.getStepsUsecase}) : super(Initial());

  static StepController get(context) => BlocProvider.of(context);

  void startListening() async {
    if (await Permission.activityRecognition.request().isGranted) {
      subscription?.cancel();
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
              ),
            );
          },
        );
      });
    }
  }

  void cancelSubscription() {
    subscription?.cancel();
  }
}
