import 'package:proyecto_final_seminario_restaurante/app/modules/login/controllers/login_controller.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.white,
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: controller.formKeyLogin,
              child: Column(
                children: [
                  const Spacer(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Inicia sesión y\ndisfruta de ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Palette.darkBlue,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'RondApp',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Palette.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  const SizedBox(height: 40),
                  EmailInput(
                    hintText: 'Correo',
                    textEditingController: controller.emailController,
                  ),
                  const SizedBox(height: 20),
                  _PasswordInput(controller: controller),
                  const SizedBox(height: 50),
                  PurpleButton(
                    buttonText: 'Iniciar sesión',
                    isLoading: controller.isLoading,
                    onPressed: controller.login,
                  ),
                  const Spacer(),
                  const SizedBox(height: 30),
                  _CreateAccount(controller: controller),
                  const SizedBox(height: 30),
                  _ForgotUser(controller: controller),
                  _ForgotPassword(controller: controller),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
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
    return Obx(
      () => SizedBox(
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
      ),
    );
  }
}

class _ForgotUser extends StatelessWidget {
  const _ForgotUser({
    required this.controller,
  });

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
    required this.controller,
  });

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

class _CreateAccount extends StatelessWidget {
  const _CreateAccount({
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: controller.createAccount,
        style: TextButton.styleFrom(
          primary: Palette.white,
        ),
        child: const Text(
          '¿No tienes una cuenta?, regístrate',
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
