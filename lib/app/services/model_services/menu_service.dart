import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/restaurant_model.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import '../../models/meal_model.dart';
import '../../models/menu_model.dart';
import '../firebase_services/database_service.dart';

class MenuService {
  static String restaurantsReference = firebaseReferences.restaurants;
  static String addressReference = firebaseReferences.addresses;
  static String mealReference = firebaseReferences.meals;

  static final MenuService _instance = MenuService._internal();

  factory MenuService() {
    return _instance;
  }

  MenuService._internal();
  var firestore = FirebaseFirestore.instance;

  createMenu({
    required Menu menu,
    required restaurantId,
  }) async {
    try {
      menu.created = DateTime.now();
      menu.restaurantId = restaurantId;
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection('menus')
          .add(menu.toJson());

      String menuId = await database.saveMenu(
        collection: 'menus',
        customId: documentReference.id,
        menu: menu,
      );

      return menuId;
    } on Exception catch (e) {
      print(e);
      return '';
    }
  }

  Future<List<Menu>> getMenus(
    String documentId,
    String param,
  ) async {
    connectionStatus.getNormalStatus();
    List<Menu> meals = [];
    var querySnapshot =
        await database.getDataByCustonParam(documentId, 'menus', param);
    if (querySnapshot.docs.isEmpty) return [];
    for (var element in querySnapshot.docs) {
      Menu meal = Menu.fromJson(
        (element.data() as Map<String, dynamic>),
      );

      meal.id = element.id;
      meals.add(meal);
    }
    return meals;
  }
}

MenuService menuService = MenuService();
