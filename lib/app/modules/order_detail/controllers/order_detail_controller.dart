import 'package:proyecto_final_seminario_restaurante/app/services/firebase_services/database_service.dart';

import '../../../models/models.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  Purchase purchase = Purchase();
  RxBool isLoadingInRoute = false.obs;
  RxBool isLoadingisDelivered = false.obs;

  @override
  void onInit() {
    purchase = Get.arguments['purchase'];
    super.onInit();
  }

  /// Estado a partir del purchase
  setState(State state) {
    if (state.isPreparing! && !state.isDelivered! && !state.isInRoute!) {
      return 'En preparación';
    } else if (state.isPreparing! && !state.isDelivered! && state.isInRoute!) {
      return 'En camino';
    } else {
      return 'Entregado';
    }
  }

  /// Actualizar el estado del purchase a en camino
  updatePurchaseInRoute() async {
    isLoadingInRoute.value = true;
    purchase.state!.isPreparing = true;
    purchase.state!.isInRoute = true;
    purchase.state!.isDelivered = false;
    database.updateDocument(purchase.id, purchase.toJson(), 'purchases');
    isLoadingInRoute.value = false;
    Get.back();
  }

  /// Actualizar el estado del purchase a entregado
  updatePurchaseIsDelivered() async {
    isLoadingisDelivered.value = true;
    purchase.state!.isPreparing = true;
    purchase.state!.isInRoute = true;
    purchase.state!.isDelivered = true;
    database.updateDocument(purchase.id, purchase.toJson(), 'purchases');
    isLoadingisDelivered.value = false;
    Get.back();
  }
}
