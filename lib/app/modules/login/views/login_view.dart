import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.yellow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height -
            kToolbarHeight -
            MediaQuery.of(Get.context!).padding.top,
        child: Form(
          key: controller.formKeyLogin,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo and message

                const SizedBox(height: 50),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: 'Inicia sesión y disfruta\nla experiencia ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Palette.darkBlue,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'lizit',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Palette.darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                EmailInput(
                  hintText: 'Correo',
                  textEditingController: controller.emailController,
                ),
                const SizedBox(height: 20),
                _PasswordInput(controller: controller),
                const SizedBox(height: 50),
                // Login button
                YellowButton(
                  buttonText: 'Iniciar',
                  isLoading: controller.isLoading,
                  onPressed: controller.login,
                  width: 175,
                ),
                const SizedBox(height: 30),
                _ForgotUser(controller: controller),
                _ForgotPassword(controller: controller),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Contraseña',
              hintStyle: styles.hintTextStyle,
              errorStyle: styles.errorStyle,
              enabledBorder: styles.borderTextField,
              focusedBorder: styles.borderTextField,
              errorBorder: styles.borderTextField,
              focusedErrorBorder: styles.borderTextField,
              suffixIcon: IconButton(
                onPressed: controller.showPassword,
                icon: controller.visiblePassword.value
                    ? const Icon(CupertinoIcons.eye, color: Palette.darkBlue)
                    : const Icon(CupertinoIcons.eye_slash,
                        color: Palette.darkBlue),
              ),
            ),
            validator: controller.validatePassword,
            controller: controller.passwordController,
            obscureText: !controller.visiblePassword.value,
          ),
        ));
  }
}

class _ForgotUser extends StatelessWidget {
  const _ForgotUser({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: controller.recoverUser,
        style: TextButton.styleFrom(
          primary: Palette.white,
        ),
        child: const Text(
          '¿Olvidaste tu usuario?',
          style: TextStyle(
            color: Palette.purple,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: controller.recoverPassword,
        style: TextButton.styleFrom(
          primary: Palette.white,
        ),
        child: const Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
            color: Palette.purple,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
