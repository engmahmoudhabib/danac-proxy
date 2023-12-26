import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:storeapp/core/constants.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/home/controllers/navigation_controller.dart';
import 'package:storeapp/home/views/widgets/bottom_bar.dart';
import 'package:storeapp/home/views/widgets/destination_box.dart';
import 'package:storeapp/home/views/widgets/directions_status_bar.dart';
import 'package:storeapp/home/views/widgets/search_bar.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    Get.put(NavigationController());
    return Obx(() => Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: homeController.initialCameraPosition,
                myLocationEnabled:
                    homeController.mapStatus.value != Constants.onDestination,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers: homeController.markers.values.toSet(),
                polylines: Set<Polyline>.of(homeController.polyline),
                onMapCreated: (GoogleMapController controller) async {
                  homeController.googleMapsController.complete(controller);
                  Position position =
                      await homeController.getMyCurrentLocation();
                  homeController.mapStatus.value = Constants.idle;
                  homeController.moveMapCamera(
                      LatLng(position.latitude, position.longitude));
                },
              ),
             Visibility(
                visible: homeController.mapStatus.value != Constants.onDestination,
                child:  Positioned(
                    top: 30,
                    left: 0,
                    child: SearchBar2(),
                ),
              ),
              Visibility(
                visible: homeController.mapStatus.value == Constants.route,
                child: Positioned(
                  top: 0,
                  left: 0,
                  child: DestinationBox(),
                ),
              ),
              Visibility(
                visible:
                    homeController.mapStatus.value == Constants.onDestination,
                child:
                    Positioned(top: 31, left: 0, child: DirectionsStatusBar()),
              ),
              Visibility(
                visible: homeController.mapStatus.value == Constants.idle,
                child: Positioned(
                    bottom: 30,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: () async {
                        Position position =
                            await homeController.getMyCurrentLocation();
                        homeController.moveMapCamera(
                            LatLng(position.latitude, position.longitude));
                      },
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        Constants.locateMeIcon,
                        scale: 4,
                      ),
                    )),
              ),
              Visibility(
                visible: homeController.mapStatus.value != Constants.idle,
                child: Positioned(
                  bottom: 0,
                  left: 0,
                  child: BottomBar(),
                ),
              )
            ],
          ),
        ));
  }
}













/* import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/images.dart';
import 'dart:math' show cos, asin, sqrt;

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  Location location = Location();
  LatLng destLocation = LatLng(100, 200);
  final Completer<GoogleMapController?> _controller = Completer();
  loc.LocationData? _currentPosition;
  getCurrrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    final GoogleMapController? controller = await _controller.future;
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    if (_permissionGranted == PermissionStatus.granted) {
      return;
    }
    if (_permissionGranted == loc.PermissionStatus.granted) {
      location.changeSettings(accuracy: loc.LocationAccuracy.high);
      _currentPosition = await location.getLocation();
      controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 16,
            target: LatLng(
              _currentPosition!.latitude!,
              _currentPosition!.longitude!,
            ),
          ),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getCurrrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'follow_order'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapToolbarEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: destLocation!,
              zoom: 16,
            ),
            onCameraMove: (position) {
              if (destLocation != position.target) {
                setState(() {
                  destLocation = position.target;
                });
              }
            },
            onMapCreated: (c) {
              _controller.complete(c);
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.pin,
              height: 30,
              width: 30,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(MyOrderLocation(lat: 50, long: 256,));
              },
              child: Text('click me')),
        ],
      ),
    );
  }
}

class MyOrderLocation extends StatefulWidget {
  double lat;
  double long;
  MyOrderLocation({
    super.key,
    required this.lat,
    required this.long,
  });

  @override
  State<MyOrderLocation> createState() => _MyOrderLocationState();
}

class _MyOrderLocationState extends State<MyOrderLocation> {
  final Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  StreamSubscription<loc.LocationData>? locationSubsription;

  @override
  void initState() {
    getNavigation();
    addMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
 */