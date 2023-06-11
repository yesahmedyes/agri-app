import 'package:agriapp/logic/reports/reports_bloc.dart';
import 'package:agriapp/presentation/widgets/custom_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import 'bloc/sound_bloc.dart';

class ReportsDetailScreen extends StatefulWidget {
  const ReportsDetailScreen({super.key});

  @override
  State<ReportsDetailScreen> createState() => _ReportsDetailScreenState();
}

class _ReportsDetailScreenState extends State<ReportsDetailScreen> {
  final player = AudioPlayer();

  _playAudio() async {
    await player.play();
  }

  _stopAudio() async {
    await player.stop();
  }

  _setAsset() async {
    await player.setAsset("assets/sounds/report-sound.mp3");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _setAsset();
    _playAudio();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _stopAudio();

        return true;
      },
      child: BlocProvider(
        create: (context) => SoundBloc(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 1,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
            actions: [
              BlocBuilder<SoundBloc, SoundState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (state is SoundOnState) {
                        context.read<SoundBloc>().add(SoundTurnOffEvent());

                        _stopAudio();
                      } else {
                        context.read<SoundBloc>().add(SoundTurnOnEvent());

                        _playAudio();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: (state is SoundOnState) ? const Icon(Icons.volume_up) : const Icon(Icons.volume_off),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
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
                        CachedNetworkImage(imageUrl: state.report.nitrogen),
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
                        CachedNetworkImage(imageUrl: state.report.water),
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
        ),
      ),
    );
  }
}
