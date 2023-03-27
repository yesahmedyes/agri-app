import 'package:agriapp/data/repositories/farm_repository.dart';
import 'package:agriapp/presentation/widgets/appBars/customAppBarBack.dart';
import 'package:agriapp/presentation/widgets/buttons/full_width_button.dart';
import 'package:agriapp/presentation/widgets/form/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'bloc/get_farm_bloc.dart';

class GetFarmNameScreen extends StatelessWidget {
  GetFarmNameScreen({super.key, required this.coordinates});

  final TextEditingController controller = TextEditingController();

  final List<LatLng> coordinates;

  _onSave(BuildContext context) {
    if (controller.text.isNotEmpty) {
      context.read<GetFarmBloc>().add(GetFarmSaveEvent(coordinates: coordinates, name: controller.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetFarmBloc(farmRepository: context.read<FarmRepository>()),
      child: Scaffold(
        appBar: const CustomAppBarBack(),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text('Apnay is Farm ka koi name enter karain', style: Theme.of(context).textTheme.headline3),
                  const SizedBox(height: 30),
                  CustomTextFormField(controller: controller, text: 'Farm Name'),
                ],
              ),
              const SizedBox(height: 20),
              BlocConsumer<GetFarmBloc, GetFarmState>(
                listener: (context, state) {
                  if (state is GetFarmSavedState) {
                    Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
                  }
                },
                builder: (context, state) {
                  return FullWidthButton(primary: true, text: (state is GetFarmSavingState) ? null : 'Save', onPressed: () => _onSave(context));
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
