import 'package:flutter/material.dart';
import 'gradient_color.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  final String title = "НОНТОН РФ";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.2, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 1.0),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.6, 1.0),
      ),
    );

    _controller.forward().whenComplete(() {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GetGradientBackgroundScreen(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: _animation.value,
              child: Image.asset(
                'assets/img/logo.png',
                height: 150,
                width: 150,
              ),
            ),
            SizedBox(height: 16.0),
            SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return GetGradientText(bounds);
                  },
                  child: DefaultTextStyle(
                    child: Text(
                      title,
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
