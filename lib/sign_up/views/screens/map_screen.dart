import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:storeapp/core/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> markers = [];
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
          'd_location'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: latLng.LatLng(51.5, -0.09),
              onTap: (position, latlng) {
                setState(() {
                  markers.clear();
                  markers.add(
                    Marker(
                      width: 150.0,
                      height: 150.0,
                      point: latlng,
                      builder: (ctx) => const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 35.0,
                      ),
                    ),
                  );
                });
              },
              zoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/mahmoudhabib/clqjpcx4v00n201o36nb8gfip/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFobW91ZGhhYmliIiwiYSI6ImNscWpuMDQxdzI3ZDcyaW1lMmo0cHM4ZnAifQ.oyF5f0Hnu5LO2BxskCUIkQ',
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoibWFobW91ZGhhYmliIiwiYSI6ImNscWpuMDQxdzI3ZDcyaW1lMmo0cHM4ZnAifQ.oyF5f0Hnu5LO2BxskCUIkQ',
                  'id': 'mapbox.mapbox-streets-v8',
                },
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [for (int i = 0; i < markers.length; i++) markers[i]],
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.8,
            right: MediaQuery.of(context).size.width * 0.1,
            child: FadeInLeft(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'd_location'.tr,
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
            ),
          ),
        ],
      ),
    );
  }
}
