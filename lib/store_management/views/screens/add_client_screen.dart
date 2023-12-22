import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/login/views/widgets/custom_textField.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';

// ignore: must_be_immutable
class AddClientsScreen extends StatefulWidget {
  String? client;
  int? id;
  String? phone;
  String? category;
  String? address;
  String? notes;
  String? points;
  final bool isEdit;

  AddClientsScreen({
    super.key,
    required this.isEdit,
    this.address,
    this.category,
    this.client,
    this.id,
    this.notes,
    this.phone,
    this.points,
  });

  @override
  State<AddClientsScreen> createState() => _AddClientsScreenState();
}

class _AddClientsScreenState extends State<AddClientsScreen> {
  final StoreManagementController controller =
      Get.put(StoreManagementController());

  @override
  void initState() {
    if (widget.isEdit) {
      controller.clientName?.text = widget.client!;
      controller.clientPhone?.text = widget.phone!;
      controller.clientAddress?.text = widget.address!;
      controller.clientNotes?.text = widget.notes!;
    } else {
      controller.clientName?.clear();
      controller.clientPhone?..clear();
      controller.clientAddress?..clear();
      controller.clientNotes?..clear();
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
          'add_clients'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Obx(() => Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CustomTextField(
                controller: controller.clientName,
                hint: 'client_name'.tr,
                isPassword: false,
                prefixIcon: null,
                suffixIcon: null,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
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
                      items: controller.clientsCategory as List<String>,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "cat".tr,
                          hintText: "cat".tr,
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        ),
                      ),
                      onChanged: (value) {
                        if (value == null) {
                          controller.clts.value ==
                              controller.clientsCategory[0];
                        } else {
                          controller.clts.value = value;
                        }
                      },
                      selectedItem: widget.category != null
                          ? widget.category
                          : controller.clientsCategory[0],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: controller.clientPhone,
                hint: 'phone'.tr,
                isPassword: false,
                prefixIcon: null,
                suffixIcon: null,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: controller.clientAddress,
                hint: 'address'.tr,
                isPassword: false,
                prefixIcon: null,
                suffixIcon: null,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: controller.clientNotes,
                hint: 'notes'.tr,
                isPassword: false,
                prefixIcon: null,
                suffixIcon: null,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.multiline,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(
                height: 50,
                width: 216,
                child: controller.isLoadingCategory.value == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          if (widget.isEdit) {
                            controller.editClients(widget.id!,context);
                          } else {
                            controller.addClient(context);
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
          ),)
        ),
      ),
    );
  }
}
