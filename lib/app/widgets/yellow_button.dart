import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class YellowButton extends StatelessWidget {
  YellowButton({
    Key? key,
    required this.buttonText,
    required this.isLoading,
    this.width,
    required this.onPressed,
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
                      color: Palette.darkBlue,
                    ),
                  ),
                )
              : Text(
                  buttonText,
                  style: const TextStyle(
                    color: Palette.darkBlue,
                    fontSize: 18,
                  ),
                ),
          color: Palette.yellow,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
          ),
          onPressed: isLoading.value ? () {} : onPressed,
        ),
      ),
    );
  }
}
