import 'package:agriapp/logic/cart/cart_bloc.dart';
import 'package:agriapp/presentation/screens/cart/widgets/suggestionBox.dart';
import 'package:agriapp/presentation/widgets/custom_progress_indicator.dart';
import 'package:agriapp/presentation/widgets/navigation/customAppBarBack.dart';
import 'package:agriapp/presentation/widgets/navigation/customBottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/cartItemTile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarBack(text: 'Cart'),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartOpenedState) {
            final items = state.items;

            if (items.isEmpty) {
              return Center(child: Text('Sorry, the cart is empty.', style: Theme.of(context).textTheme.headline2));
            } else {
              return SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 30),
                        for (int i = 0; i < state.items.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: CartItemTile(item: items[i]),
                          ),
                        const SizedBox(height: 30),
                        SuggestionBox(items: items),
                        const SizedBox(height: 30),
                      ],
                    )),
              );
            }
          }
          return const CustomProgressIndicator();
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(text: 'Proceed to Checkout', onPressed: () => Navigator.of(context).pushNamed('/location')),
    );
  }
}
