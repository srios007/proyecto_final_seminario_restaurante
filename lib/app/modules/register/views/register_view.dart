import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.white,
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: controller.formKeyRegister,
              child: Column(
                children: [
                  const Spacer(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Regístrate y\ndisfruta de ',
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
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        profilePictureAlert(context);
                      },
                      child: Obx(
                        () {
                          return controller.isLoadingPP.value
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Palette.white,
                                  ),
                                  child: const CircularProgressIndicator(),
                                )
                              : controller.profilePicture != null
                                  ? Container(
                                      height: 100,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          controller.profilePicture!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: Palette.darkBlue,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Añadir\nfoto',
                                          style: TextStyle(
                                            color: Palette.purple,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                        },
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  NormalInput(
                    isRequired: false,
                    hintText: 'Nombre del restaurante',
                    textEditingController: controller.restaurantNameController,
                  ),
                  const SizedBox(height: 20),
                  _PhoneNumberInput(controller: controller),
                  const SizedBox(height: 20),
                  EmailInput(
                    hintText: 'Correo',
                    textEditingController: controller.emailController,
                  ),
                  const SizedBox(height: 20),
                  _PasswordInput(controller: controller),
                  const SizedBox(height: 50),
                  PurpleButton(
                    buttonText: 'Regístrate',
                    isLoading: controller.isLoading,
                    onPressed: controller.createAccount,
                  ),
                  const Spacer(),
                  const SizedBox(height: 30),
                  _LogIn(controller: controller),
                  const SizedBox(height: 30),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void profilePictureAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          scrollable: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 0, 24),
          content: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.account_circle_rounded,
                      color: Palette.purple,
                      size: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Sube una imagen para tu perfil de Lizit",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    PurpleButton(
                      onPressed: () async {
                        Get.back();

                        await controller.getProfilePicture(false);
                      },
                      buttonText: 'Desde galería',
                      isLoading: false.obs,
                    ),
                    const SizedBox(height: 30),
                    PurpleButton(
                      onPressed: () async {
                        Get.back();

                        await controller.getProfilePicture(true);
                      },
                      buttonText: 'Tomar foto',
                      isLoading: false.obs,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: Get.back,
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Palette.darkBlue,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                CountryCodePicker(
                  onChanged: (c) {
                    controller.phoneNumber.dialingCode = c.dialCode;
                    controller.phoneNumber.code = c.code;
                  },
                  initialSelection: 'CO',
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Palette.darkBlue,
                ),
                const SizedBox(width: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  child: TextFormField(
                    controller: controller.phoneController,
                    keyboardAppearance: Brightness.light,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ej: 3147714545',
                    ),
                    keyboardType: TextInputType.number,
                    validator: controller.validatePhone,
                    onChanged: (t) {},
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => controller.error.value
                ? const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'Por favor, rellena este campo',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 10),
          const Text(
            'Código de area + Número de celular',
            style: TextStyle(
              color: Palette.darkBlue,
            ),
          ),
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

  final RegisterController controller;

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

  final RegisterController controller;

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

  final RegisterController controller;

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

class _LogIn extends StatelessWidget {
  const _LogIn({
    required this.controller,
  });

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: controller.logIn,
        style: TextButton.styleFrom(
          primary: Palette.white,
        ),
        child: const Text(
          'Ya tienes una cuenta?, inicia sesión',
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
