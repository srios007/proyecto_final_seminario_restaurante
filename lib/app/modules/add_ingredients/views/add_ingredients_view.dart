import 'package:proyecto_final_seminario_restaurante/app/widgets/add_menu_input.dart';
import 'package:proyecto_final_seminario_restaurante/app/widgets/widgets.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import '../controllers/add_ingredients_controller.dart';
import '../../../models/ingredient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/utils.dart';
import 'package:get/get.dart';

class AddIngredientsView extends GetView<AddIngredientsController> {
  const AddIngredientsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.name),
        centerTitle: true,
      ),
      body: Form(
        key: controller.key,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  'Agrega un ingrediente',
                  style: styles.titleOffer,
                ),
              ),
            ),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var ingredient = controller.meal.ingredients![index];
                    return IngredientContainer(
                      index: index,
                      ingredient: ingredient,
                      controller: controller,
                    );
                  },
                  childCount:
                      controller.meal.ingredients!.length, // 1000 list items
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CupertinoButton(
                onPressed: controller.validateAndAddIngredients,
                child: const Text(
                  'Agregar ingredientes\nal menú',
                  style: TextStyle(
                    fontSize: 20,
                    color: Palette.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: PurpleButton(
                  buttonText: 'Agregar ingrediente',
                  isLoading: false.obs,
                  onPressed: controller.addIngredient,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IngredientContainer extends StatelessWidget {
  IngredientContainer({
    Key? key,
    required this.ingredient,
    required this.controller,
    required this.index,
  }) : super(key: key);

  AddIngredientsController controller;
  Ingredient ingredient;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      width: 145,
      height: 665,
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
                  'Ingrediente ${index + 1}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              CupertinoButton(
                child: const Icon(
                  Icons.delete,
                  color: Palette.darkBlue,
                ),
                onPressed: () {
                  controller.deleteIngredient(index);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          AddMenuInput(
            hintText: 'Nombre',
            size: Get.width - 112,
            textEditingController: ingredient.nameController!,
            onChanged: (value) {
              ingredient.name = ingredient.nameController!.text;
            },
          ),
          AddMenuInput(
            maxLines: 3,
            hintText: 'Descripción',
            size: Get.width - 112,
            textEditingController: ingredient.descriptionController!,
            onChanged: (value) {
              ingredient.description = ingredient.descriptionController!.text;
            },
          ),
          AddMenuInput(
            hintText: 'Precio',
            size: Get.width - 112,
            textEditingController: ingredient.priceController!,
            onChanged: (value) {
              ingredient.price = double.parse(
                ingredient.priceController!.text.replaceAll('.', ''),
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
            hintText: 'Cantidad total de unidades',
            size: Get.width - 112,
            textEditingController: ingredient.amountController!,
            onChanged: (value) {
              ingredient.amount = int.parse(ingredient.amountController!.text);
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          AddMenuInput(
            hintText: 'Cantidad por unidad',
            size: Get.width - 112,
            textEditingController: ingredient.amountIngredientController!,
            onChanged: (value) {
              ingredient.amountIngredient = int.parse(
                ingredient.amountIngredientController!.text,
              );
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          AddMenuInput(
            hintText: 'Medida de la unidad (Ej: gr)',
            size: Get.width - 112,
            textEditingController: ingredient.amountMeasureController!,
            onChanged: (value) {
              ingredient.amountMeasure =
                  ingredient.amountMeasureController!.text;
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
          Obx(() => Row(
                children: [
                  const SizedBox(width: 20),
                  Checkbox(
                    activeColor: Palette.purple,
                    value: ingredient.isSpicy!.value,
                    onChanged: (value) {
                      controller.changeIsSpicyValue(index);
                    },
                  ),
                  const SizedBox(width: 10),
                  Text('¿Es picante?', style: styles.hintTextStyle)
                ],
              )),
          Obx(() => Row(
                children: [
                  const SizedBox(width: 20),
                  Checkbox(
                    activeColor: Palette.purple,
                    value: ingredient.isMandatory!.value,
                    onChanged: (value) {
                      controller.changeIsMandatoryValue(index);
                    },
                  ),
                  const SizedBox(width: 10),
                  Text('¿Es obligatorio?', style: styles.hintTextStyle)
                ],
              )),
        ],
      ),
    );
  }
}
