import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/models/cart_item_response_model.dart';
import 'package:storeapp/home/models/search_products_response_model.dart';
import 'package:storeapp/home/models/special_products_response_model.dart';
import 'package:storeapp/home/providers/cart_provider.dart';
import 'package:storeapp/home/providers/products_provider.dart';
import 'package:storeapp/home/views/screens/agent_home_screen.dart';
import 'package:storeapp/home/views/screens/agent_products_screen.dart';
import 'package:storeapp/home/views/screens/cart_screen.dart';
import 'package:storeapp/home/views/screens/home_screen.dart';
import 'package:storeapp/home/views/widgets/add_to_cart_successfuly_dialog.dart';

import 'package:storeapp/notifications/views/screens/notifications_screen.dart';
import 'package:storeapp/settings/views/screens/settings_screen.dart';

class HomeController extends GetxController {
  late PersistentTabController controller;
  RxBool isLoading = false.obs;
  RxBool isLoadingSearch = false.obs;
  RxBool isAddingToCart = false.obs;
  RxInt cartId = 0.obs;
  TextEditingController? searchController = TextEditingController();
  RxList specialProducts = <SpecialProductsResponseModel>[].obs;
  RxList searchProducts = <SearchlProductsResponseModel>[].obs;
  RxList cartItems = <GetCartItemsResponseModel>[].obs;
  final ProductsProvider _productsProvider = ProductsProvider();
  final CartProvider _cartProvider = CartProvider();
  createCart() async {
    final response = await _cartProvider.createCart(9);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      cartId.value = result!.id!;
      print(cartId.value);
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
  }

  addToCart(product, context) async {
    isAddingToCart.value = true;
    final response = await _cartProvider.addToCart(9, product);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      addToCartSuccessDialog(context);
      getCartItems();
    } else if (response.isRight()) {
       getCartItems();
      
      /*   Get.defaultDialog(
          title: 'error'.tr,
          content: Text(
            'please_try_again'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          )); */
    }
    isAddingToCart.value = false;
  }

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
      print(searchProducts.length);
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

  getCartItems() async {
    isLoading.value = true;
    final response = await _cartProvider.getCartItems(cartId.value);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      cartItems.clear();
      cartItems.addAll(result!);
      cartItems.refresh();
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
      createCart();
    }

    super.onInit();
  }
}
