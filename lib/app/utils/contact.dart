import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/widgets.dart';
import 'utils.dart';

class LizitContact {
  static void launchWhatsApp() async {
    String phoneNumber = constants.supportPhoneNumber;
    phoneNumber.replaceAll("+", "");

    await canLaunchUrl(Uri.parse("https://wa.me/$phoneNumber"))
        ? launchUrl(Uri.parse("https://wa.me/$phoneNumber"),
            mode: LaunchMode.externalApplication)
        : showDialog(
            context: Get.context!,
            builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 8,
              backgroundColor: Palette.white,
              child: SimpleAlert(
                title: 'Error',
                message: 'No pudimos abrir Whatsapp',
                supportField: false,
                onPressed: Get.back,
              ),
            ),
          );
  }
}
