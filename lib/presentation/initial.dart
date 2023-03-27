import 'package:agriapp/logic/login/login_bloc.dart';
import 'package:agriapp/presentation/screens/auth/getting_started.dart';
import 'package:agriapp/presentation/screens/home/bloc/home_bloc.dart';
import 'package:agriapp/presentation/screens/home/home_screen.dart';
import 'package:agriapp/presentation/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
      },
      listenWhen: (previous, current) => (previous is! LoginSuccessState && current is LoginSuccessState) || (previous is! LoginInitialState && current is LoginInitialState),
      buildWhen: (previous, current) => (previous is! LoginSuccessState && current is LoginSuccessState) || (previous is! LoginInitialState && current is LoginInitialState),
      builder: (context, state) {
        if (state is LoginCheckingStatusState) return const SplashScreen();

        if (state is LoginSuccessState) {
          return BlocProvider(
            create: (context) => HomeBloc(),
            child: const HomeScreen(),
          );
        }
        return const GettingStartedScreen();
      },
    );
  }
}
