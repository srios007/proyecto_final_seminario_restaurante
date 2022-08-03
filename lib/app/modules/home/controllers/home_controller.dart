import 'package:proyecto_final_seminario_restaurante/app/services/model_services/category_service.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/restaurant_model.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/category_model.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Restaurant restaurant = Restaurant();
  List<Category> categories = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    await getUser();
    await getCategories();
    isLoading.value = false;
  }

  // Trae el usuario que inicia sesión
  getUser() async {
    restaurant = (await restaurantService.getCurrentUser())!;
  }

  // Trae las categorías
  getCategories() async {
    categories = await categoryService.getCategories();
    categories.forEach((element) {
      print(element.name);
    });
  }
}
