import 'package:agriapp/logic/farms/farms_bloc.dart';
import 'package:agriapp/presentation/screens/reports/bloc/farm_select_bloc.dart';
import 'package:agriapp/presentation/screens/reports/widgets/farms_row_widget.dart';
import 'package:agriapp/presentation/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/farm_map_widget.dart';
import 'widgets/farm_weather_widget.dart';
import 'widgets/report_detail_button.dart';

class ReportsHome extends StatelessWidget {
  const ReportsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmsBloc, FarmsState>(
      builder: (context, state) {
        if (state is FarmsLoadedState) {
          return BlocProvider(
            create: (context) => FarmSelectBloc()..add(FarmSelectChangeEvent(name: (state.farms.isEmpty) ? '' : state.farms.first.name)),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: FarmsRowWidget(farms: state.farms),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        FarmMapWidget(farms: state.farms),
                        const SizedBox(height: 20),
                        FarmWeatherWidget(farms: state.farms),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                          child: ReportDetailButton(farms: state.farms),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return const CustomProgressIndicator();
      },
    );
  }
}
