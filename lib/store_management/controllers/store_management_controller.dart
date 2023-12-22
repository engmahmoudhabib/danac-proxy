// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/store_management/models/add_categories_response_model.dart';
import 'package:storeapp/store_management/models/categories_response_model.dart';
import 'package:storeapp/store_management/models/client_request_model.dart';
import 'package:storeapp/store_management/models/clients_response_model.dart';
import 'package:storeapp/store_management/models/create_income_request_model.dart';
import 'package:storeapp/store_management/models/list_income_response_modek.dart';
import 'package:storeapp/store_management/models/medium_table_response_model.dart';
import 'package:storeapp/store_management/models/products_response_model.dart';
import 'package:storeapp/store_management/models/suppliers_request_model.dart';
import 'package:storeapp/store_management/providers/categories_provider.dart';
import 'package:storeapp/store_management/providers/clients_provider.dart';
import 'package:storeapp/store_management/providers/medium_provider.dart';
import 'package:storeapp/store_management/providers/products_provider.dart';
import 'package:storeapp/store_management/providers/suppliers_provider.dart';
import 'package:storeapp/store_management/views/screens/add_invoice_inputs_screen.dart';
import 'package:storeapp/store_management/views/widgets/income_added_success_dialog.dart';

import '../models/suppliers_response_model.dart';

