import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/utils/cache_helper.dart';

abstract class DateHelper {
  Future<DateTime> getTodayDate();

  Future<void> saveTodayDate({required DateTime date});
}

class DateHelperImpl extends DateHelper {
  @override
  Future<DateTime> getTodayDate() async {
    final String? dateStr = CacheHelper.getData(key: AppKeys.todayDate);
    if (dateStr == null) {
      final now = DateTime.now();
      await saveTodayDate(date: now);
      return now;
    }
    return DateTime.parse(dateStr);
  }

  @override
  Future<void> saveTodayDate({required DateTime date}) async {
    await CacheHelper.saveData(
      key: AppKeys.todayDate,
      value: date.toIso8601String(),
    );
  }
}