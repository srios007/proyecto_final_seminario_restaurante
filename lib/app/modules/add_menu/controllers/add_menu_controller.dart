import 'package:proyecto_final_seminario_restaurante/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/snackbars.dart';
import '../../../models/category_model.dart';
import 'package:get/get.dart';

class AddMenuController extends GetxController {
  List<Category> categories = [];
  RxList categoriestoUpload = [].obs;
  HomeController homeController = Get.find();

  @override
  void onInit() {
    categories = homeController.categories;
    super.onInit();
  }

  //Selecciona la categoría
  addCategory(int position) {
    List<dynamic> auxList = [];

    auxList = categoriestoUpload
        .where((element) => element.id == categories[position].id)
        .toList();
    if (auxList.isEmpty) {
      categoriestoUpload.add(categories[position]);
    } else {
      SnackBars.showErrorSnackBar(
        'No se puede agregar dos veces la misma categoría, por favor escoge otra',
      );
    }
  }

  deleteCategory(dynamic category) {
    categoriestoUpload.remove(category);
  }
}
