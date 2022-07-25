import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/models.dart';
import 'package:proyecto_final_seminario_restaurante/app/routes/app_pages.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final box = GetStorage();

  final visiblePassword = false.obs;
  final formKeyLogin = GlobalKey<FormState>();
  Client user = Client();
  RxBool isLoading = false.obs;

  void showPassword() {
    visiblePassword.value
        ? visiblePassword.value = false
        : visiblePassword.value = true;
  }

  String? validatePassword(String? _) {
    if (passwordController.text.isEmpty) {
      return 'Por favor, rellena este campo';
    } else if (passwordController.text.length < 6) {
      return 'La longitud mínima es de 6 caracteres';
    } else {
      return null;
    }
  }

  login() async {
    if (formKeyLogin.currentState!.validate()) {
      isLoading.value = true;

      try {
        final response = await auth.signIn(
            email: emailController.text.trim(),
            password: passwordController.text);
        if (response is! String) {
          user = (await clientService.getCurrentUser())!;
          // registerDecive(user.id!);
          // user.pushNotificationsToken = box.read('pushToken');
          clientService.update(user);
          isLoading.value = false;
          Get.offAllNamed(Routes.HOME, arguments: {'user': user});
        } else {
          SnackBars.showErrorSnackBar(response);
          isLoading.value = false;
        }
        // await provider.login()
      } catch (e) {
        e.toString();
      }
    }
  }

  void recoverUser() {
    Get.toNamed(Routes.FORGOT_USER);
  }

  void recoverPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }
}
