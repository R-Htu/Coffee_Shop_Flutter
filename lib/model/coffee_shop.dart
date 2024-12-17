import 'package:flutter/material.dart';
import 'coffee.dart';

/* // List of coffee maps (Yay ..:D no longer need the Coffee class )
  final List<Map<String, String>> _shop = [
    {'name': 'Long Black', 'price': '4.10', 'imagePath': 'lib/images/latte.png'},
    {'name': 'Latte', 'price': '4.20', 'imagePath': 'lib/images/latte-art.png'},
    {'name': 'Espresso', 'price': '4.10', 'imagePath': 'lib/images/coffee-art.png'},
    {'name': 'Iced Coffee', 'price': '4.10', 'imagePath': 'lib/images/coffee.png'},
  ];

  final List<Map<String, String>> _userCart = [];

 
  List<Map<String, String>> get coffeeShop => _shop;

 
  List<Map<String, String>> get userCart => _userCart; */
class CoffeeShop extends ChangeNotifier {
  // coffee for sale list
  final List<Coffee> _shop = [
    Coffee(
        name: 'Long Black', price: '4.10', imagePath: 'lib/images/latte.png'),
    Coffee(name: 'Latte', price: '4.20', imagePath: 'lib/images/latte-art.png'),
    Coffee(
        name: 'Espresso',
        price: '4.10',
        imagePath: 'lib/images/coffee-cup.png'),
    Coffee(
        name: 'Iced Coffee', price: '4.10', imagePath: 'lib/images/coffee.png'),
  ];
  // user cart
  final List<Coffee> _userCart = [];

  //get coffee list
  List<Coffee> get coffeeShop => _shop;

  //get user cart
  List<Coffee> get userCart => _userCart;

  //add item to cart
  void addItemToCart(Coffee coffee) {
    _userCart.add(coffee);
    notifyListeners();
  }

  //remove items from cart
  void removeItemFromCart(Coffee coffee) {
    _userCart.remove(coffee);
    notifyListeners();
  }
}
