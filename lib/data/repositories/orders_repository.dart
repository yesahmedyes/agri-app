import 'dart:convert';

import 'package:agriapp/data/models/cartItem.dart';
import 'package:agriapp/data/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class OrdersRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  OrdersRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<MyOrder>> fetchOrders() async {
    final User? user = _firebaseAuth.currentUser;

    final response = await http.get(Uri.https('dry-citadel-76352.herokuapp.com', 'order', {'userId': user!.uid}));

    final body = jsonDecode(response.body) as List;

    final List<MyOrder> orders = [];

    for (var data in body) {
      final List _items = data['cartItems'];

      final List<CartItem> cartItems = [];

      for (var element in _items) {
        cartItems.add(CartItem.fromMap(element));
      }

      orders.add(MyOrder(id: data['id'], paymentMethod: data['paymentMethod'], status: data['status'], address: data['address'], items: cartItems));
    }

    return orders;
  }

  Future<bool> placeOrder(String address, List<CartItem> cart) async {
    final User? user = _firebaseAuth.currentUser;

    final Map<String, dynamic> data = {
      'userId': user!.uid,
      'phoneNumber': user.phoneNumber,
      'address': address,
      'paymentMethod': 'cash on delivery',
      'cartItems': cart.map((e) => e.toMap()).toList(),
      'status': 'pending',
    };

    try {
      await http.post(
        Uri.https('dry-citadel-76352.herokuapp.com', 'order'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      return true;
    } catch (error) {
      return false;
    }
  }
}
