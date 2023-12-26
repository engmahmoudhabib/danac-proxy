import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:storeapp/home/controllers/home_controller.dart';

class SearchBar2 extends StatelessWidget {
  const SearchBar2({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SearchGooglePlacesWidget(
        placeType: PlaceType.address,
        placeholder: 'Enter the address',
        apiKey: 'AIzaSyCFLz4IbxueyV7qpi6R59FmIuPgmL9F0OM',
        onSearch: (Place place) {},
        onSelected: (Place place) async {
          homeController.setDestination(place);
        },
      ),
    );
  }
}