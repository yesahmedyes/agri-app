import 'package:agriapp/logic/reports/reports_bloc.dart';
import 'package:agriapp/presentation/widgets/navigation/customAppBarBack.dart';
import 'package:agriapp/presentation/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsDetailScreen extends StatelessWidget {
  const ReportsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarBack(),
      body: BlocBuilder<ReportsBloc, ReportsState>(
        builder: (context, state) {
          if (state is ReportsFetchedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text('Nitrogen report', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    Image.network(state.report.nitrogen),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFFffb503), borderRadius: BorderRadius.circular(2)), margin: const EdgeInsets.only(bottom: 2)),
                            const Text('Low'),
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF4fbb2f), borderRadius: BorderRadius.circular(2)), margin: const EdgeInsets.only(top: 12, bottom: 2)),
                            const Text('Medium'),
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF1c00aa), borderRadius: BorderRadius.circular(2)), margin: const EdgeInsets.only(top: 12, bottom: 2)),
                            const Text('High'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text('Water report', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    Image.network(state.report.water),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFFff1b0c), borderRadius: BorderRadius.circular(2)), margin: const EdgeInsets.only(bottom: 2)),
                            const Text('Stress'),
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFFf36379), borderRadius: BorderRadius.circular(2)), margin: const EdgeInsets.only(top: 12, bottom: 2)),
                            const Text('Mild stress'),
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF557df6), borderRadius: BorderRadius.circular(2)), margin: const EdgeInsets.only(top: 12, bottom: 2)),
                            const Text('No stress'),
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF1c00aa), borderRadius: BorderRadius.circular(2)), margin: const EdgeInsets.only(top: 12, bottom: 2)),
                            const Text('High moisture'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }

          return const CustomProgressIndicator();
        },
      ),
    );
  }
}
