import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:dw_barbershop/src/features/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ui/helpers/messages.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
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
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(
        error: (error, stackTrace) {
          log('Erro ao validar o login', error: error, stackTrace: stackTrace);
          Messages.showError('Erro ao validar o login', context);
          Navigator.pushNamedAndRemoveUntil(
              context, '/auth/login', (route) => false);
        },
        data: (data) {
          switch (data) {
            case SplashState.loggedADM:
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home/adm', (route) => false);
            case SplashState.loggedEmployee:
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home/employee', (route) => false);
            case _:
              Navigator.pushNamedAndRemoveUntil(
                  context, '/auth/login', (route) => false);
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .2,
            image: AssetImage(ConstantImages.backgroundChair),
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
                  ConstantImages.imageLogo,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
