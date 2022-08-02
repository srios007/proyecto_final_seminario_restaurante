import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/restaurant_model.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';

class HomeController extends GetxController {
  Restaurant restaurant = Restaurant();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  getUser() async {
    isLoading.value = true;
    restaurant = (await restaurantService.getCurrentUser())!;
    isLoading.value = false;
  }
}
