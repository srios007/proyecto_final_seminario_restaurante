import 'package:flutter/widgets.dart';
import 'package:proyecto_final_seminario_restaurante/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/snackbars.dart';
import '../../../models/category_model.dart';
import 'package:get/get.dart';

import '../../../models/meal_model.dart';
import '../../../routes/app_pages.dart';

class AddMenuController extends GetxController {
  HomeController homeController = Get.find();
  final key = GlobalKey<FormState>();
  List<Category> categories = [];
  RxList categoriesMenu = [].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    categories.addAll(homeController.categories);
    super.onInit();
  }

  //Agrega una categoría al menú
  addCategoryMenu(int position) {
    List<dynamic> auxList = [];
    auxList = categoriesMenu
        .where((element) => element.id == categories[position].id)
        .toList();
    if (auxList.isEmpty) {
      categoriesMenu.add(categories[position]);
    } else {
      SnackBars.showErrorSnackBar(
        'No se puede agregar dos veces la misma categoría, por favor escoge otra',
      );
    }
  }

  //Elimina una categoría al menú
  deleteCategoryMenu(dynamic category) {
    category.meals.clear();
    categoriesMenu.remove(category);
  }

  //Agrega plato al menu de la categoría
  addMealToCategoryMenu(int position) {
    categoriesMenu[position].meals.add(
          Meal(
            nameController: TextEditingController(),
            descriptionController: TextEditingController(),
            priceController: TextEditingController(),
            amountController: TextEditingController(),
            ingredients: [].obs,
          ),
        );
  }

  //Elimina plato al menu de la categoría
  deleteMealToCategoryMenu(int categoryPosition, int position) {
    categoriesMenu[categoryPosition].meals.removeAt(position);
  }

  // Valida que todos los datos ingresados sean corectos
  validateMeal() {
    key.currentState!.validate();
  }

  //Va a crear ingredientes con los datos del Meal
  goToAddIngredient({
    required int categoryPosition,
    required int mealPosition,
    required String name,
  }) async {
    isLoading.value = true;
    List<dynamic> auxList = [];
    auxList = await Get.toNamed(Routes.ADD_INGREDIENTS, arguments: {
      'meal': categoriesMenu[categoryPosition].meals[mealPosition],
      'category': name,
      'name': '$name ${mealPosition + 1}',
    });

    isLoading.value = false;
  }
}
