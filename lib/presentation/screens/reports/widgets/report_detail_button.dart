import 'package:agriapp/data/models/farm.dart';
import 'package:agriapp/logic/reports/reports_bloc.dart';
import 'package:agriapp/presentation/screens/reports/bloc/farm_select_bloc.dart';
import 'package:agriapp/presentation/widgets/buttons/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReportDetailButton extends StatelessWidget {
  final List<Farm> farms;

  const ReportDetailButton({super.key, required this.farms});

  _fetchReport(BuildContext context, String id) {
    context.read<ReportsBloc>().add(ReportsFetchEvent(farmId: id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmSelectBloc, FarmSelectState>(
      builder: (context, state) {
        if (state is FarmSelectedState) {
          final Farm farm = farms.firstWhere((each) => (each.name == state.name));

          _fetchReport(context, farm.id);

          return BlocBuilder<ReportsBloc, ReportsState>(
            builder: (context, state) {
              if (state is ReportsFetchedState) {
                return FullWidthButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/reportsDetail');
                  },
                  text: 'Latest Report   -   ${DateFormat('dd/MM/yyyy').format(state.report.createdAt)}',
                );
              }

              return const SizedBox.shrink();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
