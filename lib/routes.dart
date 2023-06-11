import 'package:agriapp/data/models/product.dart';
import 'package:agriapp/presentation/screens/auth/login_screen.dart';
import 'package:agriapp/presentation/screens/cart/cartScreen.dart';
import 'package:agriapp/presentation/screens/get_farm/get_farm_location_screen.dart';
import 'package:agriapp/presentation/screens/order/orders_screen.dart';
import 'package:agriapp/presentation/screens/profile/profile_screen.dart';
import 'package:agriapp/presentation/screens/reports_detail/reports_detail_screen.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/auth/getting_started.dart';
import 'presentation/screens/checkout/checkoutScreen.dart';
import 'presentation/screens/checkout/locationScreen.dart';
import 'presentation/screens/product/product_detail_screen.dart';
import 'presentation/screens/product/products_list_screen.dart';

class ProductDetailArguments {
  final Product product;
  final String categoryId;

  ProductDetailArguments({required this.product, required this.categoryId});
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/gettingStarted':
        return MaterialPageRoute(builder: (context) => const GettingStartedScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case '/profile':
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case '/cart':
        return MaterialPageRoute(builder: (context) => const CartScreen(), settings: const RouteSettings(name: '/cart'));
      case '/orders':
        return MaterialPageRoute(builder: (context) => const OrdersScreen());
      case '/location':
        return MaterialPageRoute(builder: (context) => LocationScreen(), settings: const RouteSettings(name: '/location'));
      case '/checkout':
        return MaterialPageRoute(builder: (context) => const CheckoutScreen(), settings: const RouteSettings(name: '/checkout'));
      case '/getFarm':
        return MaterialPageRoute(builder: (context) => GetFarmLocationScreen());
      case '/reportsDetail':
        return MaterialPageRoute(builder: (context) => ReportsDetailScreen());
      case '/productsList':
        return MaterialPageRoute(builder: (context) => const ProductsListScreen());
      case '/productDetail':
        final args = settings.arguments as ProductDetailArguments;
        return MaterialPageRoute(builder: (context) => ProductDetailScreen(product: args.product, categoryId: args.categoryId));

      default:
        return MaterialPageRoute(builder: (context) => const GettingStartedScreen());
    }
  }
}
