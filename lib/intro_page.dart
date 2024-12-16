import 'package:coffee_shop/components/app_drawer.dart';
import 'package:coffee_shop/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Import Timer
import 'dart:math'; // Import for using Pi

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  final List<String> _quotes = [
    "Coffee: because adulting is hard.",
    "Espresso yourself and stay grounded.",
    "Life begins after coffee."
  ];

  String? _currentQuote;
  int _quoteIndex = 0;
  late Timer _quoteTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: -4 * pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.forward();
    _currentQuote = _quotes[_quoteIndex];
    _quoteTimer = Timer.periodic(Duration(seconds: 2), _changeQuote);
  }

  void _changeQuote(Timer timer) {
    setState(() {
      _quoteIndex = (_quoteIndex + 1) % _quotes.length;
      _currentQuote = _quotes[_quoteIndex];
    });
  }

  @override
  void dispose() {
    _quoteTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: AppDrawer(),
      backgroundColor: const Color.fromARGB(255, 28, 9, 6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to Brewed Awakening',
              style: TextStyle(color: Colors.amber, fontSize: 25),
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 100,
              child: Text(
                _currentQuote ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: child,
                );
              },
              child: Image.asset(
                'lib/images/latte-art.png',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 254, 248, 248),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    'Grab a Coffee, Check the Menu',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 178, 71, 4),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
