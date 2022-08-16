import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Ingredient {
  String? id;
  String? name;
  String? description;
  double? price;
  bool? isAvaliable;
  int? amount;
  String? amountMeasure;
  int? amountIngredient;
  RxBool? isSpicy = false.obs;
  RxBool? isMandatory = false.obs;
  TextEditingController? nameController;
  TextEditingController? descriptionController;
  TextEditingController? priceController;
  TextEditingController? amountController;
  TextEditingController? amountMeasureController;
  TextEditingController? amountIngredientController;

  Ingredient({
    this.id,
    this.name,
    this.description,
    this.price,
    this.isAvaliable,
    this.amount,
    this.amountMeasure,
    this.amountIngredient,
    this.isSpicy,
    this.isMandatory,
    this.nameController,
    this.descriptionController,
    this.priceController,
    this.amountController,
    this.amountMeasureController,
    this.amountIngredientController,
  });

  Ingredient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    isAvaliable = json['isAvaliable'];
    amount = json['amount'];
    amountMeasure = json['amountMeasure'];
    amountIngredient = json['amountIngredient'];
    isSpicy = json['isSpicy'];
    isMandatory = json['isMandatory'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['isAvaliable'] = isAvaliable;
    data['amount'] = amount;
    data['amountMeasure'] = amountMeasure;
    data['amountIngredient'] = amountIngredient;
    data['isSpicy'] = isSpicy;
    data['isMandatory'] = isMandatory;
    return data;
  }
}
