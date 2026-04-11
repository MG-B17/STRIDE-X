import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stridex/features/analytics/domain/usecase/get_analytics_data_usecase.dart';
import 'package:stridex/features/analytics/presentation/controller/analytics_states.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final GetAnalyticsDataUsecase getAnalyticsDataUsecase;

  int _currentDays = 7;
  int get currentDays => _currentDays;
  bool get isWeekly => _currentDays == 7;

  AnalyticsCubit({required this.getAnalyticsDataUsecase}) : super(AnalyticsInitial());

  static AnalyticsCubit get(context) => BlocProvider.of(context);

  void loadAnalytics({int daysToAnalyze = 7}) async {
    _currentDays = daysToAnalyze;
    emit(AnalyticsLoading());
    try {
      final data = await getAnalyticsDataUsecase(daysToAnalyze);
      emit(AnalyticsLoaded(data: data));
    } catch (e) {
      emit(AnalyticsError(message: e.toString()));
    }
  }
}
