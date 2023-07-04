import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sensor_track/presentation/widgets/grap_card_widget.dart';

class FeatCPage extends StatefulWidget {
  const FeatCPage({Key? key}) : super(key: key);

  @override
  State<FeatCPage> createState() => _FeatCPageState();
}

class _FeatCPageState extends State<FeatCPage> {
  bool serviceStatus = false;
  bool hasPermission = false;
  late Position position;
  late double latitude;
  late double longitude;
  late StreamSubscription<Position> positionStream;
  @override
  void initState() {
    latitude = 37.43296265331129;
    longitude = -122.08832357078792;
    getLocation();
    super.initState();
  }

  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latitude = position.latitude;
    longitude = position.longitude;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLocation = LatLng(latitude, longitude);
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        children: [
          const GrapCardWidget(),
          const GrapCardWidget(),
          const GrapCardWidget(),
          Card(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/gmaps');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.grey,
                      // image: DecorationImage(
                      //   image: MemoryImage(screenshot),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: currentLocation,
                        zoom: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 15,
                    ),
                    child: Text(
                      'GPS Map',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
