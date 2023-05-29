import 'package:agriapp/data/models/cartItem.dart';
import 'package:agriapp/data/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  OrdersRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<MyOrder>> fetchOrders() async {
    final User? user = _firebaseAuth.currentUser;

    final QuerySnapshot snapshot = await _firestore.collection("orders").where("profileId", isEqualTo: user!.uid).get();

    final List<MyOrder> orders = [];

    for (var element in snapshot.docs) {
      final data = element.data() as Map;

      final List _items = data['items'];

      final List<CartItem> cartItems = [];

      for (var element in _items) {
        cartItems.add(CartItem.fromMap(element));
      }

      orders.add(MyOrder(id: element.id, paymentMethod: data['paymentMethod'], status: data['status'], address: data['address'], items: cartItems));
    }

    return orders;
  }

  Future<bool> placeOrder(String address, List<CartItem> cart) async {
    final User? _user = _firebaseAuth.currentUser;

    final Map<String, dynamic> _data = {
      'profileId': _user!.uid,
      'phoneNumber': _user.phoneNumber,
      'address': address,
      'paymentMethod': 'cash on delivery',
      'items': cart.map((e) => e.toMap()).toList(),
      'status': 'pending',
    };

    try {
      await _firestore.collection("orders").add(_data);
      return true;
    } catch (error) {
      return false;
    }
  }
}
