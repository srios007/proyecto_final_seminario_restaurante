import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class NormalInput extends StatelessWidget {
  NormalInput({
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
    this.showPassword,
    this.showPasswordAction,
    this.showIcon = false,
    this.iconToShow = const Icon(CupertinoIcons.eye, color: Palette.darkBlue),
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
  RxBool? showPassword;
  VoidCallback? showPasswordAction;
  bool? showIcon;
  Icon? iconToShow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Text(
              '*',
              style: TextStyle(
                color:
                    !isRequired ? Colors.transparent : color ?? Palette.purple,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: Get.width - 81,
            child: TextFormField(
              obscureText: obscureText,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              inputFormatters: inputFormatters ?? [],
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
                suffixIcon: obscureText || showIcon!
                    ? IconButton(
                        onPressed: showPasswordAction,
                        icon: showIcon! || showPassword!.value
                            ? iconToShow!
                            : const Icon(CupertinoIcons.eye_slash,
                                color: Palette.darkBlue),
                      )
                    : const SizedBox.shrink(),
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
