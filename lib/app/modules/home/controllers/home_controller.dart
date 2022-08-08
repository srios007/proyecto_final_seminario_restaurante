import 'package:proyecto_final_seminario_restaurante/app/services/model_services/category_service.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/model_services/meal_service.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/restaurant_model.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/category_model.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/meal_model.dart';
import 'package:proyecto_final_seminario_restaurante/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Restaurant restaurant = Restaurant();
  List<Category> categories = [];
  List<Meal> meals = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    await getRestaurant();
    await getCategories();
    await getMeals();
    isLoading.value = false;
  }

  // Trae el usuario que inicia sesión
  getRestaurant() async {
    restaurant = (await restaurantService.getCurrentUser())!;
  }

  // Trae las categorías
  getCategories() async {
    categories = await categoryService.getCategories();
  }

  // Trae los platillos
  getMeals() async {
    meals = await mealService.getMeals(
      restaurant.id!,
      'meals',
      'restaurantId',
    );
  }

  //Ir a crear menú
  goToAddMenu() async {
    await Get.toNamed(Routes.ADD_MENU);
    getData();
  }
}
