import 'package:stridex/core/constant/keys.dart';
import 'package:stridex/core/utils/cache_helper.dart';

abstract class UserStepGoalLocal {
  Future<int> getUserStepGoal();
  Future<void> saveUserStepGoal({required int stepGoal});
}

class UserstePGoalLocalImple extends UserStepGoalLocal {
  @override
  Future<int> getUserStepGoal() async {
    return await CacheHelper.getData(key: AppKeys.stepGoal) ?? 10000;
}

  @override
  Future<void> saveUserStepGoal({required int stepGoal}) async{
   await CacheHelper.saveData(key:AppKeys.stepGoal, value: stepGoal);
  }
}
