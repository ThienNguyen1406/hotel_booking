import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/pages/booking.dart';
import 'package:online_shopping/pages/home.dart';
import 'package:online_shopping/pages/profile.dart';
import 'package:online_shopping/pages/wallet.dart';

class BottomNavigation extends StatefulWidget {
  final int? initIndex;
  const BottomNavigation({super.key, this.initIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    Booking(),
    Wallet(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          index: currentIndex,
          backgroundColor: Colors.white,
          color: Colors.black,
          buttonBackgroundColor:
              Colors.black, 
          height: 60,
          animationDuration: const Duration(milliseconds: 200),
          items: const <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.shopping_bag, size: 30, color: Colors.white),
            Icon(Icons.wallet, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ));
  }
}
