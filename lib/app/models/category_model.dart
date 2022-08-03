import 'package:get/get.dart';
import 'meal_model.dart';

class Category {
  String? id;
  String? name;
  RxBool? isSelected = false.obs;
  List<Meal>? meals;

  Category({
    this.id,
    this.name,
    this.isSelected,
    this.meals,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
