import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class PurpleButton extends StatelessWidget {
  PurpleButton({
    Key? key,
    this.buttonText,
    required this.isLoading,
    required this.onPressed,
    this.icon,
    this.width,
    this.height,
    this.fontSize,
    this.color,
    this.iconStart,
    this.borderRadius,
  }) : super(key: key);

  RxBool isLoading;
  String? buttonText;
  Widget? icon;
  bool? iconStart;
  void Function() onPressed;
  double? width;
  double? height;
  double? fontSize;
  Color? color;
  double? borderRadius;

  @override
  Widget build(BuildContext context) {
    iconStart ??= false;
    return Obx(
      () => Container(
        width: width ?? 260,
        height: height ?? 55,
        child: MaterialButton(
          child: isLoading.value
              ? Container(
                  height: 20,
                  width: 20,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Palette.white,
                    ),
                  ),
                )
              : icon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        iconStart! ? icon! : const SizedBox(),
                        iconStart!
                            ? const SizedBox(
                                width: 8,
                              )
                            : const SizedBox(),
                        Text(
                          buttonText ?? 'Continuar',
                          style: TextStyle(
                            color: Palette.white,
                            fontSize: fontSize ?? 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        iconStart! == false
                            ? const SizedBox(
                                width: 8,
                              )
                            : const SizedBox(),
                        iconStart! == false ? icon! : const SizedBox(),
                      ],
                    )
                  : Text(
                      buttonText ?? 'Continuar',
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: fontSize ?? 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
          color: color ?? Palette.purple,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 60)),
          ),
          onPressed: isLoading.value ? () {} : onPressed,
        ),
      ),
    );
  }
}
