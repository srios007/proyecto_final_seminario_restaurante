
import 'models.dart';

class CartItem {
  Meal? meal;
  DateTime? created;
  Prices? price;

  CartItem({
    this.meal,
    this.created,
    this.price,
  });
}

class Prices {
  double price = 0;
  double deliveryCost = 0;
  double total = 0;

  Prices({
    required this.price,
    required this.deliveryCost,
    required this.total,
  });

    Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    deliveryCost = json['deliveryCost'] ;
    total = json['total'];
 
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['price'] = price;
    data['deliveryCost'] = deliveryCost;
    data['total'] = total;
 
    return data;
  }
}
