import 'package:flutter/material.dart';
import 'package:uber/pages/account_page.dart';

class AccountNavigator extends StatelessWidget {
  const AccountNavigator({super.key});

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => const AccountPage());
      },
    );
  }
}
