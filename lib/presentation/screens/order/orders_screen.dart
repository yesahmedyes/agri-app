import 'package:agriapp/extensions.dart';
import 'package:agriapp/logic/orders/orders_bloc.dart';
import 'package:agriapp/presentation/widgets/custom_progress_indicator.dart';
import 'package:agriapp/presentation/widgets/navigation/customAppBarBack.dart';
import 'package:agriapp/theme.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrdersBloc>().add(OrdersFetchEvent());

    return Scaffold(
      appBar: const CustomAppBarBack(text: 'Orders'),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersSuccessState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: state.orders.map(
                  (element) {
                    final name = element.items.map((e) => e.productName).join(' ');
                    final total = element.items.map((e) => e.price * e.quantity).toList().sum;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        elevation: 1,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, height: 1.8), maxLines: 2),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Price: $total', style: const TextStyle(fontSize: 15)),
                                    Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: darkGreenColor.withOpacity(0.8)),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      child: Text(element.status.capitalize(), style: const TextStyle(height: 1, color: Colors.white, fontSize: 12)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          }
          return const CustomProgressIndicator();
        },
      ),
    );
  }
}
