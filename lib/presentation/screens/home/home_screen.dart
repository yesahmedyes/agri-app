import 'package:agriapp/presentation/screens/chat/chat_home.dart';
import 'package:agriapp/presentation/screens/home/bloc/home_bloc.dart';
import 'package:agriapp/presentation/screens/home/widgets/home_bottom_app_bar.dart';
import 'package:agriapp/presentation/screens/reports/reports_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const HomeBottomAppBar(),
      drawerEdgeDragWidth: 30,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeReportsState) {
            return const ReportsHome();
          } else if (state is HomeInitialState) {
            return const Center(child: Text('Home'));
          } else if (state is HomeChatState) {
            return ChatHome();
          }
          return const Center(child: Text('Profile'));
        },
      ),
    );
  }
}
