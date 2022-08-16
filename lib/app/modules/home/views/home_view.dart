import 'package:proyecto_final_seminario_restaurante/app/modules/home/widgets/custom_drawer.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/purple_button.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import '../../../models/models.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        contextGlobal: context,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Bienvenido ${controller.restaurant.restaurantName}',
                            style: styles.titleOffer,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Aquí puedes manejar tu restaurante con la mejor tecnología y todo desde tu celular.',
                            style: styles.hintTextStyleRegister,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Mis menús',
                            style: styles.titleOffer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        controller.menus.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'No tienes menús aún',
                                  style: styles.purpleboldStyle,
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: Get.width,
                                height: 70,
                                child: ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.menus.length,
                                  itemBuilder: (context, index) {
                                    var menu = controller.menus[index];
                                    return MenuContainer(
                                      onTap: () {
                                        controller.goToMenu(menu);
                                      },
                                      menu: menu,
                                      controller: controller,
                                    );
                                  },
                                ),
                              ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Mis platillos',
                            style: styles.titleOffer,
                          ),
                        ),
                        const SizedBox(height: 15),
                        controller.meals.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'No tienes platillos aún',
                                  style: styles.purpleboldStyle,
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: Get.width,
                                height: 250,
                                child: ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.meals.length,
                                  itemBuilder: (context, index) {
                                    var meal = controller.meals[index];
                                    return MealContainer(
                                      meal: meal,
                                      controller: controller,
                                    );
                                  },
                                ),
                              ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Mis órdenes',
                              style: styles.titleOffer),
                        ),
                               const SizedBox(height: 15),
                        controller.purchases.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'No tienes órdenes aún',
                                  style: styles.purpleboldStyle,
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: Get.width,
                                height: 250,
                                child: ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.purchases.length,
                                  itemBuilder: (context, index) {
                                    var purchase = controller.purchases[index];
                                    return PurchaseContainer(
                                      purchase: purchase,
                                      controller: controller,
                                    );
                                  },
                                ),
                              ),
                        const SizedBox(height: 30),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 30,
                          ),
                          child: PurpleButton(
                            height: 40,
                            width: Get.width - 80,
                            isLoading: false.obs,
                            onPressed: controller.goToAddMenu,
                            buttonText: 'Agregar menú',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
      }),
    );
  }
}

class MealContainer extends StatelessWidget {
  MealContainer({
    Key? key,
    required this.meal,
    required this.controller,
  }) : super(key: key);

  final Meal meal;
  HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 100,
      width: 170,
      decoration: ShapeDecoration.fromBoxDecoration(
        BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 209, 208, 208),
              offset: Offset(4.0, 4.0),
              blurRadius: 8.0,
            ),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 130,
            width: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: meal.pictureUrl!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${meal.name}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Palette.purple,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Categoría: ${controller.setCategory(meal.categoryId!)}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Palette.purple,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Precio: ${currencyFormat.format(
                    meal.price,
                  ).replaceAll(',', '.')}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Palette.purple,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MenuContainer extends StatelessWidget {
  MenuContainer({
    Key? key,
    required this.menu,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  final Menu menu;
  HomeController controller;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 100,
        width: 170,
        decoration: ShapeDecoration.fromBoxDecoration(
          BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 209, 208, 208),
                offset: Offset(4.0, 4.0),
                blurRadius: 8.0,
              ),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${menu.name}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Palette.purple,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class PurchaseContainer extends StatelessWidget {
  PurchaseContainer({
    Key? key,
    required this.purchase,
    required this.controller,
  }) : super(key: key);

  final Purchase purchase;
  HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 100,
      width: 170,
      decoration: ShapeDecoration.fromBoxDecoration(
        BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 209, 208, 208),
              offset: Offset(4.0, 4.0),
              blurRadius: 8.0,
            ),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 130,
            width: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: purchase.meal!.pictureUrl!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${purchase.meal!.name}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Palette.purple,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Estado: ${controller.setState(purchase.state!)}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Palette.purple,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Total: ${currencyFormat.format(
                    purchase.prices!.total,
                  ).replaceAll(',', '.')}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Palette.purple,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
