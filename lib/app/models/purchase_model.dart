 
import 'package:proyecto_final_seminario_restaurante/app/models/models.dart';

import 'user_model.dart';

class Purchase {
  String? id;
  DateTime? created;
  String? restaurantId;
  String? userId;
  String? mealId;
  Prices? prices;
  State? state;
  Meal? meal;
  User? user;
  Restaurant? restaurant;

  Purchase({
    this.id,
    this.created,
    this.restaurantId,
    this.userId,
    this.mealId,
    this.prices,
    this.state,
    this.meal,
    this.user,
    this.restaurant,
  });

  Purchase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'].toDate();
    restaurantId = json['restaurantId'];
    userId = json['userId'];
    mealId = json['mealId'];
    prices = json['prices'] != null
        ? Prices.fromJson(
            json['prices'],
          )
        : null;
    state = json['state'] != null
        ? State.fromJson(
            json['state'],
          )
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['restaurantId'] = restaurantId;
    data['userId'] = userId;
    data['mealId'] = mealId;
    if (prices != null) {
      data['prices'] = prices?.toJson();
    }
    if (state != null) {
      data['state'] = state?.toJson();
    }
    return data;
  }
}

class State {
  bool? isPreparing;
  bool? isInRoute;
  bool? isDelivered;

  State({
    required this.isPreparing,
    required this.isInRoute,
    required this.isDelivered,
  });

  State.fromJson(Map<String, dynamic> json) {
    isPreparing = json['isPreparing'];
    isInRoute = json['isInRoute'];
    isDelivered = json['isDelivered'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isPreparing'] = isPreparing;
    data['isInRoute'] = isInRoute;
    data['isDelivered'] = isDelivered;

    return data;
  }
}
