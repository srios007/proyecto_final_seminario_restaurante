import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/restaurant_model.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import '../../models/meal_model.dart';
import '../firebase_services/database_service.dart';

class MealService {
  static String restaurantsReference = firebaseReferences.restaurants;
  static String addressReference = firebaseReferences.addresses;
  static String mealReference = firebaseReferences.meals;

  static final MealService _instance = MealService._internal();

  factory MealService() {
    return _instance;
  }

  MealService._internal();
  var firestore = FirebaseFirestore.instance;

  createMealAndIngrediens({
    required Meal meal,
    required restaurantId,
  }) async {
    try {
      meal.created = DateTime.now();
      meal.restaurantId = restaurantId;
      meal.isAvaliable = true;
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection('meals')
          .add(meal.toJson());

      database.saveMealanIngredients(
        collection: 'meals',
        customId: documentReference.id,
        meal: meal,
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<Meal>> getMeals(
    String documentId,
    String collection,
    String param,
  ) async {
    connectionStatus.getNormalStatus();
    List<Meal> meals = [];
    var querySnapshot =
        await database.getDataByCustonParam(documentId, collection, param);
    if (querySnapshot.docs.isEmpty) return [];
    for (var element in querySnapshot.docs) {
      Meal meal = Meal.fromJson(
        (element.data() as Map<String, dynamic>),
      );
      meal.ingredients = [].obs;
      meal.id = element.id;
      meals.add(meal);
    }
    return meals;
  }
}

MealService mealService = MealService();
