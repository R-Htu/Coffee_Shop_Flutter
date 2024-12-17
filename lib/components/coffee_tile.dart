import 'package:coffee_shop/model/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeTile extends StatelessWidget {
  void Function()? onPressed;
  final Coffee coffee;
  CoffeeTile({
    super.key,
    required this.coffee,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 10),
      child: ListTile(
        title: Text(coffee.name),
        subtitle: Text(coffee.price),
        leading: Image.asset(coffee.imagePath),
        trailing:
            IconButton(onPressed: onPressed, icon: Icon(Icons.arrow_forward)),
      ),
    );
  }
}
