import 'package:agriapp/data/models/farm.dart';
import 'package:agriapp/presentation/screens/reports/bloc/farm_select_bloc.dart';
import 'package:agriapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmsRowWidget extends StatelessWidget {
  final List<Farm> farms;

  const FarmsRowWidget({Key? key, required this.farms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          if (farms.isNotEmpty) FarmsRowChildWidget(farms: farms),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed('/getFarm'),
            borderRadius: BorderRadius.circular(30),
            child: const CustomCircleAvatar(icon: Icons.add),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class FarmsRowChildWidget extends StatelessWidget {
  final List<Farm> farms;

  const FarmsRowChildWidget({Key? key, required this.farms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmSelectBloc, FarmSelectState>(
      builder: (context, state) {
        return Row(
          children: farms.map((farm) {
            return InkWell(
              onTap: () {
                context.read<FarmSelectBloc>().add(FarmSelectChangeEvent(name: farm.name));
              },
              borderRadius: BorderRadius.circular(30),
              child: Column(
                children: [
                  CustomCircleAvatar(
                    imageUrl: 'https://images.unsplash.com/photo-1560493676-04071c5f467b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8ZmFybXxlbnwwfHwwfHw%3D&w=1000&q=80',
                    selected: (state is FarmSelectedState && farm.name == state.name),
                  ),
                  const SizedBox(height: 2),
                  Text(farm.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5))
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class CustomCircleAvatar extends StatelessWidget {
  final String? imageUrl;
  final IconData? icon;
  final bool selected;

  const CustomCircleAvatar({Key? key, this.imageUrl, this.icon, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: (selected == true) ? lightGreenColor : Colors.grey,
          width: (selected == true) ? 2 : 1,
        ),
      ),
      width: 60,
      height: 60,
      child: (imageUrl != null)
          ? ClipOval(
              child: Image.network(imageUrl!, fit: BoxFit.fill),
            )
          : (icon != null)
              ? Icon(icon!)
              : const SizedBox.shrink(),
    );
  }
}
