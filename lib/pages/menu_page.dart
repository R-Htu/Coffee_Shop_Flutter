import 'package:coffeeshop/components/coffee_tile.dart';
import 'package:coffeeshop/model/coffee.dart';
import 'package:coffeeshop/model/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  void addToCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).addItemToCart(coffee);

    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 1), () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // Close the dialog
          }
        });

        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 58, 54, 54),
          title: Text(
            'Action Completed!',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'The item has been successfully added to your cart.',
            style: TextStyle(
              color: Colors.white24,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How would you like your coffee?',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800]),
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: value.coffeeShop.length,
                  itemBuilder: (context, index) {
                    Coffee eachCoffee = value.coffeeShop[index];
                    return CoffeeTile(
                      icon: Icon(Icons.add_shopping_cart,
                          color: const Color.fromARGB(255, 220, 199, 191)),
                      coffee: eachCoffee,
                      onPressed: () => addToCart(eachCoffee),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
