import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: Get.back,
          ),
          title: const Text(
            'Recuperar contraseña',
            style: TextStyle(
              color: Palette.darkBlue,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Form(
          key: controller.formKeyRecoverPassword,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _Message(),
                SizedBox(height: 40, width: Get.width),
                EmailInput(
                    hintText: 'Correo',
                    textEditingController: controller.emailController),
                const SizedBox(height: 100),
                PurpleButton(
                  isLoading: controller.loading,
                  buttonText: 'Recordar contraseña',
                  onPressed: controller.sendRecoveryMail,
                ),
              ],
            ),
          ),
        ));
  }
}

class _Message extends StatelessWidget {
  const _Message({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
            color: Palette.purple,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Escribe el correo relacionado a tu\ncuenta enviaremos un link para\nrestaurar la contraseña',
          style: TextStyle(
            color: Palette.darkBlue,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
