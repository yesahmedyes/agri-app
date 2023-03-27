part of 'reports_bloc.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

class ReportsInitialState extends ReportsState {}

class ReportsFetchedState extends ReportsState {
  final Report report;

  const ReportsFetchedState({required this.report});

  @override
  List<Object> get props => [report];
}
