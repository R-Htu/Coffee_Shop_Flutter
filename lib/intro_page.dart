import 'package:coffee_shop/components/app_drawer.dart';
import 'package:coffee_shop/home_page.dart';
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
    const Color.fromARGB(134, 12, 69, 61),
    const Color.fromARGB(180, 22, 6, 245),
    const Color.fromARGB(133, 22, 66, 5),
    const Color.fromARGB(255, 101, 61, 2),
    const Color.fromARGB(255, 73, 6, 28),
    const Color.fromARGB(255, 4, 90, 7),
    Colors.blue,
    const Color.fromARGB(255, 61, 1, 72),
    const Color.fromARGB(255, 67, 10, 6),
  ];

  late Random _random;

  String? _currentQuote;
  int _quoteIndex = 0;
  Color _colorText = Colors.black;
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
          color: const Color.fromARGB(255, 138, 2, 2),
        ),
      ),
      drawer: AppDrawer(),
      backgroundColor: const Color.fromARGB(255, 248, 239, 238),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 223, 135, 4),
                    const Color.fromARGB(255, 240, 5, 83),
                    const Color.fromARGB(255, 236, 7, 7),
                    const Color.fromARGB(255, 34, 222, 5),
                    const Color.fromARGB(255, 21, 1, 1)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Welcome to Brewed Awakening',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 208, 15, 15),
                          const Color.fromARGB(255, 172, 223, 3),
                          const Color.fromARGB(255, 59, 255, 88),
                          const Color.fromARGB(255, 13, 210, 240),
                          const Color.fromARGB(255, 238, 5, 5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
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
                width: 250,
                height: 250,
              ),
            ),
            SizedBox(
              height: 100,
              child: Text(
                _currentQuote ?? '',
                style: TextStyle(
                  color: const Color.fromARGB(255, 39, 52, 40),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 70,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 11, 1, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(30)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    '<<Grab a Coffee, Check the Menu>>',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 144, 2, 2),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.underline,
                      decorationColor: const Color.fromARGB(255, 35, 15, 1),
                      decorationThickness: 5.0,
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
