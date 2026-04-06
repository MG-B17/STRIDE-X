import 'package:stridex/features/step_counter/domian/repositories/today_active_time_repositories.dart';

class ActiveTimeUsecase {
  int call({required int steps}) {
    // Basic pedometer estimation: ~100 steps per minute of active time
    return steps ~/ 100;
  }
}