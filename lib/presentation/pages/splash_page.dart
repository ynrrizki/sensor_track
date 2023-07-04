import 'dart:async';
import 'package:flutter/material.dart';

import 'package:sensor_track/presentation/widgets/logo_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double scale = 1.0;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _changeScale();
    });

    Timer(
      const Duration(milliseconds: 4000),
      () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (route) => false,
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _changeScale() {
    setState(() => scale = scale == 1.0 ? 0.95 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 300),
          child: const Hero(
            tag: 'logo',
            child: LogoWidget(),
          ),
        ),
      ),
    );
  }
}
