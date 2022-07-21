import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class YellowOutlinedButton extends StatelessWidget {
  YellowOutlinedButton({
    Key? key,
    required this.buttonText,
    required this.isLoading,
    required this.onPressed,
    this.width,
  }) : super(key: key);

  RxBool isLoading;
  String buttonText;
  void Function() onPressed;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: width ?? 260,
        height: 55,
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
              : Text(
                  buttonText,
                  style: const TextStyle(
                    color: Palette.white,
                    fontSize: 18,
                  ),
                ),
          color: Palette.purple,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            side: BorderSide(color: Palette.yellow),
          ),
          onPressed: isLoading.value ? () {} : onPressed,
        ),
      ),
    );
  }
}
