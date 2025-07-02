import 'package:flutter/material.dart';
import 'package:uber/feature/ride/view/screens/ride_page.dart';

class RideNavigator extends StatelessWidget {
  RideNavigator({super.key});

  // Use static to persist the key across rebuilds
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => const RidePage());
      },
    );
  }
}
