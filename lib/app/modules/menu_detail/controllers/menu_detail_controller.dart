import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../models/meal_model.dart';
import '../../../models/menu_model.dart';
import '../../../services/model_services/meal_service.dart';

class MenuDetailController extends GetxController {
  late Menu menu;
  List<Meal> meals = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    menu = Get.arguments['menu'];
    getData();
    super.onInit();
  }

  getData() async {
    await getMeals();
  }

  getMeals() async {
    isLoading.value = true;
    meals = await mealService.getMealsByDocumentId(
      menu.id!,
      'meals',
      'menuId',
    );
    isLoading.value = false;
  }

  // Categoría a partir de un category id
  setCategory(String categoryId) {
    switch (categoryId) {
      case 'beverage':
        return 'Bebida';

      case 'dessert':
        return 'Postre';

      case 'entree':
        return 'Plato fuerte';

      case 'side':
        return 'Acompañamiento';

      case 'starter':
        return 'Entrada';

      default:
        return '';
    }
  }
}
