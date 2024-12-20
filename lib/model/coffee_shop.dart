import 'package:flutter/material.dart';
import 'coffee.dart';

class CoffeeShop extends ChangeNotifier {
  // List of coffees available for sale
  final List<Coffee> _shop = [
    Coffee(
        name: 'Long Black',
        price: '4.10',
        imagePath: 'lib/images/latte.png',
        basePrice: 4.10),
    Coffee(
        name: 'Latte',
        price: '4.20',
        imagePath: 'lib/images/latte-art.png',
        basePrice: 4.20),
    Coffee(
        name: 'Espresso',
        price: '4.10',
        imagePath: 'lib/images/coffee-cup.png',
        basePrice: 4.10),
    Coffee(
        name: 'Black Coffee',
        price: '4.10',
        imagePath: 'lib/images/coffee.png',
        basePrice: 4.10),
  ];

  // List of user-selected coffees in the cart
  final List<Coffee> _userCart = [];

  // Get coffee list for sale
  List<Coffee> get coffeeShop => _shop;

  // Get user cart items
  List<Coffee> get userCart => _userCart;

  // Add coffee item to cart
  void addItemToCart(Coffee coffee) {
    _userCart.add(coffee);
    notifyListeners();
  }

  // Remove coffee item from cart
  void removeItemFromCart(Coffee coffee) {
    _userCart.remove(coffee);
    notifyListeners();
  }

  // Update coffee size in the cart
  void updateCoffeeSizeInCart(Coffee coffee, String size) {
    // Update the size and price for the coffee item in the cart
    coffee.updatePrice(size);
    notifyListeners(); // Notify the UI to rebuild with updated prices
  }
}
