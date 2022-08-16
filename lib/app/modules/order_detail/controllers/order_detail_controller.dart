import '../../../models/models.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  Purchase purchase = Purchase();

  @override
  void onInit() {
    purchase = Get.arguments['purchase'];
    super.onInit();
  }
}
