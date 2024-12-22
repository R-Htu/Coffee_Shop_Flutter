import 'package:coffeeshop/model/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {
  void Function()? onPressed;
  final Coffee coffee;
  final Widget icon; // Use the icon widget passed in

  CoffeeTile(
      {super.key,
      required this.coffee,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 97, 83, 83),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        title: Text(
          coffee.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.brown[800],
          ),
        ),
        subtitle: Text(
          '\$${coffee.price}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 207, 187, 180),
          ),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(coffee.imagePath,
              width: 50, height: 50, fit: BoxFit.cover),
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}
