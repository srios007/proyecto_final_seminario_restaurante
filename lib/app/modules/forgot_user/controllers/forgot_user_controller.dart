import 'package:proyecto_final_seminario_restaurante/app/modules/forgot_user/views/forgot_user_detail_view.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';
import 'package:proyecto_final_seminario_restaurante/app/routes/app_pages.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotUserController extends GetxController {
 final TextEditingController phoneController = TextEditingController();
  final formKeyRecoverUser = GlobalKey<FormState>();
  RxBool loading = false.obs;
  RxBool error = false.obs;
  String? recoveryEmail;

  String? validatePhone(String? _) {
    if (phoneController.text.isEmpty) {
      error.value = true;
      return null;
    } else {
      error.value = false;
      return null;
    }
  }

  void searchUserMail() async {
    if (formKeyRecoverUser.currentState!.validate() && !error.value) {
      try {
        final user = await restaurantService
            .getUserDocumentByPhoneNumber(phoneController.text);
        if (user != null) {
          recoveryEmail = user.contactInfo!.email;
          Get.to(ForgotUserDetailView());
        } else {
          SnackBars.showErrorSnackBar(
              'No existe un usuario con ese teléfono');
        }
      } catch (e) {
        SnackBars.showErrorSnackBar(
            'Lo sentimos, hubo un error haciendo la consulta');
      }
    }
  }

  void returnToLanding() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
