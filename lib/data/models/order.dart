import 'package:agriapp/data/models/cartItem.dart';

class MyOrder {
  final int id;
  final String paymentMethod;
  final String status;
  final String address;
  final List<CartItem> items;

  MyOrder({required this.id, required this.paymentMethod, required this.status, required this.address, required this.items});
}
