import 'package:agriapp/presentation/screens/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBottomAppBar extends StatelessWidget {
  const HomeBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: (state is HomeReportsState) ? () {} : () => context.read<HomeBloc>().add(HomeChangeToReportsEvent()),
                  style: (state is HomeReportsState) ? OutlinedButton.styleFrom(foregroundColor: Theme.of(context).primaryColor, backgroundColor: Colors.transparent) : OutlinedButton.styleFrom(foregroundColor: Colors.black54, backgroundColor: Colors.transparent),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.assignment_outlined),
                      SizedBox(height: 2),
                      Text('Reports', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: (state is HomeInitialState) ? () {} : () => context.read<HomeBloc>().add(HomeChangeToHomeEvent()),
                  style: (state is HomeInitialState) ? OutlinedButton.styleFrom(foregroundColor: Theme.of(context).primaryColor, backgroundColor: Colors.transparent) : OutlinedButton.styleFrom(foregroundColor: Colors.black54, backgroundColor: Colors.transparent),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.home),
                      SizedBox(height: 2),
                      Text('Home', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: (state is HomeProfileState) ? () {} : () => context.read<HomeBloc>().add(HomeChangeToProfileEvent()),
                  style: (state is HomeProfileState) ? OutlinedButton.styleFrom(foregroundColor: Theme.of(context).primaryColor, backgroundColor: Colors.transparent) : OutlinedButton.styleFrom(foregroundColor: Colors.black54, backgroundColor: Colors.transparent),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.person),
                      SizedBox(height: 2),
                      Text('Profile', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
