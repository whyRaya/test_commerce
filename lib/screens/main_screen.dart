import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_commerce/screens/main/home_screen.dart';
import 'package:test_commerce/styles/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Center(child: Text("Official Store")),
    Center(child: Text("Transaction")),
    Center(child: Text("Profile"))
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Fixed
          backgroundColor: Colors.white, // <-- This works for fixed
          selectedItemColor: primary,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Official Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped),
      body: SizedBox(
        width: double.infinity,
        child: _widgetOptions.elementAt(_selectedIndex),
      )
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.controller,
  });

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home, color: accent,),
            onPressed: () {
              controller.animateTo(0);
            },
          ),
          IconButton(
            icon: const Icon(Icons.store),
            onPressed: () {
              controller.animateTo(1);
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              controller.animateTo(2);
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              controller.animateTo(3);
            },
          )
        ],
      ),
    );
  }
}

