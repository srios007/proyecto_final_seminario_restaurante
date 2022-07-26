import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../controllers/forgot_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotUserView extends GetView<ForgotUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: Get.back,
        ),
        title: const Text(
          'Recuperar usuario',
          style: TextStyle(
            color: Palette.darkBlue,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Form(
        key: controller.formKeyRecoverUser,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const _Message(),
              const SizedBox(height: 40),
              _PhoneNumberInput(controller: controller),
              const SizedBox(height: 100),
              PurpleButton(
                isLoading: controller.loading,
                buttonText: 'Recordar usuario',
                onPressed: controller.searchUserMail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 40),
        Text(
          '¿Olvidaste tu usuario?',
          style: TextStyle(
            color: Palette.purple,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Escribe el teléfono asociado a tu cuenta',
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

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ForgotUserController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
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
                  onChanged: (c) {},
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
