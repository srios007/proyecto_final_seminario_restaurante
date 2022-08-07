import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class AddMenuInput extends StatelessWidget {
  AddMenuInput({
    Key? key,
    required this.hintText,
    this.helperText = '',
    this.isRequired = true,
    this.obscureText = false,
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
    this.maxLines,
    this.size,
    this.onChanged,
  }) : super(key: key);

  String hintText;
  String helperText;
  bool obscureText;
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
  int? maxLines;
  double? size;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(32, 0, 40, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size ?? Get.width - 155,
            child: TextFormField(
              maxLines: maxLines ?? 1,
              obscureText: obscureText,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              inputFormatters: inputFormatters ?? [],
              onChanged: onChanged,
              decoration: InputDecoration(
                helperMaxLines: 3,
                helperText: helperText,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: hintColor ?? Palette.purple,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                errorStyle: styles.errorStyle,
                enabledBorder: enabledBorder ?? styles.borderTextField,
                focusedBorder: focusedBorder ?? styles.borderTextField,
                errorBorder: errorBorder ?? styles.borderTextField,
                focusedErrorBorder:
                    focusedErrorBorder ?? styles.borderTextField,
              ),
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
          ),
        ],
      ),
    );
  }
}
