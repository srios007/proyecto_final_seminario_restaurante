import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Mi perfil',
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: SizedBox(
                  width: Get.width,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: controller.homeController.restaurant
                                    .profilePictureUrl !=
                                ''
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: controller.homeController.restaurant
                                      .profilePictureUrl!,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              )
                            : Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 80,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        controller.homeController.restaurant.restaurantName!,
                        style: styles.nameProfile,
                      ),
                      const SizedBox(height: 50),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Correo electrónico',
                              style: styles.titleOffer,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              controller.homeController.restaurant.contactInfo!
                                  .email!,
                              style: styles.profileLabelStyle,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Número de teléfono',
                              style: styles.titleOffer,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${controller.homeController.restaurant.contactInfo!.phoneNumber!.dialingCode!} ${controller.homeController.restaurant.contactInfo!.phoneNumber!.basePhoneNumber!}',
                              style: styles.profileLabelStyle,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dirección',
                                  style: styles.titleOffer,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    controller.isLoading.value = true;
                                    await Get.toNamed(Routes.ADD_ADDRESS);
                                    controller.isLoading.value = false;
                                  },
                                  child: Text(
                                    'Editar',
                                    style: styles.editProfile,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              controller.homeController.restaurant.address ==
                                      null
                                  ? 'Sin dirección'
                                  : controller.homeController.restaurant
                                          .address!.address ??
                                      'Sin dirección',
                              style: styles.profileLabelStyle,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cuenta bancaria',
                                  style: styles.titleOffer,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    controller.isLoading.value = true;
                                    await Get.toNamed(Routes.ADD_BANK_ACCOUNT);
                                    controller.isLoading.value = false;
                                  },
                                  child: Text(
                                    'Editar',
                                    style: styles.editProfile,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              controller.homeController.restaurant
                                          .bankAccount ==
                                      null
                                  ? 'Sin cuenta'
                                  : controller.homeController.restaurant
                                          .bankAccount!.number ??
                                      'Sin cuenta',
                              style: styles.profileLabelStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
      floatingActionButton: PurpleButton(
        buttonText: 'Cerrar sesión',
        isLoading: false.obs,
        onPressed: controller.logOut,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
