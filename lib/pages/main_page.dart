import 'package:flutter/material.dart';
import 'package:uber/colors/colors.dart';
import 'package:uber/elements/ride_navigator.dart';
import 'package:uber/pages/account_page.dart';
import 'package:uber/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }

  final List<Widget> _screens = [HomePage(), RideNavigator(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          backgroundColor: black,
          selectedItemColor: white,
          unselectedItemColor: gray3,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: "Ride",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
          ],
        ),
      ),
    );
  }
}
