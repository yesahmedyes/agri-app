import 'package:agriapp/presentation/screens/auth/login_screen.dart';
import 'package:agriapp/presentation/screens/get_farm/get_farm_location_screen.dart';
import 'package:agriapp/presentation/screens/reports_detail/reports_detail_screen.dart';
import 'package:flutter/material.dart';

import 'presentation/screens/auth/getting_started.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/gettingStarted':
        return MaterialPageRoute(builder: (context) => const GettingStartedScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case '/getFarm':
        return MaterialPageRoute(builder: (context) => GetFarmLocationScreen());
      case '/reportsDetail':
        return MaterialPageRoute(builder: (context) => const ReportsDetailScreen());
      default:
        return MaterialPageRoute(builder: (context) => const GettingStartedScreen());
    }
  }
}
