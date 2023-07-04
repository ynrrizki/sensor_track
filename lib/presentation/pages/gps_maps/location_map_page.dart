import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMapPage extends StatefulWidget {
  const LocationMapPage({Key? key}) : super(key: key);

  @override
  State<LocationMapPage> createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {
  bool isLocationServiceEnabled = false;
  bool hasLocationPermission = false;
  late LocationPermission locationPermission;
  late Position currentPosition;
  static double latitude = 0.0;
  static double longitude = 0.0;
  late StreamSubscription<Position> positionStream;
  late GoogleMapController mapController;
  final Map<String, Marker> markers = {};

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
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

  Future<void> goToMyLocation() async {
    final myPosition = LatLng(latitude, longitude);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(myPosition, 18));
    setState(() {
      markers['My Location'] = Marker(
        markerId: const MarkerId("My Location"),
        position: myPosition,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const companyLocation = LatLng(-6.263898974321196, 106.87595139894879);
    final currentLocation = LatLng(latitude, longitude);

    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 14,
        ),
        mapType: MapType.normal,
        onMapCreated: (controller) {
          mapController = controller;
          addMarker(
            "userLocation",
            currentLocation,
            BitmapDescriptor.defaultMarker,
            "My Location",
            "$latitude, $longitude",
          );
          addMarker(
            "synapsis.Id",
            companyLocation,
            BitmapDescriptor.defaultMarker,
            "Company",
            "A Start-Up Company that working on system prototyping especially Internet of Things, Electronics Devices, and Monitoring Systems.",
          );
        },
        markers: markers.values.toSet(),
        zoomControlsEnabled: false,
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 50),
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: 'location',
              onPressed: goToMyLocation,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.my_location,
                size: 30,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addMarker(
    String id,
    LatLng location,
    BitmapDescriptor customIcon,
    String title,
    String? description,
  ) {
    final marker = Marker(
      markerId: MarkerId(id),
      position: location,
      icon: customIcon,
      infoWindow: InfoWindow(
        title: title,
        snippet: description,
      ),
    );

    markers[id] = marker;
    setState(() {});
  }
}
