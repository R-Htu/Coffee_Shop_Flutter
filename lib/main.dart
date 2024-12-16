import 'package:coffee_shop/intro_page.dart';
import 'package:flutter/material.dart';

//  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// style: Theme.of(context).textTheme.headlineMedium,
/*  theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 8, 4, 3))),
      home: IntroPage(),
    );
  }
}
