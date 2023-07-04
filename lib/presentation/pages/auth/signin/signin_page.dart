// import 'dart:async';
// import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensor_track/presentation/widgets/logo_widget.dart';
import 'package:sensor_track/presentation/widgets/text_field_widget.dart';

// enum _SupportState {
//   unknown,
//   supported,
//   unsupported,
// }

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final LocalAuthentication auth = LocalAuthentication();
  // _SupportState _supportState = _SupportState.unknown;
  // bool? _canCheckBiometrics;
  // List<BiometricType>? _availableBiometrics;
  // String _authorized = 'Not Authorized';
  // bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    // auth.isDeviceSupported().then(
    //       (bool isSupported) => setState(() => _supportState = isSupported
    //           ? _SupportState.supported
    //           : _SupportState.unsupported),
    //     );
  }

  // Future<void> _checkBiometrics() async {
  //   late bool canCheckBiometrics;
  //   try {
  //     canCheckBiometrics = await auth.canCheckBiometrics;
  //   } on PlatformException catch (e) {
  //     canCheckBiometrics = false;
  //     log(e.toString());
  //   }
  //   if (!mounted) {
  //     return;
  //   }

  //   setState(() {
  //     _canCheckBiometrics = canCheckBiometrics;
  //   });
  // }

  // Future<void> _getAvailableBiometrics() async {
  //   late List<BiometricType> availableBiometrics;
  //   try {
  //     availableBiometrics = await auth.getAvailableBiometrics();
  //   } on PlatformException catch (e) {
  //     availableBiometrics = <BiometricType>[];
  //     log(e.toString());
  //   }
  //   if (!mounted) {
  //     return;
  //   }

  //   setState(() {
  //     _availableBiometrics = availableBiometrics;
  //   });
  // }

  // Future<void> _authenticate() async {
  //   bool authenticated = false;
  //   try {
  //     setState(() {
  //       _isAuthenticating = true;
  //       _authorized = 'Authenticating';
  //     });
  //     authenticated = await auth.authenticate(
  //       localizedReason: 'Let OS determine authentication method',
  //       options: const AuthenticationOptions(
  //         stickyAuth: true,
  //       ),
  //     );
  //     setState(() {
  //       _isAuthenticating = false;
  //     });
  //   } on PlatformException catch (e) {
  //     print(e);
  //     setState(() {
  //       _isAuthenticating = false;
  //       _authorized = 'Error - ${e.message}';
  //     });
  //     return;
  //   }
  //   if (!mounted) {
  //     return;
  //   }

  //   setState(
  //       () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  // }

  // Future<void> _authenticateWithBiometrics() async {
  //   bool authenticated = false;
  //   try {
  //     setState(() {
  //       _isAuthenticating = true;
  //       _authorized = 'Authenticating';
  //     });
  //     authenticated = await auth.authenticate(
  //       localizedReason:
  //           'Scan your fingerprint (or face or whatever) to authenticate',
  //       options: const AuthenticationOptions(
  //         stickyAuth: true,
  //         biometricOnly: true,
  //       ),
  //     );
  //     setState(() {
  //       _isAuthenticating = false;
  //       _authorized = 'Authenticating';
  //     });
  //   } on PlatformException catch (e) {
  //     log(e.toString());
  //     setState(() {
  //       _isAuthenticating = false;
  //       _authorized = 'Error - ${e.message}';
  //     });
  //     return;
  //   }
  //   if (!mounted) {
  //     return;
  //   }

  //   final String message = authenticated ? 'Authorized' : 'Not Authorized';
  //   setState(() {
  //     _authorized = message;
  //   });
  // }

  // Future<void> _cancelAuthentication() async {
  //   await auth.stopAuthentication();
  //   setState(() => _isAuthenticating = false);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Hero(
                tag: 'logo',
                child: LogoWidget(radius: 75),
              ),
              const SizedBox(height: 50),
              Text(
                'Welcome back you\'ve been missed!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 25),
              TextFieldWidget(
                controller: TextEditingController(),
                hintText: 'Username',
              ),
              const SizedBox(height: 25),
              TextFieldWidget(
                controller: TextEditingController(),
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: Center(
                    child: Text(
                      'Sign In',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Divider(
              //           thickness: 0.5,
              //           color: Colors.grey[400],
              //         ),
              //       ),
              //       const Padding(
              //         padding: EdgeInsets.symmetric(horizontal: 15),
              //         child: Text('Continue option'),
              //       ),
              //       Expanded(
              //         child: Divider(
              //           thickness: 0.5,
              //           color: Colors.grey[400],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 50),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     // ElevatedButton(
              //     //   onPressed: _authenticateWithBiometrics,
              //     //   style: ElevatedButton.styleFrom(
              //     //     padding: const EdgeInsets.symmetric(
              //     //       vertical: 25,
              //     //       horizontal: 25,
              //     //     ),
              //     //     elevation: 0,
              //     //     side: const BorderSide(color: Colors.white),
              //     //     backgroundColor: Colors.blue.shade100,
              //     //     foregroundColor: Colors.black,
              //     //   ),
              //     //   child: const Icon(Icons.fingerprint),
              //     // ),
              //     // ElevatedButton(
              //     //   onPressed: () {},
              //     //   style: ElevatedButton.styleFrom(
              //     //     padding: const EdgeInsets.symmetric(
              //     //       vertical: 25,
              //     //       horizontal: 25,
              //     //     ),
              //     //     elevation: 0,
              //     //     side: const BorderSide(color: Colors.white),
              //     //     backgroundColor: Colors.blue.shade100,
              //     //     foregroundColor: Colors.black,
              //     //   ),
              //     //   child: const Icon(Icons.nfc),
              //     // ),
              //     // ElevatedButton(
              //     //   onPressed: () {},
              //     //   style: ElevatedButton.styleFrom(
              //     //     padding: const EdgeInsets.symmetric(
              //     //       vertical: 25,
              //     //       horizontal: 25,
              //     //     ),
              //     //     elevation: 0,
              //     //     side: const BorderSide(color: Colors.white),
              //     //     backgroundColor: Colors.blue.shade100,
              //     //     foregroundColor: Colors.black,
              //     //   ),
              //     //   child: const Icon(Icons.qr_code),
              //     // ),
              //   ],
              // ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
