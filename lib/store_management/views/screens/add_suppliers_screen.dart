import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/login/views/widgets/custom_textField.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';

class AddSuppliersScreen extends StatefulWidget {
  final bool isEdit;
  String? name;
  String? phone;
  String? address;
  String? notes;
  String? companyName;
  String? id;
  AddSuppliersScreen({
    super.key,
    required this.isEdit,
    this.address,
    this.companyName,
    this.name,
    this.notes,
    this.phone,
    this.id,
  });

  @override
  State<AddSuppliersScreen> createState() => _AddSuppliersScreenState();
}

class _AddSuppliersScreenState extends State<AddSuppliersScreen> {
  final StoreManagementController controller =
      Get.put(StoreManagementController());

  @override
  void initState() {
    if (widget.isEdit) {
      controller.address?.text = widget.address!;
      controller.companyName?.text = widget.companyName!;
      controller.notes2?.text = widget.notes!;
      controller.supplierName?.text = widget.name!;
      controller.phone?.text = widget.phone!;
    } else {
      controller.supplierName?.clear();
      controller.companyName?.clear();
      controller.phone?.clear();
      controller.address?.clear();
      controller.notes2?.clear();
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
          widget.isEdit ? 'edit_supplier'.tr : 'add_suppliers'.tr,
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
            child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: 50,
              ),
              CustomTextField(
                controller: controller.supplierName,
                hint: 'supplier_name'.tr,
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
                controller: controller.companyName,
                hint: 'company_name'.tr,
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
                controller: controller.phone,
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
                controller: controller.address,
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
                controller: controller.notes2,
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
                            controller.editSupplier(int.parse(widget.id!), context);
                          } else {
                            controller.addSupplier(context);
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
          ),
        )),
      ),
    );
  }
}
