import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_seminario_restaurante/app/routes/app_pages.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';

class ProfileController extends GetxController {
  HomeController homeController = Get.find();
  RxBool isLoading = false.obs;

  logOut() async {
    await auth.signOut();
    Get.toNamed(Routes.LOGIN);
  }
}
