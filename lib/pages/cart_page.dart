import 'package:coffeeshop/components/cart_item_tile.dart';
import 'package:coffeeshop/model/coffee.dart';
import 'package:coffeeshop/model/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Add item to cart

  // Remove item from cart
  void removeFromCart(Coffee coffee) {
    Provider.of<CoffeeShop>(context, listen: false).removeItemFromCart(coffee);
  }

  // Update price based on size
  void smallSize(Coffee coffee) {
    setState(() {
      coffee.updatePrice('Small');
    });
  }

  void mediumSize(Coffee coffee) {
    setState(() {
      coffee.updatePrice('Medium');
    });
  }

  void largeSize(Coffee coffee) {
    setState(() {
      coffee.updatePrice('Large');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeShop>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Text(
                'Your Cart',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: value.userCart.length,
                  itemBuilder: (context, index) {
                    // Get individual cart item
                    Coffee eachCoffee = value.userCart[index];
                    return CartItemTile(
                      coffee: eachCoffee,
                      onRemove: removeFromCart,
                      onSmall: smallSize,
                      onMedium: mediumSize,
                      onLarge: largeSize,
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 97, 83, 83),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 4, 4, 4),
                        fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
