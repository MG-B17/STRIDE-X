import 'package:stridex/core/services/database_service.dart';
import 'package:stridex/core/utils/date_helper.dart';

abstract class StepCounterLocalData {
  Future<int> getTodaysteps();
  Future<void> saveTodaySteps({required int steps});
}

class StepCounterLocalDataImpl implements StepCounterLocalData {
  final DatabaseService databaseService;
  final DateHelper dateHelper;

  StepCounterLocalDataImpl({
    required this.databaseService,
    required this.dateHelper,
  });

  @override
  Future<int> getTodaysteps() async {
    final today = await dateHelper.getTodayDate();
    final todayStr = today.toIso8601String().split('T')[0];

    final results = await databaseService.query(
      'steps',
      where: 'date = ?',
      whereArgs: [todayStr],
    );

    if (results.isNotEmpty) {
      return results.first['steps_count'] as int;
    }
    return 0;
  }

  @override
  Future<void> saveTodaySteps({required int steps}) async {
    final today = await dateHelper.getTodayDate();
    final todayStr = today.toIso8601String().split('T')[0];

    await databaseService.insert('steps', {
      'steps_count': steps,
      'date': todayStr,
    });
  }
  
}

