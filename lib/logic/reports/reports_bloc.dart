import 'package:agriapp/data/models/report.dart';
import 'package:agriapp/data/repositories/reports_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ReportsRepository reportsRepository;

  final Map<String, Report?> cachedReports = {};

  ReportsBloc({required this.reportsRepository}) : super(ReportsInitialState()) {
    on<ReportsFetchEvent>((event, emit) async {
      emit(ReportsInitialState());

      if (!cachedReports.containsKey(event.farmId)) {
        final report = await reportsRepository.getReport(event.farmId);

        cachedReports[event.farmId] = report;
      }

      if (cachedReports[event.farmId] != null) {
        emit(ReportsFetchedState(report: cachedReports[event.farmId]!));
      }
    });
  }
}
