import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import '../controllers/add_menu_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMenuView extends GetView<AddMenuController> {
  const AddMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar menú'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Escoge la categoría',
                    style: styles.titleOffer,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Recuerda que no pueden haber categorías repetidas.',
                    style: styles.hintTextStyleRegister,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: controller.homeController.categories.length,
              (BuildContext context, int index) {
                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    controller.addCategory(index);
                  },
                  child: Container(
                    height: 40,
                    width: Get.width * 0.4,
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
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '${controller.homeController.categories[index].name}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Palette.purple,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: context.textScaleFactor > 1
                              ? 1
                              : context.textScaleFactor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () {
                return controller.categoriestoUpload.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          'Menús por categoría',
                          style: styles.titleOffer,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ContainerMenu(
                    controller: controller,
                    index: index,
                  );
                },
                childCount:
                    controller.categoriestoUpload.length, // 1000 list items
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerMenu extends StatelessWidget {
  ContainerMenu({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final AddMenuController controller;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Palette.darkBlue,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 80,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                controller.categoriestoUpload[index].name!,
                style: const TextStyle(fontSize: 20),
              ),
              const Spacer(),
              CupertinoButton(
                child: const Icon(
                  Icons.delete,
                  color: Palette.darkBlue,
                ),
                onPressed: () {
                  controller.deleteCategory(
                    controller.categoriestoUpload[index],
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
