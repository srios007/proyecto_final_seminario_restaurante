import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class EmailInput extends StatelessWidget {
  EmailInput({
    Key? key,
    required this.hintText,
    this.helperText = '',
    required this.textEditingController,
    this.border,
    this.textStyle,
    this.width,
  }) : super(key: key);

  String hintText;
  String helperText;
  TextEditingController textEditingController;
  InputBorder? border;
  TextStyle? textStyle;
  double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.width - 100,
      child: TextFormField(
        style: textStyle,
        decoration: InputDecoration(
          helperText: helperText,
          hintText: hintText,
          hintStyle: styles.hintTextStyle,
          errorStyle: styles.errorStyle,
          enabledBorder: styles.borderTextField,
          focusedBorder: styles.borderTextField,
          errorBorder: styles.borderTextField,
          focusedErrorBorder: styles.borderTextField,
        ),
        controller: textEditingController,
        validator: (String? _) {
          // Regex para validación de mail
          RegExp emailRegExp = RegExp("[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+");
          if (textEditingController.text.isEmpty) {
            return 'Por favor, rellena este campo';
          } else if (!emailRegExp.hasMatch(textEditingController.text)) {
            return 'Ingresa un email válido';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
