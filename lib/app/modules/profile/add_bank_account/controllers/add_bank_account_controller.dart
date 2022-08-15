import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../models/restaurant_model.dart';
import '../../../../services/model_services/restaurant_service.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/snackbars.dart';
import '../../../home/controllers/home_controller.dart';

class AddBankAccountController extends GetxController {
  var bankName = 'BANCOLOMBIA'.obs;
  var accountType = 'Ahorros'.obs;
  var typeId = 'CC'.obs;

  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountOwnerNameController =
      TextEditingController();
  final TextEditingController accountOwnerIdController =
      TextEditingController();

  final formKeyNewBankAccount = GlobalKey<FormState>();

  var isLoading = false.obs;

  var accountNumberError = false.obs;
  var accountOwnerNameError = false.obs;
  var accountOwnerIdError = false.obs;

  late Restaurant restaurant;
  late HomeController homeController;

  @override
  void onInit() {
    homeController = Get.find<HomeController>();
    restaurant = homeController.restaurant;
    super.onInit();
  }

  void changeBankName(String? selectedBank) {
    bankName.value = selectedBank!;
  }

  void changeAccountType(String? selectedType) {
    accountType.value = selectedType!;
  }

  void changeTypeId(String? selectedType) {
    typeId.value = selectedType!;
  }

  List<DropdownMenuItem<String>> getAvailableBanks() {
    return constants.banksList.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> getAvailableAccountTypes() {
    return constants.bankAccountTypes
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> getTypeIds() {
    return constants.typeIds.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  String? validateAccountNumber(String? _) {
    if (accountNumberController.text.isEmpty) {
      accountNumberError.value = true;
      return null;
    } else {
      accountNumberError.value = false;
      return null;
    }
  }

  String? validateAccountOwnerName(String? _) {
    if (accountOwnerNameController.text.isEmpty) {
      accountOwnerNameError.value = true;
      return null;
    } else {
      accountOwnerNameError.value = false;
      return null;
    }
  }

  String? validateAccountOwnerId(String? _) {
    if (accountOwnerIdController.text.isEmpty) {
      accountOwnerIdError.value = true;
      return null;
    } else {
      accountOwnerIdError.value = false;
      return null;
    }
  }

  /// Validates there are no errors in the Form then creates a bank account
  void createBankAccount() async {
    if (formKeyNewBankAccount.currentState!.validate() &&
        !accountNumberError.value &&
        !accountOwnerNameError.value &&
        !accountOwnerIdError.value) {
      isLoading.value = true;

      try {
        print(typeId.value);
        var account = BankAccount(
          ownerInfo: OwnerInfo(
            name: accountOwnerNameController.text,
            documentId: accountOwnerIdController.text,
            typeId: typeId.value,
          ),
          bank: bankName.value,
          number: accountNumberController.text,
          type: accountType.value,
        );
        restaurant.bankAccount = account;
        restaurantService.update(restaurant);
        Get.back();
      } catch (e) {
        SnackBars.showErrorSnackBar(
            'Hubo un error actualizando la información');
      }
    }
    isLoading.value = false;
  }
}
