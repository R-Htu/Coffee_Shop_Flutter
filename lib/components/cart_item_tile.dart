import 'package:coffeeshop/model/coffee.dart';
import 'package:flutter/material.dart';

class CartItemTile extends StatefulWidget {
  final Coffee coffee;
  final Function(Coffee) onRemove;
  final Function(Coffee) onSmall;
  final Function(Coffee) onMedium;
  final Function(Coffee) onLarge;

  const CartItemTile({
    super.key,
    required this.coffee,
    required this.onRemove,
    required this.onSmall,
    required this.onMedium,
    required this.onLarge,
  });

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  // Track the active states of the buttons
  bool isAddActive = false;
  bool isMinusActive = false;
  bool isDeleteActive = false;
  bool isSmallActive = false;
  bool isMediumActive = false;
  bool isLargeActive = false;

  // Methods to increase, decrease, or remove quantity
  void _increaseQuantity() {
    setState(() {
      isAddActive = true; // Change Add button color to active
      widget.coffee.updateQuantity(1); // Increase quantity
      widget.coffee
          .updatePrice(widget.coffee.name); // Recalculate price based on size
    });

    // Reset active state after 1 second
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isAddActive = false;
      });
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (widget.coffee.quantity > 1) {
        widget.coffee.updateQuantity(-1); // Decrease quantity
        widget.coffee
            .updatePrice(widget.coffee.name); // Recalculate price based on size
      }
      isMinusActive = true; // Change Minus button color to active
    });

    // Reset active state after 1 second
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isMinusActive = false;
      });
    });
  }

  void _setSize(String size) {
    setState(() {
      isSmallActive = size == 'Small';
      isMediumActive = size == 'Medium';
      isLargeActive = size == 'Large';
    });

    widget.coffee.updatePrice(size); // Update price based on size

    // Reset active state after 1 second
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isSmallActive = false;
        isMediumActive = false;
        isLargeActive = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 97, 83, 83),
      elevation: 5, // Add shadow for a more card-like look
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Coffee Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(widget.coffee.imagePath,
                  height: 100, width: 100, fit: BoxFit.cover),
            ),
            SizedBox(width: 16),

            // Coffee details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Coffee Name and Quantity
                  Text(
                    widget.coffee.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${widget.coffee.quantity} x \$${widget.coffee.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 248, 239, 239)),
                  ),

                  SizedBox(height: 10),

                  // Size Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _sizeButton('S', isSmallActive, () {
                        widget.onSmall(widget.coffee);
                        _setSize('Small');
                      }),
                      SizedBox(width: 10),
                      _sizeButton('M', isMediumActive, () {
                        widget.onMedium(widget.coffee);
                        _setSize('Medium');
                      }),
                      SizedBox(width: 10),
                      _sizeButton('L', isLargeActive, () {
                        widget.onLarge(widget.coffee);
                        _setSize('Large');
                      }),
                    ],
                  ),
                ],
              ),
            ),

            // Quantity Buttons (Add, Minus, Remove)
            Column(
              children: [
                _actionButton(Icons.add, isAddActive, _increaseQuantity),
                SizedBox(height: 8),
                _actionButton(Icons.remove, isMinusActive, _decreaseQuantity),
                SizedBox(height: 8),
                _actionButton(Icons.delete, isDeleteActive, () {
                  setState(() {
                    isDeleteActive =
                        true; // Change Delete button color to active
                  });

                  // Call the remove function passed from CartPage
                  widget
                      .onRemove(widget.coffee); // This will call removeFromCart

                  // Reset active state after 1 second
                  Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      isDeleteActive = false;
                    });
                  });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Action button (Add, Remove, Delete)
  Widget _actionButton(IconData icon, bool isActive, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: isActive
            ? const Color.fromARGB(255, 77, 82, 77) // Active color
            : const Color.fromARGB(255, 157, 135, 127), // Default color
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  // Size button for S, M, L
  Widget _sizeButton(String size, bool isActive, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? const Color.fromARGB(
                  255, 156, 161, 156) // Active color for size
              : const Color.fromARGB(255, 111, 93, 86), // Default color
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          size,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
