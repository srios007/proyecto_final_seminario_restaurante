import 'package:get/get.dart';

import '../controllers/add_ingredients_controller.dart';

class AddIngredientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddIngredientsController>(
      () => AddIngredientsController(),
    );
  }
}
