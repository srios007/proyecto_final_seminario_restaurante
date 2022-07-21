import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class PasswordInput extends StatelessWidget {
  PasswordInput({
    Key? key,
    required this.hintText,
    this.helperText = '',
    this.isRequired = true,
    required this.textEditingController,
    this.validator,
    this.color,
    this.hintColor,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.keyboardType,
    this.textCapitalization,
    this.inputFormatters,
    required this.showPassword,
    this.showPasswordAction,
  }) : super(key: key);

  String hintText;
  String helperText;
  TextEditingController textEditingController;
  bool isRequired;
  String? Function(String?)? validator;
  Color? color;
  Color? hintColor;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  InputBorder? errorBorder;
  InputBorder? focusedErrorBorder;
  TextInputType? keyboardType;
  TextCapitalization? textCapitalization;
  List<TextInputFormatter>? inputFormatters;
  RxBool showPassword = false.obs;
  VoidCallback? showPasswordAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Container(
                width: Get.width - 70,
                child: TextFormField(
                  obscureText: !showPassword.value,
                  textCapitalization:
                      textCapitalization ?? TextCapitalization.none,
                  inputFormatters: inputFormatters ?? [],
                  decoration: InputDecoration(
                      helperMaxLines: 3,
                      helperText: helperText,
                      hintText: hintText,
                      hintStyle: styles.hintTextStyleRegister,
                      errorStyle: styles.errorStyle,
                      enabledBorder: enabledBorder ?? styles.borderTextField,
                      focusedBorder: focusedBorder ?? styles.borderTextField,
                      errorBorder: errorBorder ?? styles.borderTextField,
                      focusedErrorBorder:
                          focusedErrorBorder ?? styles.borderTextField,
                      suffixIcon: IconButton(
                        onPressed: showPasswordAction,
                        icon: showPassword.value
                            ? const Icon(CupertinoIcons.eye,
                                color: Palette.darkBlue)
                            : const Icon(CupertinoIcons.eye_slash,
                                color: Palette.darkBlue),
                      )),
                  controller: textEditingController,
                  validator: validator ??
                      (String? _) {
                        if (textEditingController.text.isEmpty) {
                          return 'Por favor, rellena este campo';
                        } else {
                          return null;
                        }
                      },
                  keyboardType: keyboardType ?? TextInputType.text,
                ),
              )),
        ],
      ),
    );
  }
}
