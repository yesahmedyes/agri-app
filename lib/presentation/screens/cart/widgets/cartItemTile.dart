import 'dart:async';

import 'package:agriapp/data/models/cartItem.dart';
import 'package:agriapp/logic/cart/cart_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemTile extends StatefulWidget {
  final CartItem item;

  const CartItemTile({Key? key, required this.item}) : super(key: key);

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  bool opened = false;

  void _changeState() {
    setState(() {
      opened = !opened;
    });
  }

  Timer? debouncer;
  int quantity = 0;

  updateQuantity(int changeInQuantity) {
    debouncer?.cancel();

    quantity += changeInQuantity;

    debouncer = Timer(const Duration(milliseconds: 300), () {
      context.read<CartBloc>().add(
            CartUpdateEvent(
              categoryId: widget.item.categoryId,
              productId: widget.item.productId,
              quantity: quantity,
              productName: widget.item.productName,
              productImage: widget.item.productImage,
              price: widget.item.price,
            ),
          );

      quantity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalPrice = widget.item.quantity * widget.item.price;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      elevation: 1,
      child: InkWell(
        onTap: _changeState,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Row(
                children: [
                  CachedNetworkImage(imageUrl: widget.item.productImage, width: 70, height: 70),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.productName,
                          style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w600, height: 1.4),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 2),
                        if (!opened)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Rs $totalPrice'),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () => updateQuantity(-1),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                                      child: Text('-', style: TextStyle(fontSize: 18, color: Colors.black54, height: 1.2)),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey)),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Text(
                                      widget.item.quantity.toString(),
                                      style: const TextStyle(fontSize: 12, height: 1, color: Colors.black87),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => updateQuantity(1),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                                      child: Text('+', style: TextStyle(fontSize: 18, color: Colors.black54, height: 1.2)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (opened) Container(color: Colors.grey.withOpacity(0.1), width: double.infinity, height: 1),
            if (opened)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Item Price", style: Theme.of(context).textTheme.subtitle1),
                            const SizedBox(height: 4),
                            Text("Quantity", style: Theme.of(context).textTheme.subtitle1),
                            const SizedBox(height: 4),
                            Text("Total Price", style: Theme.of(context).textTheme.subtitle1),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rs ${widget.item.price}", style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(height: 4),
                            Text("${widget.item.quantity}", style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(height: 4),
                            Text("Rs $totalPrice", style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
