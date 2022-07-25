import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';

class TourPage extends StatelessWidget {
  TourPage({
    Key? key,
    required this.imageRoute,
    required this.context,
    required this.title,
    required this.label,
    this.needSpace = false,
  }) : super(key: key);

  BuildContext context;
  String imageRoute;
  String title;
  Widget label;

  bool needSpace;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Get.width,
          height: 200,
          decoration: const BoxDecoration(
            color: Palette.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  color: Palette.darkBlue,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Spacer(),
              label,
              const Spacer(),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Spacer(),
        Container(
          height: 280,
          margin: const EdgeInsets.all(15.0),
          child: Image.asset(
            imageRoute,
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
