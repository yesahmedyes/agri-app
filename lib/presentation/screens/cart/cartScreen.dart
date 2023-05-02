import 'package:agriapp/logic/cart/cart_bloc.dart';
import 'package:agriapp/presentation/widgets/appBars/customAppBarBack.dart';
import 'package:agriapp/presentation/widgets/custom_progress_indicator.dart';
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: items.length + 2,
                  itemBuilder: (context, index) => (index == 0 || index == items.length + 1) ? const SizedBox(height: 30) : Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: CartItemTile(item: items[index - 1])),
                ),
              );
            }
          }
          return const CustomProgressIndicator();
        },
      ),
      // bottomNavigationBar: CustomBottomNavigation(text: 'Proceed to Checkout', onPressed: () => Navigator.of(context).pushNamed('/location')),
    );
  }
}
