import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/constants.dart';
import 'package:storeapp/home/models/cart_item_response_model.dart';
import 'package:storeapp/home/models/order_response_model.dart';
import 'package:storeapp/home/models/orders_response_model.dart';
import 'package:storeapp/home/models/points_response_model.dart';
import 'package:storeapp/home/models/search_products_response_model.dart';
import 'package:storeapp/home/models/special_products_response_model.dart';
import 'package:storeapp/home/providers/cart_provider.dart';
import 'package:storeapp/home/providers/orders_provider.dart';
import 'package:storeapp/home/providers/points_provider.dart';
import 'package:storeapp/home/providers/products_provider.dart';
import 'package:storeapp/home/views/screens/agent_home_screen.dart';
import 'package:storeapp/home/views/screens/agent_products_screen.dart';
import 'package:storeapp/home/views/screens/home_screen.dart';
import 'package:storeapp/home/views/widgets/add_to_cart_successfuly_dialog.dart';
import 'package:storeapp/home/views/widgets/order_success_dialog.dart';
import 'package:storeapp/notifications/views/screens/notifications_screen.dart';
import 'package:storeapp/settings/views/screens/settings_screen.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin{
  late PersistentTabController controller;
  RxBool isLoading = false.obs;
  RxBool isLoadingSearch = false.obs;
  RxBool isAddingToCart = false.obs;
  RxInt cartId = 0.obs;
  RxDouble cartItemsTotalPrice = 0.0.obs;
  RxString date = DateTime.now()
      .toString()
      .substring(0, DateTime.now().toString().indexOf(' '))
      .obs;
  TextEditingController? searchController = TextEditingController();
  RxList specialProducts = <SpecialProductsResponseModel>[].obs;
  RxList allProducts = <SearchlProductsResponseModel>[].obs;
  RxList searchProducts = <SearchlProductsResponseModel>[].obs;
  RxList cartItems = <GetCartItemsResponseModel>[].obs;
  RxList orders = <OrdersResponseModel>[].obs;
  RxList points = <PointsResponseModel>[].obs;
  final ProductsProvider _productsProvider = ProductsProvider();
  final CartProvider _cartProvider = CartProvider();
  final OrderProvider _orderProvider = OrderProvider();
  final PointsProvider _pointsProvider = PointsProvider();
  RxList order = <OrderResponseModel>[].obs;
