import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stridex/features/history/domain/usecase/get_history_data_usecase.dart';
import 'package:stridex/features/history/presentation/controller/history_states.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final GetHistoryDataUsecase getHistoryDataUsecase;

  HistoryCubit({required this.getHistoryDataUsecase})
      : super(const HistoryInitial());

  static HistoryCubit get(context) => BlocProvider.of(context);

  void loadHistory() async {
    emit(const HistoryLoading());
    try {
      final data = await getHistoryDataUsecase();
      emit(HistoryLoaded(data: data));
    } catch (e) {
      emit(HistoryError(message: e.toString()));
    }
  }
}
