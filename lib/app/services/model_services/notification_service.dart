
import 'package:proyecto_final_seminario_restaurante/app/models/models.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';

import '../firebase_services/database_service.dart';

class NotificationService {
  Future<bool> createNotification({
    required Notification notification,
    required String userId,
  }) async {
    try {
      bool result = await database.createDocumentSubcollection(
          userId, 'users', 'notifications', notification.toJson());
      if (result) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  updateNotifications({
    required String userId,
  }) async {
    List<Notification> notificationsList = [];
    try {
      var querySnapshot = await database.getSubcollectionFromDocumentFilter(
        userId,
        'users',
        'notifications',
        'isSeen',
        false,
      );
      if (querySnapshot.docs.isEmpty) return false;
      for (var element in querySnapshot.docs) {
        Notification notifications = Notification.fromJson(element.data());
        notificationsList.add(notifications);
      }
      for (var notificationElement in notificationsList) {
        notificationElement.isSeen = true;
        database.updateDocumentFromSubcollection(
          userId,
          'users',
          notificationElement.id,
          'notifications',
          notificationElement.toJson(),
        );
      }
      return true;
    } catch (e) {
      print(e);
      SnackBars.showErrorSnackBar('Error al borrar las notificaciones');
      return false;
    }
  }

  updateNotification(
      {required String userId, required Notification notification}) async {
    try {
      notification.isSeen = true;
      database.updateDocumentFromSubcollection(
        userId,
        'users',
        notification.id,
        'notifications',
        notification.toJson(),
      );

      return true;
    } catch (e) {
      print(e);
      SnackBars.showErrorSnackBar('Error al borrar las notificaciones');
      return false;
    }
  }
}

NotificationService notificationService = NotificationService();
