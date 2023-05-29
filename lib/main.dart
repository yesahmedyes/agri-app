import 'package:agriapp/data/repositories/auth_repository.dart';
import 'package:agriapp/data/repositories/cart_repository.dart';
import 'package:agriapp/data/repositories/chat_repository.dart';
import 'package:agriapp/data/repositories/farm_repository.dart';
import 'package:agriapp/data/repositories/orders_repository.dart';
import 'package:agriapp/data/repositories/products_repository.dart';
import 'package:agriapp/data/repositories/reports_repository.dart';
import 'package:agriapp/data/repositories/weather_repository.dart';
import 'package:agriapp/logic/categories/categories_bloc.dart';
import 'package:agriapp/logic/chat/chat_bloc.dart';
import 'package:agriapp/logic/checkout/checkout_bloc.dart';
import 'package:agriapp/logic/login/login_bloc.dart';
import 'package:agriapp/logic/orders/orders_bloc.dart';
import 'package:agriapp/logic/product/product_bloc.dart';
import 'package:agriapp/logic/reports/reports_bloc.dart';
import 'package:agriapp/logic/weather/weather_bloc.dart';
import 'package:agriapp/presentation/initial.dart';
import 'package:agriapp/routes.dart';
import 'package:agriapp/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'logic/cart/cart_bloc.dart';
import 'logic/farms/farms_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) => AuthRepository(), lazy: false),
        RepositoryProvider<FarmRepository>(create: (context) => FarmRepository()),
        RepositoryProvider<WeatherRepository>(create: (context) => WeatherRepository()),
        RepositoryProvider<ReportsRepository>(create: (context) => ReportsRepository()),
        RepositoryProvider<ChatRepository>(create: (context) => ChatRepository()),
        RepositoryProvider<ProductsRepository>(create: (context) => ProductsRepository()),
        RepositoryProvider<CartRepository>(create: (context) => CartRepository()),
        RepositoryProvider<OrdersRepository>(create: (context) => OrdersRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(authRepository: context.read<AuthRepository>())..add(LoginCheckStatusEvent()),
            lazy: false,
          ),
          BlocProvider<CategoriesBloc>(create: (context) => CategoriesBloc(categoryRepository: context.read<ProductsRepository>())..add(CategoriesFetchEvent())),
          BlocProvider<ProductBloc>(create: (context) => ProductBloc(categoryRepository: context.read<ProductsRepository>())),
          BlocProvider<CartBloc>(create: (context) => CartBloc(cartRepository: context.read<CartRepository>())..add(CartCheckStatusEvent())),
          BlocProvider<FarmsBloc>(create: (context) => FarmsBloc(farmRepository: context.read<FarmRepository>())..add(FarmsLoadEvent())),
          BlocProvider<WeatherBloc>(create: (context) => WeatherBloc(weatherRepository: context.read<WeatherRepository>())),
          BlocProvider<ReportsBloc>(create: (context) => ReportsBloc(reportsRepository: context.read<ReportsRepository>())),
          BlocProvider<ChatBloc>(create: (context) => ChatBloc(chatRepository: context.read<ChatRepository>())),
          BlocProvider<CheckoutBloc>(
            create: (context) => CheckoutBloc(
              cartRepository: context.read<CartRepository>(),
              ordersRepository: context.read<OrdersRepository>(),
            )..add(const CheckoutChangeEvent()),
          ),
          BlocProvider<OrdersBloc>(create: (context) => OrdersBloc(ordersRepository: context.read<OrdersRepository>())..add(OrdersFetchEvent())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: theme(),
          onGenerateRoute: RouteGenerator.generateRoute,
          home: const InitialScreen(),
        ),
      ),
    );
  }
}
