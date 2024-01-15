// ignore_for_file: unused_field, must_be_immutable
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';

class NavigationScreen extends StatefulWidget {
  double lat;
  double long;
  double sourceLat;
  double sourceLng;
  NavigationScreen({
    super.key,
    required this.lat,
    required this.long,
    required this.sourceLat,
    required this.sourceLng,
  });

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final directions = MapBoxNavigation();
  double? _distanceRemaining;
  double? _durationRemaining;
  bool? _arrived;
  String? _instruction;
  bool _routeBuilt = false;
  bool _isNavigating = false;
  bool _isMultipleStop = false;
  Future<void> _onRouteEvent(e) async {
    _distanceRemaining = await directions.getDistanceRemaining();
    _durationRemaining = await directions.getDurationRemaining();

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        _arrived = progressEvent.arrived;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        _routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        _routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        _isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        _arrived = true;
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          await directions.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        _routeBuilt = false;
        _isNavigating = false;
        break;
      default:
        break;
    }
    setState(() {});
  }

  void startNavigation() async {
    directions.registerRouteEventListener(_onRouteEvent);

    final routeOptions = MapBoxOptions(
      initialLatitude: widget.sourceLat,
      initialLongitude: widget.sourceLng,
      zoom: 16.0,
      tilt: 0.0,
      bearing: 0.0,
      enableRefresh: true,
      alternatives: true,
      voiceInstructionsEnabled: true,
      bannerInstructionsEnabled: true,
      allowsUTurnAtWayPoints: true,
      units: VoiceUnits.imperial,
      simulateRoute: true,
      animateBuildRoute: true,
      isOptimized: true,
      longPressDestinationEnabled: true,
      showEndOfRouteFeedback: true,
      showReportFeedbackButton: true,
      padding: EdgeInsets.all(8),
      mode: MapBoxNavigationMode.drivingWithTraffic,
      mapStyleUrlDay: 'mapbox://styles/mahmoudhabib/clqy80447012y01o9eqmuavao/',
    );
    directions.setDefaultOptions(routeOptions);
    await directions.startNavigation(
      wayPoints: [
        WayPoint(
          name: "Origin",
          latitude: widget.sourceLat,
          longitude: widget.sourceLng,
        ),
        WayPoint(
          name: "Destination",
          latitude: widget.lat,
          longitude: widget.long,
        ),
      ],
      options: routeOptions,
    );
  }

  @override
  void dispose() {
    directions.finishNavigation();

    super.dispose();
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
      body: FadeInLeft(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Image.asset(AppImages.mapman),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    startNavigation();
                  },
                  child: Text(
                    'follow_order_on_map'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
