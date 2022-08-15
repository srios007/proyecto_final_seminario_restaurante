import 'package:get/get.dart';

import '../controllers/add_bank_account_controller.dart';

class AddBankAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBankAccountController>(
      () => AddBankAccountController(),
    );
  }
}
