import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:io';

class Meal {
  String? id;
  String? menuId;
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
  File? picture;
  String? pictureUrl;
  RxBool? isLoading = false.obs;

  Meal({
    this.id,
    this.menuId,
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
    this.picture,
    this.pictureUrl,
    this.isLoading,
  });

  Meal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menuId'];
    created = json['created'].toDate();
    restaurantId = json['restaurantId'];
    categoryId = json['categoyId'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    isAvaliable = json['isAvaliable'];
    amount = json['amount'];
    pictureUrl = json['pictureUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['menuId'] = menuId;
    data['created'] = created;
    data['restaurantId'] = restaurantId;
    data['categoyId'] = categoryId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['isAvaliable'] = isAvaliable;
    data['amount'] = amount;
    data['pictureUrl'] = pictureUrl;
    return data;
  }
}