class StoreManagementController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingCategory = false.obs;
  RxBool isAdd = false.obs;
  RxBool isMins = false.obs;
  RxInt supplierID = 0.obs;
  XFile? image;
  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  final ProductsProvider _productsProvider = ProductsProvider();
  final ClientsProvider _clientsProvider = ClientsProvider();
  final SuppliersProvider _suppliersProvider = SuppliersProvider();
  final MediumProvider _mediumProvider = MediumProvider();
  TextEditingController? categoryName = TextEditingController();
  RxList categoris = <CategoriesResponseModel>[].obs;
  RxList suppliers = <SuppliersResponseModel>[].obs;
  RxList incomeList = <ListIncomeResponseModel>[].obs;
  RxList categorisNames = <String>[].obs;
  RxList supsNames = <String>[].obs;
  RxList clientsCategory = <String>[].obs;
  RxList clients = <ClientsResponseModel>[].obs;
  RxInt inputsQuantity = 1.obs;
  RxList products = <ProductsResponseModel>[].obs;
  RxDouble totalPrice = 0.0.obs;
  RxDouble totalIncomePrice = 0.0.obs;
  RxList inputsProduct = <MediumTableResponseModel>[].obs;
  RxString cat = ''.obs;
  RxString sups = ''.obs;
  RxString clts = ''.obs;
  RxDouble total = 0.0.obs;
  RxDouble rmAmt = 0.0.obs;
  RxInt mediumTableID = 0.obs;
  TextEditingController? productName = TextEditingController();
  TextEditingController? productDescription = TextEditingController();
  TextEditingController? quantity = TextEditingController();
  TextEditingController? barcode = TextEditingController();
  TextEditingController? searchBarcode = TextEditingController();
  TextEditingController? sellPrice = TextEditingController();
  TextEditingController? buyPrice = TextEditingController();
  TextEditingController? itemsPerUnit = TextEditingController();
  TextEditingController? unitsPerCartoon = TextEditingController();
  TextEditingController? limitLess = TextEditingController();
  TextEditingController? limitMore = TextEditingController();
  TextEditingController? notes = TextEditingController();
  TextEditingController? notes2 = TextEditingController();
  TextEditingController? supplierName = TextEditingController();
  TextEditingController? address = TextEditingController();
  TextEditingController? phone = TextEditingController();
  TextEditingController? companyName = TextEditingController();
  TextEditingController? proxyName = TextEditingController();
  TextEditingController? proxyTrukNumber = TextEditingController();
  TextEditingController? invoiceCheckCode = TextEditingController();
  TextEditingController? customerServicePhone = TextEditingController();
  TextEditingController? oldDebts = TextEditingController();
  TextEditingController? returnProducts = TextEditingController();
  TextEditingController? discount = TextEditingController();
  TextEditingController? paidMoney = TextEditingController();
  TextEditingController? clientName = TextEditingController();
  TextEditingController? clientPhone = TextEditingController();
  TextEditingController? clientAddress = TextEditingController();
  TextEditingController? clientNotes = TextEditingController();
  //

  getCategories() async {
    isLoading.value = true;
    final response = await _categoriesProvider.getCategories();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      categoris.clear();
      categorisNames.clear();
      categoris.addAll(result!);
      categoris.forEach((element) {
        categorisNames.add(element.name);
      });
      categorisNames.refresh();
      categoris.refresh();
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

  getProducts() async {
    isLoading.value = true;
    final response = await _productsProvider.getProducts();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      products.clear();
      products.addAll(result!);
      products.refresh();
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

  addCategory() async {
    isLoadingCategory.value = true;
    final response = await _categoriesProvider.addCategories(
      AddCategoriesRequestModel(
        name: categoryName?.text,
      ),
    );
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      isLoadingCategory.value = false;
      Navigator.pop(Get.overlayContext!, true);
      getCategories();
    } else if (response.isRight()) {
      isLoadingCategory.value = false;
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

  Future pickImageFromGallery(refresh) async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = XFile(img!.path);
    refresh();
    Navigator.pop(Get.overlayContext!, true);
  }

  Future pickImageFromCamera(refresh) async {
    final img = await ImagePicker().pickImage(source: ImageSource.camera);
    image = XFile(img!.path);
    refresh();
    Navigator.pop(Get.overlayContext!, true);
  }

  removeImage(refresh) {
    image = null;
    refresh();
    Navigator.pop(Get.overlayContext!, true);
  }

  removeImage2() {
    image = null;
    refresh();
  }

  addProduct(context) async {
    if (image != null ||
        productName?.text == null ||
        productDescription?.text == null ||
        quantity?.text == null ||
        barcode?.text == null ||
        buyPrice?.text == null ||
        sellPrice?.text == null ||
        itemsPerUnit?.text == null ||
        unitsPerCartoon?.text == null ||
        limitLess?.text == null ||
        limitMore?.text == null ||
        notes?.text == null) {
      isLoading.value = true;
      Uint8List? compressedFile =
          await FlutterImageCompress.compressWithFile(image!.path, quality: 90);
      final response = await _productsProvider.createProduct(
        productName?.text,
        productDescription?.text,
        compressedFile!,
        quantity?.text,
        barcode?.text,
        buyPrice?.text,
        sellPrice?.text,
        itemsPerUnit?.text,
        unitsPerCartoon?.text,
        limitLess?.text,
        limitMore?.text,
        cat.value,
        notes?.text,
      );
      if (response.isLeft()) {
        final result = response.fold((l) => l, (r) => null);
        isLoading.value = false;
        getProducts();

        Navigator.pop(context);
        Get.showSnackbar(GetSnackBar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          messageText: Center(
            child: Text(
              'product_added_successfully'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          duration: Duration(seconds: 4),
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
          forwardAnimationCurve: Curves.easeOutBack,
        ));

        productName?.clear();
        productDescription?.clear();
        quantity?.clear();
        barcode?.clear();
        buyPrice?.clear();
        sellPrice?.clear();
        itemsPerUnit?.clear();
        unitsPerCartoon?.clear();
        limitLess?.clear();
        limitMore?.clear();
        notes?.clear();
        removeImage(refresh);
      } else if (response.isRight()) {
        isLoading.value = false;
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
    } else {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'image_empty'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }

  getSuppliers() async {
    isLoading.value = true;
    final response = await _suppliersProvider.getSuppliers();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      suppliers.clear();
      supsNames.clear();
      suppliers.addAll(result!);
      suppliers.forEach((element) {
        supsNames.add(element.id.toString() + '-' + element.name);
      });
      supsNames.refresh();
      suppliers.refresh();
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

  deleteProduct(id) async {
    isLoading.value = true;
    final response = await _productsProvider.deleteProduct(id);
    if (response.isLeft()) {
      getProducts();
      Navigator.pop(Get.overlayContext!, true);
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

  deleteClient(id) async {
    isLoading.value = true;
    final response = await _clientsProvider.deleteClient(id);
    if (response.isLeft()) {
      getClients();
      Navigator.pop(Get.overlayContext!, true);
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

  editProduct(context, id, img) async {
    Uint8List? compressedFile;
    isLoading.value = true;
    if (img == null) {
      compressedFile =
          await FlutterImageCompress.compressWithFile(image!.path, quality: 90);
    } else {
      compressedFile = null;
    }

    final response = await _productsProvider.editProduct(
        productName?.text,
        productDescription?.text,
        compressedFile,
        quantity?.text,
        barcode?.text,
        buyPrice?.text,
        sellPrice?.text,
        itemsPerUnit?.text,
        unitsPerCartoon?.text,
        limitLess?.text,
        limitMore?.text,
        cat.value,
        notes?.text,
        id);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      isLoading.value = false;
      getProducts();

      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        messageText: Center(
          child: Text(
            'product_edited_successfully'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        duration: Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.vertical,
        forwardAnimationCurve: Curves.easeOutBack,
      ));
      Navigator.pop(context);
    } else if (response.isRight()) {
      isLoading.value = false;
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

  addSupplier(context) async {
    isLoadingCategory.value = true;
    final response = await _suppliersProvider.addSupplier(SuppliersRequestModel(
      address: address?.text,
      companyName: companyName?.text,
      info: notes2?.text,
      name: supplierName?.text,
      phoneNumber: phone?.text,
    ));
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      isLoadingCategory.value = false;

      getSuppliers();
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        messageText: Center(
          child: Text(
            'supplier_added_successfully'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        duration: Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.vertical,
        forwardAnimationCurve: Curves.easeOutBack,
      ));
      Navigator.pop(context);
    } else if (response.isRight()) {
      isLoadingCategory.value = false;
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

  editSupplier(int id, context) async {
    isLoadingCategory.value = true;
    final response = await _suppliersProvider.editSupplier(
      SuppliersResponseModel(
        address: address?.text,
        companyName: companyName?.text,
        info: notes2?.text,
        name: supplierName?.text,
        phoneNumber: phone?.text,
        id: id,
      ),
    );
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      isLoadingCategory.value = false;

      getSuppliers();
      Get.showSnackbar(
        GetSnackBar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          messageText: Center(
            child: Text(
              'supplier_edited_successfully'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          duration: Duration(seconds: 4),
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
          forwardAnimationCurve: Curves.easeOutBack,
        ),
      );
      Navigator.pop(context);
    } else if (response.isRight()) {
      isLoadingCategory.value = false;
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

  deleteSupplier(id) async {
    isLoading.value = true;
    final response = await _suppliersProvider.deleteSupplier(id);
    if (response.isLeft()) {
      getSuppliers();
      Navigator.pop(Get.overlayContext!, true);
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

  getClients() async {
    isLoading.value = true;
    final response = await _clientsProvider.getClients();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      clients.clear();
      clientsCategory.clear();
      clients.addAll(result!);
      clients.forEach((element) {
        clientsCategory.add(element.category);
      });
      clientsCategory.toSet().toList();
      clientsCategory.refresh();
      clients.refresh();
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

  editClients(int id, context) async {
    isLoadingCategory.value = true;
    final response = await _clientsProvider.editClient(
      ClientsResponseModel(
        address: clientAddress?.text,
        category: clts.value,
        notes: clientNotes?.text,
        name: clientName?.text,
        phonenumber: clientPhone?.text,
        id: id,
      ),
    );
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      isLoadingCategory.value = false;

      getClients();
      Get.showSnackbar(
        GetSnackBar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.red,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          messageText: Center(
            child: Text(
              'client_edited_successfully'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          duration: Duration(seconds: 4),
          isDismissible: true,
          dismissDirection: DismissDirection.vertical,
          forwardAnimationCurve: Curves.easeOutBack,
        ),
      );
      Navigator.pop(context);
    } else if (response.isRight()) {
      isLoadingCategory.value = false;
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

  addClient(context) async {
    isLoadingCategory.value = true;
    final response = await _clientsProvider.addClient(
      ClientsRequestModel(
        address: clientAddress?.text,
        category: clts.value,
        notes: clientNotes?.text,
        name: clientName?.text,
        phonenumber: clientPhone?.text,
      ),
    );
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      isLoadingCategory.value = false;

      getClients();
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.red,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        messageText: Center(
          child: Text(
            'client_added_successfully'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        duration: Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.vertical,
        forwardAnimationCurve: Curves.easeOutBack,
      ));
      Navigator.pop(context);
    } else if (response.isRight()) {
      isLoadingCategory.value = false;
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

  createMedium(context) async {
    isLoading.value = true;
    final response = await _mediumProvider.createMedium();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      mediumTableID.value = result!.id!;
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: AddInputsInvoiceScreen(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
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

  getMediumTable() async {
    isLoading.value = true;
    final response = await _mediumProvider.getMediumTable(mediumTableID.value);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      inputsProduct.clear();
      inputsProduct.addAll(result!);
      inputsProduct.refresh();
      total.value = 0.0;
      inputsProduct.forEach((element) {
        total.value = total.value + element.totalPrice;
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

  addToMedium(product) async {
    isLoading.value = true;
    final response =
        await _mediumProvider.addToMedium(mediumTableID.value, product);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      getMediumTable();
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

  add(product, quantity) async {
    inputsQuantity.value = quantity;
    isAdd.value = true;
    final response = await _mediumProvider.add(product);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      isAdd.value = false;
      inputsQuantity.value = inputsQuantity.value + 1;
      getMediumTable();
    } else if (response.isRight()) {
      isAdd.value = false;
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

  minus(product, quantity) async {
    inputsQuantity.value = quantity;
    isMins.value = true;
    final response = await _mediumProvider.minus(product);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      isMins.value = false;
      inputsQuantity.value = inputsQuantity.value - 1;
      getMediumTable();
    } else if (response.isRight()) {
      isMins.value = false;
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

  createIncome(context) async {
    if (paidMoney?.text.isEmpty == true ||
        discount?.text.isEmpty == true ||
        returnProducts?.text.isEmpty == true ||
        oldDebts?.text.isEmpty == true) {
    } else {
      isLoading.value = true;
      double tot = double.parse(paidMoney!.text) -
          double.parse(discount!.text) -
          double.parse(returnProducts!.text) -
          double.parse(oldDebts!.text);
      final response = await _mediumProvider.createIncome(
        mediumTableID,
        CreateIncomeRequestModel(
          agent: proxyName?.text,
          codeVerefy: invoiceCheckCode?.text,
          discount: discount?.text,
          numTruck: proxyTrukNumber?.text,
          phonenumber: customerServicePhone?.text,
          previousDepts: oldDebts?.text,
          recivePyement: paidMoney?.text,
          reclaimedProducts: returnProducts?.text,
          remainingAmount: tot.toString(),
          supplier: supplierID.value.toString(),
        ),
      );

      if (response.isLeft()) {
        final result = response.fold((l) => l, (r) => null);
        total.value = 0.0;
        addIncomeSuccessDialog(context, result?.id);
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
  }

  getIncomeList() async {
    isLoadingCategory.value = true;
    totalIncomePrice.value = 0.0;
    final response = await _mediumProvider.getIncomeList();
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      incomeList.clear();
      incomeList.addAll(result!);
      incomeList.refresh();
      incomeList.forEach((element) {
        totalIncomePrice.value =
            totalIncomePrice.value + element.remainingAmount;
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
    isLoadingCategory.value = false;
  }

  @override
  void onInit() {
    getCategories();
    getProducts();
    getSuppliers();
    getClients();
    getIncomeList();
    super.onInit();
  }
}
