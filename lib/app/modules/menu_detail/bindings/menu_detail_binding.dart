import 'package:get/get.dart';

import '../controllers/menu_detail_controller.dart';

class MenuDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuDetailController>(
      () => MenuDetailController(),
    );
  }
}