late Completer<GoogleMapController> googleMapsController = Completer();
  var destination = "".obs;
  var distanceLeft = "".obs;
  var timeLeft = "".obs;
  var mapStatus = "".obs;
  var arrived = true.obs;
  var gettingRoute = false.obs;
  var markers = <MarkerId, Marker>{}.obs;
  List<LatLng> polylineCoordinates = <LatLng>[].obs;
  Set<Polyline> polyline = <Polyline>{}.obs;
  Animation<double>? animation;
  LatLng destinationCoordinates = const LatLng(0, 0);

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  getSpecialProducts() async {
    isLoading.value = true;
    final response = await _productsProvider.getSpecialProducts();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      specialProducts.clear();
      specialProducts.addAll(result!);
      specialProducts.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  getSearchProducts(bool isBarcode) async {
    isLoadingSearch.value = true;
    final response = await _productsProvider.getProductsByNameOrBarcode(
        searchController?.text, isBarcode);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      searchProducts.clear();
      searchProducts.addAll(result!);
      searchProducts.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoadingSearch.value = false;
  }

  addToCart(context, product) async {
    isAddingToCart.value = true;
    final response = await _cartProvider.addToCart(9, product);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      cartId.value = result!.cart!;
      print(cartId.value);
      addToCartSuccessDialog(context);
      getCartItems();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isAddingToCart.value = false;
  }

  addOrder(context, date) async {
    isLoading.value = true;

    final response = await _cartProvider.addOrder(cartId.value, date);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      Navigator.pop(Get.overlayContext!, true);
      getOrders();
      orderSuccessDialog(context);
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getCartItems() async {
    isLoading.value = true;
    final response = await _cartProvider.getCartItems(cartId.value);
    if (response.isLeft()) {
      cartItemsTotalPrice.value = 0.0;
      final result = response.fold((l) => l, (r) => null);
      cartItems.clear();
      cartItems.addAll(result!);
      cartItems.refresh();
      cartItems.forEach((element) {
        cartItemsTotalPrice.value =
            cartItemsTotalPrice.value + element.totalPriceOfItem;
      });
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  addSub(bool isAdd, cartListID) async {
    isLoading.value = true;
    final response = await _cartProvider.changeQuantity(isAdd, cartListID);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      getCartItems();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  getProductsByCategory(int type) async {
    isLoading.value = true;
    final response = await _productsProvider.getProductsByCategory(type);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      allProducts.clear();
      allProducts.addAll(result!);
      allProducts.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
    isLoading.value = false;
  }

  getOrder(id) async {
    isLoading.value = true;
    final response = await _orderProvider.getOrder(id);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      order.clear();
      order.add(result!);
      order.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getMyPoints(id) async {
    isLoading.value = true;
    final response = await _pointsProvider.getPoints(id);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      points.clear();
      points.addAll(result!);
      points.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getUsedPoints(id) async {
    isLoading.value = true;
    final response = await _pointsProvider.getUsedPoints(id);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      points.clear();
      points.addAll(result!);
      points.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getExpiredPoints(id) async {
    isLoading.value = true;
    final response = await _pointsProvider.getExpiredPoints(id);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      points.clear();
      points.addAll(result!);
      points.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
    isLoading.value = false;
  }

  getOrders() async {
    final response = await _orderProvider.getOrders();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      orders.clear();
      orders.addAll(result!);
      orders.refresh();
    } else if (response.isRight()) {
      Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ));
    }
  }

  List<Widget> buildScreens() {
    return GetStorage().read('env') == 'agent' || GetStorage().read('env') == 'driver'
        ? [
            AgentHomeScreen(),
            AgentProductsScreen(),
            NotificationsScreen(),
            SettingsScreen(),
          ]
        : [
            HomeScreen(),
            NotificationsScreen(),
            SettingsScreen(),
          ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return GetStorage().read('env') == 'agent'
        ? [
            PersistentBottomNavBarItem(
              icon: Icon(Icons.home),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.add_box_outlined),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.notifications),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.person),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
          ]
        : [
            PersistentBottomNavBarItem(
              icon: Icon(Icons.home),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.notifications),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.settings),
              activeColorPrimary: AppColors.red,
              inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
          ];
  }

  @override
  void onInit() {
    controller = PersistentTabController(initialIndex: 0);
    if (GetStorage().read('env') == 'agent') {
      getSpecialProducts();
      getProductsByCategory(0);
      getOrders();
      getMyPoints(9);
   
    }

    super.onInit();
  }

    Future moveMapCamera(LatLng target,
      {double zoom = 16, double bearing = 0}) async {
    CameraPosition newCameraPosition =
        CameraPosition(target: target, zoom: zoom, bearing: bearing);

    final GoogleMapController controller = await googleMapsController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  Future getMyCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  clearDestination() async {
    destination.value = "";
    mapStatus.value = Constants.idle;
    polyline.clear();
    polylineCoordinates.clear();
    markers.clear();
    Position position = await getMyCurrentLocation();
    moveMapCamera(LatLng(position.latitude, position.longitude));
  }

  setDestination(Place place) async {
    destination.value = place.description!;
    mapStatus.value = Constants.route;
    var geolocation = await place.geolocation;
    destinationCoordinates = LatLng(
        geolocation?.coordinates.latitude, geolocation?.coordinates.longitude);
    await drawRoute(destinationCoordinates);
    await addDestinationMarker(destinationCoordinates);
    getTotalDistanceAndTime(destinationCoordinates);
  }

  drawRoute(LatLng destination) async {
    try {
      if (polyline.isNotEmpty) {
        polyline.clear();
        polylineCoordinates.clear();
        update();
      }
      if(gettingRoute.value) return;

      gettingRoute.value = true;

      final directionsService = DirectionsService();
      Position myCurrentLocation = await getMyCurrentLocation();

      final request = DirectionsRequest(
        origin: "${myCurrentLocation.latitude},${myCurrentLocation.longitude}",
        destination: "${destination.latitude},${destination.longitude}",
        travelMode: TravelMode.driving,
      );

      await directionsService.route(request,
          (DirectionsResult response, status) {
        if (status == DirectionsStatus.ok) {
          for (GeoCoord value
              in response.routes!.asMap().values.single.overviewPath!) {
            polylineCoordinates.add(LatLng(value.latitude, value.longitude));
          }
        }
      });

      PolylineId id = const PolylineId('route');

      Polyline myPolyline = Polyline(
          width: 4,
          visible: true,
          polylineId: id,
          color: Colors.blueAccent,
          points: polylineCoordinates);
      polyline.add(myPolyline);
      if (mapStatus.value != Constants.onDestination) {
        await positionCameraToRoute(polyline);
      }
    } catch (e) {
      
    }finally{
       gettingRoute.value = false;
    }
  }

  positionCameraToRoute(Set<Polyline> polylines) async {
    try {
      double minLat = polylines.first.points.first.latitude;
      double minLong = polylines.first.points.first.longitude;
      double maxLat = polylines.first.points.first.latitude;
      double maxLong = polylines.first.points.first.longitude;
      for (var poly in polylines) {
        for (var point in poly.points) {
          if (point.latitude < minLat) minLat = point.latitude;
          if (point.latitude > maxLat) maxLat = point.latitude;
          if (point.longitude < minLong) minLong = point.longitude;
          if (point.longitude > maxLong) maxLong = point.longitude;
        }
      }
      var c = await googleMapsController.future;
      c.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(minLat, minLong),
              northeast: LatLng(maxLat, maxLong)),
          120));
      // ignore: empty_catches
    } catch (e) {}
  }

  addDestinationMarker(LatLng destination) {
    LatLng position = LatLng(destination.latitude, destination.longitude);
    MarkerId id = const MarkerId("destination");
    Marker destinationMarker =
        Marker(markerId: id, position: position, rotation: 0, visible: true);
    markers[id] = destinationMarker;
  }

  addDriverMarker(LatLng oldPos, LatLng newDriverPos) async {
    final Uint8List markerIcon =
        await getBytesFromAsset(Constants.driverCarImage, 100);
    MarkerId id = const MarkerId("driverMarker");

    AnimationController animationController = AnimationController(
      duration: const Duration(seconds: 3), vsync: this,
  
    )..repeat(reverse: false);

    Tween<double> tween = Tween(begin: 0, end: 1);

    animation = tween.animate(animationController)
      ..addListener(() {
        final v = animation!.value;

        double lng = v * newDriverPos.longitude + (1 - v) * oldPos.longitude;

        double lat = v * newDriverPos.latitude + (1 - v) * oldPos.latitude;

        LatLng newPos = LatLng(lat, lng);
        Marker newCar = Marker(
            markerId: id,
            position: newPos,
            visible: true,
            rotation: 0,
            icon: BitmapDescriptor.fromBytes(markerIcon));
        markers[id] = newCar;
        update();
      });
    animationController.forward();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  getTotalDistanceAndTime(LatLng destination) async {
    Position myCurrentLocation = await getMyCurrentLocation();
    String origin =
        "${myCurrentLocation.latitude},${myCurrentLocation.longitude}";
    String destinations = "${destination.latitude},${destination.longitude}";

    Dio dio = Dio();
    var response = await dio.get(
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$origin&destinations=$destinations&key=AIzaSyCFLz4IbxueyV7qpi6R59FmIuPgmL9F0OM");
    var data = response.data;
    double distance = 0.0;
    double duration = 0.0;
    List<dynamic> elements = data['rows'][0]['elements'];
    for (var i = 0; i < elements.length; i++) {
      distance = distance + elements[i]['distance']['value'];
      duration = duration + elements[i]['duration']['value'];
    }
    if (distance < 20) {
      arrived.value = true;
    } else {
      arrived.value = false;
    }
    distanceLeft.value =
        "${(distance / 1000).toStringAsFixed(2)} km"; // in kilometers
    timeLeft.value = "${(duration / 60).toStringAsFixed(2)} mins"; // in minutes
  }
}
