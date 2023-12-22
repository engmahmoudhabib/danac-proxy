import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';
import 'package:storeapp/login/views/widgets/custom_textField.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';
import 'package:storeapp/store_management/views/widgets/choose_img_source_dialog.dart';

class AddProductScreen extends StatefulWidget {
  final bool isEdit;
  String? productName;
  String? productDescription;
  String? productImage;
  String? quantity;
  String? barcode;
  String? purchcePrice;
  String? salePrice;
  String? itemsInUnits;
  String? unitsInCartoon;
  String? limitLess;
  String? limitMore;
  String? category;
  String? notes;
  int? id;

  AddProductScreen({
    super.key,
    required this.isEdit,
    this.notes,
    this.productImage,
    this.productDescription,
    this.purchcePrice,
    this.quantity,
    this.productName,
    this.barcode,
    this.category,
    this.itemsInUnits,
    this.limitLess,
    this.salePrice,
    this.unitsInCartoon,
    this.limitMore,
    this.id,
  });

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final StoreManagementController controller =
      Get.put(StoreManagementController());


  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    if (widget.isEdit == false) {
      controller.productName?.clear();
      controller.productDescription?.clear();
      controller.quantity?.clear();
      controller.barcode?.clear();
      controller.buyPrice?.clear();
      controller.sellPrice?.clear();
      controller.itemsPerUnit?.clear();
      controller.unitsPerCartoon?.clear();
      controller.limitLess?.clear();
      controller.limitMore?.clear();
      controller.notes?.clear();
   
    } else {
      controller.productName!.text = widget.productName!;
      controller.productDescription!.text = widget.productDescription!;
      controller.quantity!.text = widget.quantity!;
      controller.barcode!.text = widget.barcode!;
      controller.buyPrice!.text = widget.purchcePrice!;
      controller.sellPrice!.text = widget.salePrice!;
      controller.itemsPerUnit!.text = widget.itemsInUnits!;
      controller.unitsPerCartoon!.text = widget.unitsInCartoon!;
      controller.limitLess!.text = widget.limitLess!;
      controller.limitMore!.text = widget.limitMore!;
      controller.notes!.text = widget.notes!;
      controller.cat.value = widget.category!;
    }

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
          'add_products'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: controller.productName,
                  hint: 'product_name'.tr,
                  isPassword: false,
                  prefixIcon: null,
                  suffixIcon: null,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'product_image'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.16,
                          width: MediaQuery.of(context).size.width * 0.36,
                          child: InkWell(
                            onTap: () {
                              chooseImageSourceDialog(controller, refresh);
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: controller.image != null || widget.productImage == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child:  controller.image == null ? SizedBox.shrink() : Image.file(
                                        File(controller.image!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: Image.network(
                                        widget.productImage!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    Column(
                      children: [
                        Text(
                          'product_desc'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.16,
                          width: MediaQuery.of(context).size.width * 0.36,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                controller: controller.productDescription,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: controller.quantity,
                  hint: 'quantity'.tr,
                  isPassword: false,
                  prefixIcon: null,
                  suffixIcon: null,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        String barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                          '#FF3758',
                          'cancel'.tr,
                          true,
                          ScanMode.BARCODE,
                        );
                        controller.barcode?.text = barcodeScanRes;
                      },
                      child: Image.asset(
                        AppImages.bacode,
                        color: AppColors.red,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: AbsorbPointer(
                        absorbing: true,
                        child: CustomTextField(
                          controller: controller.barcode,
                          hint: 'barcode'.tr,
                          isPassword: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'sell_price'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.36,
                          child: CustomTextField(
                            controller: controller.sellPrice,
                            hint: '',
                            isPassword: false,
                            prefixIcon: null,
                            suffixIcon: null,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    Column(
                      children: [
                        Text(
                          'buy_price'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.36,
                          child: CustomTextField(
                            controller: controller.buyPrice,
                            hint: '',
                            isPassword: false,
                            prefixIcon: null,
                            suffixIcon: null,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      'items_count_per_unit'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: controller.itemsPerUnit,
                      hint: '',
                      isPassword: false,
                      prefixIcon: null,
                      suffixIcon: null,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      'units_per_cartoon'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: controller.unitsPerCartoon,
                      hint: '',
                      isPassword: false,
                      prefixIcon: null,
                      suffixIcon: null,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      'alarm_lower'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: controller.limitLess,
                      hint: '',
                      isPassword: false,
                      prefixIcon: null,
                      suffixIcon: null,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      'alarm_upper'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: controller.limitMore,
                      hint: '',
                      isPassword: false,
                      prefixIcon: null,
                      suffixIcon: null,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      'cat'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 48,
                      child: Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(50),
                        child: DropdownButtonHideUnderline(
                          child: DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              showSelectedItems: true,
                            ),
                            dropdownButtonProps: DropdownButtonProps(
                              icon: RotationTransition(
                                turns: new AlwaysStoppedAnimation(90 / 360),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 12,
                                ),
                              ),
                            ),
                            items: controller.categorisNames as List<String>,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "cat".tr,
                                hintText: "cat".tr,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                              ),
                            ),
                            onChanged: (value) {
                              if (value == null) {
                                controller.cat.value ==
                                    controller.categorisNames[0];
                              } else {
                                controller.cat.value = value;
                              }
                            },
                            selectedItem: widget.category != null
                                ? widget.category
                                : controller.categorisNames[0],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      'notes'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: controller.notes,
                      hint: '',
                      isPassword: false,
                      prefixIcon: null,
                      suffixIcon: null,
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                controller.isLoading.value == true
                    ? Center(
                        child: CircularProgressIndicator(
                        color: AppColors.red,
                      ))
                    : SizedBox(
                        height: 50,
                        width: 216,
                        child: ElevatedButton(
                          onPressed: () {
                            if (widget.isEdit) {
                              controller.editProduct(
                                  context,
                                  widget.id,
                                  controller.image == null
                                      ? widget.productImage
                                      : null);
                            } else {
                              controller.addProduct(context);
                            }
                          },
                          child: Text(
                            'save'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(AppColors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
