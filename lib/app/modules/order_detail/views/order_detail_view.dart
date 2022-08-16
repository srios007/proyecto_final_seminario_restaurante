import 'package:cached_network_image/cached_network_image.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/purple_button.dart';

import '../../../utils/utils.dart';
import '../controllers/order_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  const OrderDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.purchase.meal!.name!),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: Get.width * 0.6,
                    width: Get.width * 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: controller.purchase.meal!.pictureUrl!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Estado de la orden',
                  style: styles.titleOffer,
                ),
                const SizedBox(height: 5),
                Text(
                  controller.setState(controller.purchase.state!),
                  style: styles.profileLabelStyle,
                ),
                const SizedBox(height: 20),
                const Spacer(),
                PurpleButton(
                  buttonText: 'Cambiar estado a en camino',
                  isLoading: controller.isLoadingInRoute,
                  onPressed: controller.updatePurchaseInRoute,
                ),
                const SizedBox(height: 20),
                PurpleButton(
                  buttonText: 'Cambiar estado a finalizado',
                  isLoading: controller.isLoadingisDelivered,
                  onPressed: controller.updatePurchaseIsDelivered,
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
