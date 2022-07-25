import 'package:get/get.dart';

import '../controllers/tour_controller.dart';

class TourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TourController>(
      () => TourController(),
    );
  }
}
