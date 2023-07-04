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
  late LocationPermission permission;
  late Position position;
  static double lat = lat;
  static double long = long;
  late StreamSubscription<Position> positionStream;
  @override
  void initState() {
    checkGPS();
    super.initState();
  }

  checkGPS() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          debugPrint('Location permissions are permanently denied');
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }

      if (hasPermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      debugPrint("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude;
    lat = position.latitude;

    setState(() {
      //refresh UI
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLocation = LatLng(lat, long);
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
