import 'package:stridex/core/services/database_service.dart';
import 'package:stridex/core/utils/date_helper.dart';

abstract class TodayStepLocalData {
  Future<int> getTodaysteps();
  Future<void> saveTodaySteps({required int steps});
  Future<Map<String, dynamic>> getTodayData();
}

class StepCounterLocalDataImpl extends TodayStepLocalData {
  final DatabaseService databaseService;
  final DateHelper dateHelper;

  StepCounterLocalDataImpl({
    required this.databaseService,
    required this.dateHelper,
  });

  @override
  Future<int> getTodaysteps() async {
    final data = await getTodayData();
    return data['steps_count'] as int? ?? 0;
  }

  @override
  Future<void> saveTodaySteps({required int steps}) async {
    final todayStr = DateTime.now().toIso8601String().split('T')[0];
    await databaseService.insert('steps', {'steps_count': steps, 'date': todayStr});
  }

  @override
  Future<Map<String, dynamic>> getTodayData() async {
    final today = await dateHelper.getTodayDate();
    final todayStr = today.toIso8601String().split('T')[0];

    final results = await databaseService.query(
      'steps',
      where: 'date = ?',
      whereArgs: [todayStr],
    );

    if (results.isNotEmpty) {
      return results.first;
    }
    return {
      'steps_count': 0,
      'calories': 0.0,
      'distance': 0.0,
      'active_time_seconds': 0,
      'date': todayStr,
    };
  }
}
