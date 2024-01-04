import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:storeapp/core/colors.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  Location _location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LatLng? _currentLatLng;
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;

  checkUserLocation() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await _location.requestService();
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }
    LocationData _locationData = await _location.getLocation();
    setState(() {
      _currentLatLng =
          LatLng(_locationData.latitude!, _locationData.longitude!);
      _initialCameraPosition =
          CameraPosition(target: _currentLatLng!, zoom: 15);
    });
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  @override
  void initState() {
    checkUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              _initialCameraPosition,
            ),
          );
        },
        child: const Icon(Icons.my_location),
      ),
      body: _currentLatLng == null
          ? Center(
              child: CircularProgressIndicator(color: AppColors.red),
            )
          : MapboxMap(
              accessToken:
                  "pk.eyJ1IjoibWFobW91ZGhhYmliIiwiYSI6ImNscXh6YWtiZzA0bDQycGxsOGF0dmJzc3YifQ.m-x2FCK7JR_XikXNH5RH5w",
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
              minMaxZoomPreference: MinMaxZoomPreference(14, 17),
            ),
    );
  }
}
