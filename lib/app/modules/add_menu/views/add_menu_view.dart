import 'package:flutter/services.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/meal_model.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import '../controllers/add_menu_controller.dart';
import '../../../widgets/add_menu_input.dart';
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
      body: Form(
        key: controller.key,
        child: CustomScrollView(
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
                      controller.addCategoryMenu(index);
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
                  return controller.categoriesMenu.isNotEmpty
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
                      indexCategory: index,
                    );
                  },
                  childCount:
                      controller.categoriesMenu.length, // 1000 list items
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerMenu extends StatelessWidget {
  ContainerMenu({
    Key? key,
    required this.controller,
    required this.indexCategory,
  }) : super(key: key);

  final AddMenuController controller;
  int indexCategory;

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
      // height: 80,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                controller.categoriesMenu[indexCategory].name!,
                style: const TextStyle(fontSize: 20),
              ),
              const Spacer(),
              CupertinoButton(
                child: const Icon(
                  Icons.delete,
                  color: Palette.darkBlue,
                ),
                onPressed: () {
                  controller.deleteCategoryMenu(
                    controller.categoriesMenu[indexCategory],
                  );
                },
              ),
            ],
          ),
          Obx(() => SizedBox(
                height: 510.0 *
                    controller
                        .categoriesMenu[indexCategory].meals.value.length!,
                width: Get.width,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller
                      .categoriesMenu[indexCategory].meals.value.length,
                  itemBuilder: (context, index) {
                    var meal =
                        controller.categoriesMenu[indexCategory].meals[index];
                    return MealContainer(
                      index: index,
                      indexCategory: indexCategory,
                      meal: meal,
                      name: controller.categoriesMenu[indexCategory].name!,
                      controller: controller,
                    );
                  },
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                child: Text(
                  'Agregar \n${controller.categoriesMenu[indexCategory].name!.toLowerCase()}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Palette.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  controller.addMealToCategoryMenu(indexCategory);
                },
              ),
              CupertinoButton(
                onPressed: controller.validateMeal,
                child: const Text(
                  'Validar platos',
                  style: TextStyle(
                    fontSize: 20,
                    color: Palette.purple,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MealContainer extends StatelessWidget {
  MealContainer({
    Key? key,
    required this.index,
    required this.indexCategory,
    required this.meal,
    required this.name,
    required this.controller,
  }) : super(key: key);
  int index;
  int indexCategory;
  Meal meal;
  String name;
  AddMenuController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: 145,
      height: 480,
      decoration: ShapeDecoration.fromBoxDecoration(
        BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFD1D0D0),
              offset: Offset(4.0, 4.0),
              blurRadius: 4.0,
            ),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  '$name ${index + 1}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              CupertinoButton(
                child: const Icon(
                  Icons.delete,
                  color: Palette.darkBlue,
                ),
                onPressed: () {
                  controller.deleteMealToCategoryMenu(indexCategory, index);
                },
              ),
            ],
          ),
          AddMenuInput(
            hintText: 'Nombre',
            textEditingController: meal.nameController!,
            onChanged: (value) {
              meal.name = meal.nameController!.text;
            },
          ),
          AddMenuInput(
            maxLines: 3,
            hintText: 'Descripción',
            textEditingController: meal.descriptionController!,
            onChanged: (value) {
              meal.description = meal.descriptionController!.text;
            },
          ),
          AddMenuInput(
            hintText: 'Precio',
            textEditingController: meal.priceController!,
            onChanged: (value) {
              meal.price = double.parse(
                meal.priceController!.text.replaceAll('.', ''),
              );
            },
            inputFormatters: [
              MoneyInputFormatter(
                mantissaLength: 0,
                thousandSeparator: ThousandSeparator.Period,
              ),
            ],
            keyboardType: TextInputType.number,
          ),
          AddMenuInput(
            hintText: 'Cantidad',
            textEditingController: meal.amountController!,
            onChanged: (value) {
              meal.amount = int.parse(meal.amountController!.text);
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          Obx(() => meal.ingredients!.isEmpty
              ? const SizedBox.shrink()
              : controller.isLoading.value?
              const CircularProgressIndicator()
              :SizedBox(
                  height: 50,
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: meal.ingredients!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        height: 30,
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
                              '${meal.ingredients![index].name}',
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
                      );
                    },
                  ),
                )),
          Align(
            alignment: Alignment.center,
            child: CupertinoButton(
              child: const Text(
                'Agregar ingredientes',
                style: TextStyle(
                  fontSize: 20,
                  color: Palette.purple,
                ),
              ),
              onPressed: () {
                controller.goToAddIngredient(
                  categoryPosition: indexCategory,
                  mealPosition: index,
                  name: name,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
