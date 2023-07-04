import 'dart:async';

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensor_track/presentation/widgets/item_card_widget.dart';
import 'package:sensors_plus/sensors_plus.dart';

class FeatBPage extends StatefulWidget {
  const FeatBPage({super.key});

  @override
  State<FeatBPage> createState() => _FeatBPageState();
}

class _FeatBPageState extends State<FeatBPage> {
  String _manufacturer = '';
  String _model = '';
  String _buildNumber = '';
  String _sdkVersion = '';
  String _versionCode = '';
  int _refreshRate = 1;
  StreamSubscription<AccelerometerEvent>? accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDeviceInformation();
    });
    _startAccelerometer();
  }

  void _getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    ThemeData theme = Theme.of(context);

    if (theme.platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        _manufacturer = androidInfo.manufacturer;
        _model = androidInfo.model;
        _buildNumber = androidInfo.version.release;
        _sdkVersion = androidInfo.version.sdkInt.toString();
        _versionCode = androidInfo.version.codename;
      });
    } else if (theme.platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        _model = iosInfo.model;
        _buildNumber = iosInfo.systemVersion;
      });
    }
  }

  void _startAccelerometer() {
    accelerometerSubscription = accelerometerEvents.listen(
      (AccelerometerEvent event) {
        setState(() {
          _refreshRate = (event.x.toInt() % 30) + 1;
        });
      },
      cancelOnError: false,
    );
  }

  @override
  void dispose() {
    accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        children: [
          ItemCardWidget(
            title: 'Data SoC',
            icon: const Icon(Icons.device_unknown),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manufacturer: $_manufacturer',
                  style: GoogleFonts.poppins(),
                ),
                Text(
                  'Model: $_model',
                  style: GoogleFonts.poppins(),
                ),
                Text(
                  'Build Number: $_buildNumber',
                  style: GoogleFonts.poppins(),
                ),
                Text(
                  'SDK Version: $_sdkVersion',
                  style: GoogleFonts.poppins(),
                ),
                Text(
                  'Version Code: $_versionCode',
                  style: GoogleFonts.poppins(),
                ),
              ],
            ),
          ),
          ItemCardWidget(
            title: 'Update Refresh Rate',
            icon: const Icon(Icons.refresh),
            subtitle: Text(
              '$_refreshRate seconds',
              style: GoogleFonts.poppins(
                color: Colors.blueAccent,
              ),
            ),
          ),
          ItemCardWidget(
            title: 'CRUD',
            icon: const Icon(Boxicons.bx_data),
            onTap: () {
              Navigator.pushNamed(context, '/crud');
            },
            subtitle: Text(
              'Create, Update, and Delete with sqflite',
              style: GoogleFonts.poppins(
                color: Colors.blueAccent,
              ),
            ),
          ),
          ItemCardWidget(
            title: 'QR CODE',
            icon: const Icon(Icons.qr_code),
            onTap: () {
              Navigator.pushNamed(context, '/qr-code');
            },
            subtitle: Text(
              'Generate QR code dari text yang diinput',
              style: GoogleFonts.poppins(
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
