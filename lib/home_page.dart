import 'package:coffeeshop/components/app_drawer.dart';
import 'package:coffeeshop/components/bottom_nav_bar.dart';
import 'package:coffeeshop/const.dart';
import 'package:coffeeshop/pages/cart_page.dart';
import 'package:coffeeshop/pages/menu_page.dart';
import 'package:coffeeshop/pages/save_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomIndex = 0;
  final List<Widget> _pages = [
    const MenuPage(),
    const CartPage(),
    const SavePage(),
  ];

  void bottomBarNavigator(int index) {
    setState(() {
      _bottomIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      endDrawer: AppDrawer(),
      body: _pages[_bottomIndex],
      bottomNavigationBar: BottomNavBar(
        onTapBottom: (index) => bottomBarNavigator(index),
      ),
    );
  }
}
