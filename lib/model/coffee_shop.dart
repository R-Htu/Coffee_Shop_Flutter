import 'package:flutter/material.dart';
import 'coffee.dart';

class CoffeeShop {
  // coffee for sale list
  final List<Coffee> _shop = [
    Coffee(
        name: 'Long Black', price: '4.10', imagePath: 'lib/images/latte.png'),
    Coffee(name: 'Latte', price: '4.20', imagePath: 'lib/images/latte-art.png'),
    Coffee(
        name: 'Espresso',
        price: '4.10',
        imagePath: 'lib/images/coffee-art.png'),
    Coffee(
        name: 'Iced Coffee', price: '4.10', imagePath: 'lib/images/coffee.png'),
  ];
  // user cart
  List<Coffee> _userCart = [];

  //get coffee list
  List<Coffee> get coffeeShop => _shop;

  //get user cart
  List<Coffee> get userCart => _userCart;

  //add item to cart
  void addItemToCart(Coffee coffee) {
    _userCart.add(coffee);
  }

  //remove items from cart
  void removeItemFromCart(Coffee coffee) {
    _userCart.remove(coffee);
  }
}
