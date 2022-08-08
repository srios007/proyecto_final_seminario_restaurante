import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Meal {
  String? id;
  DateTime? created;
  String? restaurantId;
  String? categoryId;
  String? name;
  String? description;
  double? price;
  bool? isAvaliable;
  int? amount;
  RxList? ingredients;
  TextEditingController? nameController;
  TextEditingController? descriptionController;
  TextEditingController? priceController;
  TextEditingController? amountController;

  Meal({
    this.id,
    this.created,
    this.restaurantId,
    this.categoryId,
    this.name,
    this.price,
    this.isAvaliable,
    this.amount,
    this.ingredients,
    this.nameController,
    this.descriptionController,
    this.priceController,
    this.amountController,
  });

  Meal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'].toDate();
    restaurantId = json['restaurantId'];
    categoryId = json['categoyId'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    isAvaliable = json['isAvaliable'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['restaurantId'] = restaurantId;
    data['categoyId'] = categoryId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['isAvaliable'] = isAvaliable;
    data['amount'] = amount;
    return data;
  }
}
