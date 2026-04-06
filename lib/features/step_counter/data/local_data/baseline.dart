import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/utils/cache_helper.dart';

abstract class BaselineLocalData {
  Future<int> getBaseline();
  Future<void> saveBaseline({required int steps});
}

class BaselineLocalDataImpl implements BaselineLocalData {
  
  @override
  Future<int> getBaseline() async {
    return CacheHelper.getData(key: AppKeys.baselineStep) ?? 0;
  }

  @override
  Future<void> saveBaseline({required int steps}) async {
    await CacheHelper.saveData(key: AppKeys.baselineStep, value: steps);
  }
}