import 'package:get/get.dart';

import '../controllers/add_menu_controller.dart';

class AddMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMenuController>(
      () => AddMenuController(),
    );
  }
}
