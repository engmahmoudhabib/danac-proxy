import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
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

class HomeController extends GetxController {
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
    return GetStorage().read('env') == 'agent'
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
}
