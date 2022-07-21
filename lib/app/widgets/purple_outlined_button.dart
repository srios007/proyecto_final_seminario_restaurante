import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/utils.dart';

class PurpleOutlinedButton extends StatelessWidget {
  PurpleOutlinedButton({
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
      () => SizedBox(
        width: width ?? 260,
        height: 55,
        child: MaterialButton(
          color: Palette.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            side: BorderSide(color: Palette.purple),
          ),
          onPressed: isLoading.value ? () {} : onPressed,
          child: isLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: Center(
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
        ),
      ),
    );
  }
}
