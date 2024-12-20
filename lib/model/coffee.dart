class Coffee {
  final String name;
  String price; // Make price mutable
  final String imagePath;
  double basePrice; // Base price to start from
  int quantity; // Track quantity for this coffee

  Coffee({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.basePrice,
    this.quantity = 1, // Default to 1 if not specified
  });

  // Method to update the price based on the size
  void updatePrice(String size) {
    if (size == 'Medium') {
      price = (basePrice + 0.80).toStringAsFixed(2); // Increase by 50 cents
    } else if (size == 'Large') {
      price = (basePrice + 1.60).toStringAsFixed(2); // Increase by 1 dollar
    } else {
      price = basePrice.toStringAsFixed(2); // Small size, no price change
    }
  }

  // Method to update price based on quantity
  void updateQuantity(int delta) {
    quantity += delta;
    if (quantity < 1) quantity = 1; // Ensure quantity doesn't go below 1
  }

  // Method to calculate total price based on quantity and size
  double get totalPrice {
    double currentPrice = double.parse(price);
    return currentPrice * quantity;
  }
}
