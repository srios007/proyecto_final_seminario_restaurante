import 'dart:io';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proyecto_final_seminario_restaurante/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/model_services/meal_service.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/snackbars.dart';
import '../../../models/category_model.dart';
import '../../../models/meal_model.dart';
import '../../../routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../services/firebase_services/storage_service.dart';

class AddMenuController extends GetxController {
  HomeController homeController = Get.find();
  final ImagePicker _picker = ImagePicker();
  final key = GlobalKey<FormState>();
  RxBool isLoadingMenu = false.obs;
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
            isLoading: false.obs,
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

  // Validar menú
  addMenu() async {
    if (key.currentState!.validate()) {
      if (!await validatePictures()) {
        SnackBars.showErrorSnackBar(
          'Por favor, verifica que todos tus platos tengan foto.',
        );
      } else if (!await validateIngredients()) {
        SnackBars.showErrorSnackBar(
          'Por favor, agrega mínimo dos ingredientes en todos tus platos.',
        );
      } else {
        isLoadingMenu.value = true;
        for (var category in categoriesMenu) {
          for (var meal in category.meals) {
            var rng = Random();
            meal.pictureUrl = await storageService.uploadFile(
              homeController.restaurant.id!,
              '${rng.nextInt(1000000000)}',
              meal.picture,
            );
            meal.categoryId = category.id;
            await mealService.createMealAndIngrediens(
              meal: meal,
              restaurantId: homeController.restaurant.id,
            );
          }
        }
        isLoadingMenu.value = false;
        Get.back();
      }
    } else {
      SnackBars.showErrorSnackBar(
        'Por favor verifica los campos',
      );
    }
  }

  // Valida que el número de ingredientes sea mínimo de dos
  validateIngredients() async {
    for (var category in categoriesMenu) {
      category.meals.forEach((meal) {
        if (meal.ingredients.length < 2) {
          return false;
        }
      });
    }
    return true;
  }

  // Valida que todos los platillos tengan fotos
  validatePictures() async {
    for (var category in categoriesMenu) {
      category.meals.forEach((meal) {
        if (meal.picture == null) {
          return false;
        }
      });
    }
    return true;
  }

  //Va a crear ingredientes con los datos del Meal
  goToAddIngredient({
    required int categoryPosition,
    required int mealPosition,
    required String name,
  }) async {
    isLoading.value = true;
    await Get.toNamed(Routes.ADD_INGREDIENTS, arguments: {
      'meal': categoriesMenu[categoryPosition].meals[mealPosition],
      'category': name,
      'name': '$name ${mealPosition + 1}',
    });
    isLoading.value = false;
  }

  // Agrega una foto a platillo
  getMealPicture(bool isCamera, Meal meal) async {
    if (await Permission.mediaLibrary.request().isGranted &&
        await Permission.camera.request().isGranted) {
      meal.isLoading!.value = true;
      try {
        final result = await _picker.pickImage(
            source: isCamera ? ImageSource.camera : ImageSource.gallery);

        if (result != null) {
          meal.picture = File(result.path);
          meal.isLoading!.value = false;
        } else {
          meal.isLoading!.value = false;
        }
      } catch (e) {
        print(e);
        SnackBars.showErrorSnackBar(
          'Por favor, activa los permisos desde la configuración de tu celular para poder acceder a los archivos que necesites y tomar fotos',
        );
        meal.isLoading!.value = false;
      }
    } else {
      SnackBars.showErrorSnackBar(
        'Por favor, activa los permisos desde la configuración de tu celular para poder acceder a los archivos que necesites y tomar fotos',
      );
      meal.isLoading!.value = false;
    }
  }
}
