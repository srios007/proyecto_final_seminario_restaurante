import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';

import '../utils/utils.dart';

class SimpleAlert extends StatelessWidget {
  SimpleAlert({
    Key? key,
    required this.title,
    required this.message,
    required this.onPressed,
    this.supportField,
    this.height,
  }) : super(key: key);

  String title;
  String message;
  void Function() onPressed;
  bool? supportField;
  double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height ?? 350,
        width: 250,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(
                    Icons.close,
                    color: Palette.darkBlue,
                    size: 32,
                  ),
                )
              ],
            ),

            // Title
            Container(
              width: 200,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Palette.darkBlue,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 25),

            // Message
            Container(
              width: 200,
              height: 80,
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Palette.darkBlue,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 45),

            // Confirm dialog button
            PurpleButton(
              buttonText: 'Aceptar',
              isLoading: false.obs,
              onPressed: onPressed,
              width: 175,
            ),
            (supportField ?? false)
                ? const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: LizitContact.launchWhatsApp,
                      child: Text(
                        'Escribir a soporte',
                        style: TextStyle(
                          color: Palette.lightBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
