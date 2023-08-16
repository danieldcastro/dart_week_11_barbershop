import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _scale = 10.0;
  double _animationOpacityLogo = 0.0;

  double get _logoAnimationWidth => 100 * _scale;
  double get _logoAnimationHeight => 120 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _scale = 1.0;
        _animationOpacityLogo = 1.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .2,
            image: AssetImage(
              'assets/images/background_image_chair.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: AnimatedOpacity(
          onEnd: () {
            Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  settings: const RouteSettings(name: '/auth/login'),
                  transitionsBuilder: (_, animation, __, child) =>
                      FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const LoginPage(),
                ),
                (route) => false);
          },
          duration: const Duration(seconds: 3),
          curve: Curves.easeIn,
          opacity: _animationOpacityLogo,
          child: Center(
            child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.linearToEaseOut,
                width: _logoAnimationWidth,
                height: _logoAnimationHeight,
                child: Image.asset(
                  'assets/images/imgLogo.png',
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
