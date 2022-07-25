import 'package:get/get.dart';

import '../controllers/forgot_user_controller.dart';

class ForgotUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotUserController>(
      () => ForgotUserController(),
    );
  }
}
