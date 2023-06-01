import 'package:agriapp/data/models/category.dart';
import 'package:agriapp/data/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class ProductsRepository {
  final FirebaseFirestore _firestore;

  ProductsRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  final Map<String, Category> _categories = {};

  Future<List<Category>> fetchCategories() async {
    final QuerySnapshot snapshot = await _firestore.collection('categories').where("active", isEqualTo: true).get();

    for (var each in snapshot.docs) {
      final _data = each.data() as Map<String, dynamic>;

      _data['documentId'] = each.id;

      _categories[each.id] = Category.fromMap(_data);
    }

    return _categories.values.toList();
  }

  Future<List<Product>> fetchProducts(String documentId) async {
    if (_categories[documentId]!.products.isEmpty) {
      final QuerySnapshot snapshot = await _firestore.collection('products').where("categoryId", isEqualTo: documentId).where("active", isEqualTo: true).get();

      for (var each in snapshot.docs) {
        final data = each.data() as Map<String, dynamic>;

        data['documentId'] = each.id;

        _categories[documentId]!.products.add(Product.fromMap(data));
      }
    }

    return _categories[documentId]!.products.toList();
  }

  Future<Product?> fetchSuggestion(String productId) async {
    final response = await http.get(Uri.https('dry-citadel-76352.herokuapp.com', 'suggestion/${productId}'));

    print("here");
    print(response.body);

    if (response.body.isNotEmpty) {
      final responseProductId = response.body;

      final snapshot = await _firestore.collection('products').doc(responseProductId).get();

      final data = snapshot.data() as Map<String, dynamic>;

      return Product.fromMap(data);
    }

    return null;
  }
}
