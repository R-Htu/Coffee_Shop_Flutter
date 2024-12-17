import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTapBottom; // Callback for tab changes

  BottomNavBar({super.key, required this.onTapBottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GNav(
        color: Colors.black,
        activeColor: Colors.brown,
        tabActiveBorder: Border.all(
          color: Colors.white,
          width: 1,
        ),
        tabs: [
          GButton(
            icon: Icons.shopping_bag,
            text: 'Shop',
          ),
          GButton(
            icon: Icons.rate_review,
            text: 'Rate',
          ),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
          ),
        ],
      ),
    );
  }
}
