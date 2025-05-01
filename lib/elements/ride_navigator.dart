import 'package:flutter/material.dart';
import 'package:uber/pages/ride_page.dart';

class RideNavigator extends StatelessWidget {
  const RideNavigator({super.key});

  // Use static to persist the key across rebuilds
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

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
