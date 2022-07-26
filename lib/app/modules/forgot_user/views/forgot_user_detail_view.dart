import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import '../controllers/forgot_user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotUserDetailView extends GetView {
  @override
  final ForgotUserController controller = Get.put(ForgotUserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Usuario recuperado',
                  style: TextStyle(
                    color: Palette.darkBlue,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'El usuario relacionado al número',
                  style: TextStyle(
                    color: Palette.darkBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '${controller.phoneController.text} es',
                  style: const TextStyle(
                    color: Palette.darkBlue,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  controller.recoveryEmail!,
                  style: const TextStyle(
                    color: Palette.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: controller.returnToLanding,
                      child: Row(
                        children: const [
                          Icon(CupertinoIcons.left_chevron),
                          SizedBox(width: 5),
                          Text(
                            'Volver',
                            style: TextStyle(
                              color: Palette.lightBlue,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
