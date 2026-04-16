import 'package:stridex/core/services/database_service.dart';
import 'package:stridex/core/utils/date_helper.dart';
import 'package:stridex/features/step_counter/domain/entity/today_data_entity.dart';

abstract class TodayStepLocalData {
  Future<int> getTodaysteps();
  Future<void> saveTodaySteps({required int steps});
  Future<TodayDataEntity> getTodayData();
  Future<void> saveTodayData({required TodayDataEntity todayData});
  Future<List<TodayDataEntity>> getWeeklyData();
  Future<List<TodayDataEntity>> getLastNDaysData(int days);
  Future<List<TodayDataEntity>> getAllHistoricalData();
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
    return data.stepsCount as int? ?? 0;
  }

  @override
  Future<void> saveTodaySteps({required int steps}) async {
    final todayStr = DateTime.now().toIso8601String().split('T')[0];
    final existing = await databaseService.query(
      'steps',
      where: 'date = ?',
      whereArgs: [todayStr],
    );

    if (existing.isNotEmpty) {
      await databaseService.update(
        'steps',
        {'steps_count': steps},
        where: 'date = ?',
        whereArgs: [todayStr],
      );
    } else {
      await databaseService.insert('steps', {
        'steps_count': steps,
        'date': todayStr,
      });
    }
  }

  @override
  Future<TodayDataEntity> getTodayData() async {
    final today = await dateHelper.getTodayDate();
    final todayStr = today.toIso8601String().split('T')[0];

    final results = await databaseService.query(
      'steps',
      where: 'date = ?',
      whereArgs: [todayStr],
      orderBy: 'id DESC',
      limit: 1,
    );

    if (results.isNotEmpty) {
      return TodayDataEntity.fromMap(results.first);
    }

    return TodayDataEntity(
      stepsCount: 0,
      calories: 0.0,
      distance: 0.0,
      activeTimeSeconds: 0,
      date: today,
    );
  }

  @override
  Future<void> saveTodayData({required TodayDataEntity todayData}) async {
    final todayStr = todayData.date.toIso8601String().split('T')[0];
    final existing = await databaseService.query(
      'steps',
      where: 'date = ?',
      whereArgs: [todayStr],
    );

    if (existing.isNotEmpty) {
      await databaseService.update(
        'steps',
        todayData.toMap(),
        where: 'date = ?',
        whereArgs: [todayStr],
      );
    } else {
      await databaseService.insert('steps', todayData.toMap());
    }
  }

  @override
  Future<List<TodayDataEntity>> getWeeklyData() async {
    final today = await dateHelper.getTodayDate();
    final firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

    final firstDayStr = firstDayOfWeek.toIso8601String().split('T')[0];
    final lastDayStr = lastDayOfWeek.toIso8601String().split('T')[0];

    final results = await databaseService.query(
      'steps',
      where: 'date >= ? AND date <= ?',
      whereArgs: [firstDayStr, lastDayStr],
    );

    return results.map((e) => TodayDataEntity.fromMap(e)).toList();
  }

  @override
  Future<List<TodayDataEntity>> getLastNDaysData(int days) async {
    final today = await dateHelper.getTodayDate();
    final pastDay = today.subtract(Duration(days: days - 1));

    final pastDayStr = pastDay.toIso8601String().split('T')[0];
    final todayStr = today.toIso8601String().split('T')[0];

    final results = await databaseService.query(
      'steps',
      where: 'date >= ? AND date <= ?',
      whereArgs: [pastDayStr, todayStr],
    );

    return results.map((e) => TodayDataEntity.fromMap(e)).toList();
  }

  @override
  Future<List<TodayDataEntity>> getAllHistoricalData() async {
    final db = await databaseService.database;
    final results = await db.query('steps', orderBy: 'date ASC');
    return results.map((e) => TodayDataEntity.fromMap(e)).toList();
  }
}
