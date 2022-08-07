import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/ingredient.dart';

import '../../../models/meal_model.dart';

class AddIngredientsController extends GetxController {
  final key = GlobalKey<FormState>();
  late Meal meal;
  late String name;
  late String category;

  final count = 0.obs;
  @override
  void onInit() {
    meal = Get.arguments['meal'];
    name = Get.arguments['name'];
    category = Get.arguments['category'];
    super.onInit();
  }

  //Agregar ingrediente
  addIngredient() {
    meal.ingredients!.add(
      Ingredient(
        nameController: TextEditingController(),
        descriptionController: TextEditingController(),
        priceController: TextEditingController(),
        amountController: TextEditingController(),
        amountMeasureController: TextEditingController(),
        amountIngredientController: TextEditingController(),
        isSpicy: false.obs,
        isMandatory: false.obs,
      ),
    );
  }

  //Eliminar ingrediente
  deleteIngredient(int position) {
    meal.ingredients!.removeAt(position);
  }

  // Valida los datos de todos los ingredientes
  validateAndAddIngredients() {
    if (key.currentState!.validate()) {}
  }

  //Cambia el valor del checkbox de isMandatory
  changeIsMandatoryValue(int position) {
    if (meal.ingredients![position].isMandatory.value) {
      meal.ingredients![position].isMandatory.value = false;
    } else {
      meal.ingredients![position].isMandatory.value = true;
    }
  }

  //Cambia el valor del checkbox de isSpicy
  changeIsSpicyValue(int position) {
    if (meal.ingredients![position].isSpicy.value) {
      meal.ingredients![position].isSpicy.value = false;
    } else {
      meal.ingredients![position].isSpicy.value = true;
    }
  }
}
