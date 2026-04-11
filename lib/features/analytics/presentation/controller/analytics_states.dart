import 'package:equatable/equatable.dart';
import 'package:stridex/features/analytics/domain/entity/analytics_data_entity.dart';

abstract class AnalyticsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final AnalyticsDataEntity data;
  AnalyticsLoaded({required this.data});

  @override
  List<Object?> get props => [data];
}

class AnalyticsError extends AnalyticsState {
  final String message;
  AnalyticsError({required this.message});

  @override
  List<Object?> get props => [message];
}
