import 'package:get/get.dart';
import '../utils/utils.dart';

class SnackBars {
  static showSuccessSnackBar(message) => Get.showSnackbar(
        GetSnackBar(
          title: '¡Listo!',
          message: message,
          duration: const Duration(seconds: 3),
          backgroundColor: Palette.green,
        ),
      );
  static showErrorSnackBar(message) => Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: message,
          duration: const Duration(seconds: 3),
        ),
      );
  static showNotificationSnackBar(message) => Get.showSnackbar(
        GetSnackBar(
          message: message,
          duration: const Duration(seconds: 3),
          backgroundColor: Palette.purple,
        ),
      );
}
