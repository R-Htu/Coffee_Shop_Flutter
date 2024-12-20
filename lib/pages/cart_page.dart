import 'package:coffee_shop/components/cart_item_tile.dart';
import 'package:coffee_shop/model/coffee.dart';
import 'package:coffee_shop/model/coffee_shop.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
