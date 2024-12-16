import 'package:coffee_shop/components/app_drawer.dart';
import 'package:coffee_shop/pages/menu_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

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
  final List<String> _images = [
    'lib/images/latte.png',
    'lib/images/latte-art.png',
    'lib/images/coffee-cup.png',
    'lib/images/coffee-plant.png',
    'lib/images/coffee.png',
  ];

  final List<Color> _colors = [
    const Color.fromARGB(135, 4, 249, 217),
    const Color.fromARGB(180, 22, 6, 245),
    const Color.fromARGB(134, 73, 236, 8),
    Colors.orange,
    Colors.pink,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.red,
  ];

  late Random _random;

  String? _currentQuote;
  int _quoteIndex = 0;
  Color _colorText = Colors.white;
  late Timer _quoteTimer;

  @override
  void initState() {
    super.initState();

    _random = Random();

    _currentQuote = _quotes[_quoteIndex];

    _quoteTimer = Timer.periodic(Duration(seconds: 1), _changeQuote);

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: -4 * pi)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.forward();
  }

  void _changeQuote(Timer timer) {
    setState(() {
      _quoteIndex = (_quoteIndex + 1) % _quotes.length;
      _currentQuote = _quotes[_quoteIndex];

      _colorText = _colors[_random.nextInt(_colors.length)];
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
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    Colors.orange,
                    Colors.pink,
                    const Color.fromARGB(255, 169, 169, 16),
                    const Color.fromARGB(255, 10, 100, 136),
                    Colors.white
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Welcome to Brewed Awakening',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 208, 15, 15),
                          Colors.pink,
                          const Color.fromARGB(255, 59, 255, 88),
                          Colors.purple,
                          Colors.white,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 100,
              child: Text(
                _currentQuote ?? '',
                style: TextStyle(
                  color: _colorText,
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
                    'Grab a Coffee, Check the Menu=>',
                    style: TextStyle(
                      color: _colorText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color.fromARGB(255, 35, 15, 1),
                      decorationThickness: 2.0,
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
