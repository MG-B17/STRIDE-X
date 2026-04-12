import 'package:equatable/equatable.dart';
import 'package:stridex/features/history/domain/entity/history_data_entity.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryLoaded extends HistoryState {
  final HistoryDataEntity data;

  const HistoryLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}



