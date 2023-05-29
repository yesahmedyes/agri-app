import 'package:agriapp/logic/login/login_bloc.dart';
import 'package:agriapp/presentation/screens/categories/categories_home.dart';
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
            return const CategoriesHome();
          } else if (state is HomeChatState) {
            return ChatHome();
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text('Welcome to KissanDost!!!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 80),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () => Navigator.of(context).pushNamed('/profile'),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                child: const Text('Profile', style: TextStyle(fontSize: 15, letterSpacing: 1.2, fontWeight: FontWeight.w600)),
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.of(context).pushNamed('/orders'),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                child: const Text('Orders', style: TextStyle(fontSize: 15, letterSpacing: 1.2, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                child: const Text('Terms & Conditions', style: TextStyle(fontSize: 15, letterSpacing: 1.2, fontWeight: FontWeight.w600)),
                              ),
                            ),
                            InkWell(
                              onTap: () => context.read<LoginBloc>().add(LoginLogoutEvent()),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                child: const Text('Logout', style: TextStyle(fontSize: 15, letterSpacing: 1.2, fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
