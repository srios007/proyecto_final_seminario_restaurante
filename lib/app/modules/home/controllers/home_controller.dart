import 'package:proyecto_final_seminario_restaurante/app/services/model_services/category_service.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/model_services/meal_service.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/model_services/menu_service.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';
import 'package:proyecto_final_seminario_restaurante/app/routes/app_pages.dart';
import '../../../models/models.dart';
import 'package:get/get.dart';

import '../../../services/firebase_services/database_service.dart';

class HomeController extends GetxController {
  Restaurant restaurant = Restaurant();
  List<Category> categories = [];
  List<Purchase> purchases = [];
  RxBool isLoading = false.obs;
  List<Meal> meals = [];
  List<Menu> menus = [];

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
    await getMenus();
    await getPurchases();
    isLoading.value = false;
  }

  /// Trae el usuario que inicia sesión
  getRestaurant() async {
    restaurant = (await restaurantService.getCurrentUser())!;
  }

  /// Trae las categorías
  getCategories() async {
    categories = await categoryService.getCategories();
  }

  /// Trae los platillos
  getMeals() async {
    meals = await mealService.getMeals(
      restaurant.id!,
      'meals',
      'restaurantId',
    );
  }

  /// Trae los menús del restaurante
  getMenus() async {
    menus = await menuService.getMenus(
      restaurant.id!,
      'restaurantId',
    );
  }

  /// Ir a crear menú
  goToAddMenu() async {
    await Get.toNamed(Routes.ADD_MENU);
    getData();
  }

  /// Ir a detalle de  menú
  goToMenu(Menu menu) async {
    await Get.toNamed(Routes.MENU_DETAIL, arguments: {
      'menu': menu,
    });
  }

  /// Trae los purchases del usuario
  getPurchases() async {
    database
        .getOrderedSubcollectionSnapshotWithCondition(
      collection: 'purchases',
      orderProperty: 'created',
      whereProperty: 'restaurantId',
      equal: restaurant.id!,
      desc: true,
      limit: 100,
    )
        .listen((event) async {
      if (event.docs.isEmpty) {
        purchases = [];
      } else {
        isLoading.value = true;
        purchases = [];
        for (var element in event.docs) {
          Purchase purchase =
              Purchase.fromJson(element.data() as Map<String, dynamic>);
          purchases.add(purchase);
        }
        for (var element in purchases) {
          element.restaurant = await restaurantService
              .getUserDocumentById(element.restaurantId!);
          List<Meal> aux = await mealService.getMealsByDocumentId(
              element.mealId!, 'meals', 'id');
          element.meal = aux[0];
        }
        print('nuevo purchase');
        isLoading.value = false;
      }
    });
  }

  /// Categoría a partir de un category id
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

  /// Estado a partir del purchase
  setState(State state) {
    if (state.isPreparing! && !state.isDelivered! && !state.isInRoute!) {
      return 'En preparación';
    } else if (state.isPreparing! && !state.isDelivered! && state.isInRoute!) {
      return 'En camino';
    } else {
      return 'Entregado';
    }
  }
}
