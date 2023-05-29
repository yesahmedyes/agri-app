import 'package:agriapp/logic/checkout/checkout_bloc.dart';
import 'package:agriapp/presentation/widgets/navigation/customAppBarBack.dart';
import 'package:agriapp/presentation/widgets/navigation/customBottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/checkoutAddress.dart';
import 'widgets/checkoutCart.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarBack(text: 'Checkout'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const CheckoutAddress(),
              Container(color: Colors.black12, width: double.infinity, height: 1, margin: const EdgeInsets.only(top: 40, bottom: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment method', style: Theme.of(context).textTheme.subtitle1),
                  IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: () {}),
                ],
              ),
              const SizedBox(height: 12),
              Text('Cash on delivery', style: Theme.of(context).textTheme.bodyText1),
              Container(color: Colors.black12, width: double.infinity, height: 1, margin: const EdgeInsets.only(top: 40, bottom: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cart', style: Theme.of(context).textTheme.subtitle1),
                  IconButton(icon: const Icon(Icons.edit, color: Colors.grey, size: 20), onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName('/cart'))),
                ],
              ),
              const SizedBox(height: 12),
              const CheckoutCart(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutCompletedState) {
            Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
          }
        },
        builder: (context, state) {
          return CustomBottomNavigation(
            text: (state is CheckoutSubmittingState) ? null : 'Confirm Order',
            onPressed: (state is CheckoutSubmittingState) ? null : () => context.read<CheckoutBloc>().add(CheckoutSubmitEvent()),
          );
        },
      ),
    );
  }
}
