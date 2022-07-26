import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/modules/forgot_password/views/forgot_password_detail_view.dart';
import 'package:proyecto_final_seminario_restaurante/app/routes/app_pages.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';

class ForgotPasswordController extends GetxController {
 final TextEditingController emailController = TextEditingController();
  final formKeyRecoverPassword = GlobalKey<FormState>();

  RxBool loading = false.obs;

  void sendRecoveryMail() async {
    if (formKeyRecoverPassword.currentState!.validate()) {
      loading.value = true;

      final error = await auth.sendPasswordReset(emailController.text);
      if (error.isNotEmpty) {
        SnackBars.showErrorSnackBar(error);
        loading.value = false;
      } else {
        loading.value = false;
        Get.to(ForgotPasswordDetailView());
      }
    }
  }

  void returnToLanding() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
