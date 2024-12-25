import 'package:coffeeshop/const.dart';
import 'package:coffeeshop/intro_page.dart';
import 'package:coffeeshop/model/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env only for non-web platforms
  if (!kIsWeb) {
    await dotenv.load(fileName: ".env");
  }
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform, // Firebase options for platform
    );
    print('firebase intialized successfully!');
  } catch (e) {
    print('error initializing firebasse: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoffeeShop(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coffee',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 8, 4, 3),
          ),
        ),
        home: IntroPage(),
      ),
    );
  }
}
