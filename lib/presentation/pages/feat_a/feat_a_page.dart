import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:sensor_track/presentation/widgets/item_card_widget.dart';
import 'package:sensor_track/presentation/widgets/sparator_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:sensors/sensors.dart' as sensors;
import 'package:sensors_plus/sensors_plus.dart';

class FeatAPage extends StatefulWidget {
  const FeatAPage({super.key});

  @override
  State<FeatAPage> createState() => _FeatAPageState();
}

class _FeatAPageState extends State<FeatAPage> {
  late DeviceInfoPlugin deviceInfo;
  late Battery battery;
  late int percentage;
  late String _accelerometerValues;
  late String _gyroscopeValues;
  late String _magnetometerValues;
  late String latitude;
  late String longitude;

  late StreamSubscription<AccelerometerEvent> accelerometerSubscription;
  late StreamSubscription<GyroscopeEvent> gyroscopeSubscription;
  late StreamSubscription<MagnetometerEvent> magnetometerSubscription;

  @override
  void initState() {
    super.initState();
    deviceInfo = DeviceInfoPlugin();
    battery = Battery();
    percentage = 0;
    _accelerometerValues = '...';
    _gyroscopeValues = '...';
    _magnetometerValues = '...';
    latitude = '...';
    longitude = '...';
    getBatteryPercentage();
    getLocation();
    getSensorsEvents();
  }

  @override
  void dispose() {
    accelerometerSubscription.cancel();
    gyroscopeSubscription.cancel();
    magnetometerSubscription.cancel();
    super.dispose();
  }

  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();

    setState(() {});
  }

  void getBatteryPercentage() async {
    final level = await battery.batteryLevel;
    percentage = level;

    setState(() {});
  }

  void getSensorsEvents() {
    accelerometerSubscription = accelerometerEvents.listen(
      (AccelerometerEvent event) {
        setState(() {
          _accelerometerValues =
              'X: ${event.x.toStringAsFixed(2)}, Y: ${event.y.toStringAsFixed(2)}, Z: ${event.z.toStringAsFixed(2)}';
        });
      },
      onError: (error) {
        _accelerometerValues = 'Not Work';
      },
      cancelOnError: false,
    );

    gyroscopeSubscription = gyroscopeEvents.listen(
      (GyroscopeEvent event) {
        setState(() {
          _gyroscopeValues =
              'X: ${event.x.toStringAsFixed(2)}, Y: ${event.y.toStringAsFixed(2)}, Z: ${event.z.toStringAsFixed(2)}';
        });
      },
      onError: (error) {
        _gyroscopeValues = 'Not Work';
      },
      cancelOnError: false,
    );

    magnetometerSubscription = magnetometerEvents.listen(
      (MagnetometerEvent event) {
        setState(() {
          _magnetometerValues =
              'X: ${event.x.toStringAsFixed(2)}, Y: ${event.y.toStringAsFixed(2)}, Z: ${event.z.toStringAsFixed(2)}';
        });
      },
      onError: (error) {
        _magnetometerValues = 'Not Work';
      },
      cancelOnError: false,
    );
  }

  Future<AndroidDeviceInfo> getHardwareInfo() async {
    return await deviceInfo.androidInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: FutureBuilder(
        future: getHardwareInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final androidInfo = snapshot.data!;
            List<Widget> sensorDataCards = [
              ItemCardWidget(
                title: 'Accelerometer',
                icon: const Icon(Icons.directions_run),
                subtitle: Text(
                  '${androidInfo.hardware} $_accelerometerValues',
                ),
              ),
              ItemCardWidget(
                title: 'Gyroscope',
                icon: const Icon(Icons.track_changes),
                subtitle: Text(
                  '${androidInfo.hardware} $_gyroscopeValues',
                ),
              ),
              ItemCardWidget(
                title: 'Magnetometer',
                icon: const Icon(Icons.explore),
                subtitle: Text(
                  '${androidInfo.hardware} $_magnetometerValues',
                ),
              ),
            ];
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              children: [
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 2,
                  ),
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.date_range,
                                size: 80,
                                color: Colors.blueAccent,
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('h:mm a', 'id_ID')
                                        .format(DateTime.now()),
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('EEEE, d MMMM y', 'id_ID')
                                        .format(DateTime.now()),
                                    style: GoogleFonts.poppins(
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        child: Center(
                          child: CircularPercentIndicator(
                            radius: 50,
                            backgroundWidth: 10,
                            lineWidth: 10,
                            percent: percentage / 100,
                            progressColor: Colors.blueAccent,
                            backgroundColor: Colors.blue.shade100,
                            circularStrokeCap: CircularStrokeCap.round,
                            animateFromLastPercent: true,
                            animation: true,
                            animationDuration: 500,
                            footer: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Battery',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueAccent,
                                      // color: Colors.green,
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: -1.6,
                                    child: const Icon(
                                      Boxicons.bxs_battery_full,
                                      color: Colors.blueAccent,
                                      // color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            center: Text(
                              '$percentage%',
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SparatorWIdget(title: 'Sensor'),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sensorDataCards.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) =>
                      AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: MediaQuery.of(context).size.width / 2,
                      curve: Curves.easeOutExpo,
                      child: FadeInAnimation(
                        child: sensorDataCards[index],
                      ),
                    ),
                  ),
                ),
                const SparatorWIdget(title: 'Location'),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        horizontalOffset: MediaQuery.of(context).size.width / 2,
                        child: FadeInAnimation(
                          child: ItemCardWidget(
                            title: 'GPS',
                            icon: const Icon(Icons.gps_fixed),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Latitude: $latitude',
                                  style: GoogleFonts.poppins(
                                    color: Colors.blueAccent,
                                  ),
                                  softWrap: true,
                                ),
                                Text(
                                  'Longitude: $longitude',
                                  style: GoogleFonts.poppins(
                                    color: Colors.blueAccent,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
