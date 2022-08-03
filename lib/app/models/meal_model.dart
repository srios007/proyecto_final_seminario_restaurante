import 'package:proyecto_final_seminario_restaurante/app/models/ingredient.dart';

class Meal {
  String? id;
  DateTime? created;
  String? restaurantId;
  String? name;
  String? description;
  double? price;
  bool? isAvaliable;
  int? amount;
  List<Ingredient>? ingredients;

  Meal({
    this.id,
    this.created,
    this.restaurantId,
    this.name,
    this.price,
    this.isAvaliable,
    this.amount,
    this.ingredients,
  });

  Meal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'].toDate();
    restaurantId = json['restaurantId'];
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
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['isAvaliable'] = isAvaliable;
    data['amount'] = amount;
    return data;
  }
}
