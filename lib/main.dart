import 'package:coffeeshop/intro_page.dart';
import 'package:coffeeshop/model/coffee_shop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart'; // <-- Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env only for non-web platforms
  if (!kIsWeb) {
    await dotenv.load(fileName: ".env");
  }

  // Initialize Firebase
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform, // Firebase options for platform
  );

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
