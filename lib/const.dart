import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv to access environment variables
import 'package:flutter/material.dart';

// Access the secret key from the .env file
String stripeSecretKey = dotenv.env['STRIPE_SECRET_KEY'] ?? 'default_value';

// Your other constants
var backgroundColor = const Color.fromARGB(108, 255, 246, 246);

// Stripe Publishable Key (it's okay to hardcode this, as it's used on the client side)
const String stripePublishableKey =
    "pk_live_51QYpraRw1MFCA0muTzS9OQGXe2dQPGThRSYWnwFoWjaI0f5tOsRh1b6Yl9T1IuRgyqnmJKzL00zJ0X32jtY2BSCg0088lHTeKK";
