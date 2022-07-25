import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_final_seminario_restaurante/app/routes/app_pages.dart';

class TourController extends GetxController {
    final pageController = PageController(initialPage: 0);
  final currentIndexPage = 0.0.obs;
  final box = GetStorage();

  @override
  void onInit() {
    pageController.addListener(() {
      currentIndexPage.value = pageController.page ?? 0;
    });
    super.onInit();
  }

  onTourCompleted() {
    box.write('isTourShowed', true);
    Get.offAndToNamed(Routes.LOGIN);
  }

  Future<bool> onWillPopFunction() async {
    if ((pageController.page ?? 0) > 0) {
      pageController.animateToPage(((pageController.page ?? 0) - 1).round(),
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
      return false;
    } else {
      return true;
    }
  }

  VoidCallback? buttonFunction() {
    if ((pageController.page ?? 0) != 3) {
      pageController.animateToPage(((pageController.page ?? 0) + 1).round(),
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
      return null;
    } else {
      onTourCompleted();
      return null;
    }
  }
}