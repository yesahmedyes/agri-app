part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => [];
}

class ReportsFetchEvent extends ReportsEvent {
  final String farmId;

  const ReportsFetchEvent({required this.farmId});

  @override
  List<Object> get props => [farmId];
}
