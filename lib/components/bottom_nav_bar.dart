import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTapBottom; // Callback for tab changes

  const BottomNavBar({super.key, required this.onTapBottom});

  @override
  Widget build(BuildContext context) {
    return GNav(
      color: Colors.black,
      activeColor: const Color.fromARGB(255, 249, 230, 223),
      tabBackgroundColor: const Color.fromARGB(
          255, 108, 134, 152), // Tab background color when active
      tabBackgroundGradient: LinearGradient(
        colors: [
          const Color.fromARGB(255, 147, 197, 142),
          const Color.fromARGB(255, 168, 56, 56)
        ], // Adding a gradient for the active tab
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      tabBorderRadius: 10,
      rippleColor: const Color.fromARGB(
          255, 98, 37, 37), // Add a ripple effect when tapping on tabs
      hoverColor: Colors.blue, // Color when hovering (for web)
      gap: 8, // Space between the icons and text
      onTabChange: onTapBottom,
      tabs: const [
        GButton(
          icon: Icons.shopping_bag,
          text: 'Shop',
        ),
        GButton(
          icon: Icons.shopping_cart,
          text: 'Rate',
        ),
        GButton(
          icon: Icons.rate_review,
          text: 'Cart',
        ),
      ],
    );
  }
}
