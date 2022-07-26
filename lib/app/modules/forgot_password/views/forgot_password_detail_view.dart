import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordDetailView extends GetView {
  @override
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Revisa el correo:',
                  style: TextStyle(
                    color: Palette.darkBlue,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  controller.emailController.text,
                  style: const TextStyle(
                    color: Palette.darkBlue,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enviamos un link con el cual\n podrás restaurar tu contraseña',
                  style: TextStyle(
                    color: Palette.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: TextButton(
                    onPressed: controller.returnToLanding,
                    child: Row(
                      children: const [
                        Icon(CupertinoIcons.left_chevron),
                        SizedBox(width: 5),
                        Text(
                          'Volver',
                          style: TextStyle(
                            color: Palette.lightBlue,
                            fontSize: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
