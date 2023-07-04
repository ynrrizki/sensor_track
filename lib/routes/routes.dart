import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensor_track/presentation/pages/auth/signin/signin_page.dart';
import 'package:sensor_track/presentation/pages/auth/signup/signup_page.dart';
import 'package:sensor_track/presentation/pages/camera/camera_page.dart';
import 'package:sensor_track/presentation/pages/crud/crud_page.dart';
import 'package:sensor_track/presentation/pages/feat_a/feat_a_page.dart';
import 'package:sensor_track/presentation/pages/gps_maps/location_map_page.dart';
import 'package:sensor_track/presentation/pages/home/home_page.dart';
import 'package:sensor_track/presentation/pages/qr_code/qr_code_page.dart';
import 'package:sensor_track/presentation/pages/splash_page.dart';

class AppRouter {
  Route onRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return CupertinoPageRoute(
          builder: (context) => const SplashPage(),
        );
      case "/signin":
        return CupertinoPageRoute(
          builder: (context) => const SignInPage(),
        );
      case "/signup":
        return CupertinoPageRoute(
          builder: (context) => const SignUpPage(),
        );
      case "/home":
        return CupertinoPageRoute(
          builder: (context) => const HomePage(),
        );
      case "/feat-a":
        return CupertinoPageRoute(
          builder: (context) => const FeatAPage(),
        );
      case "/qr-code":
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => const QrCodePage(),
        );
      case "/crud":
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => const CrudPage(),
        );
      case "/camera":
        return CupertinoPageRoute(
          builder: (context) => const CameraPage(),
        );
      case "/gmaps":
        return CupertinoPageRoute(
          builder: (context) => const LocationMapPage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text(
            '404 Not Found',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
