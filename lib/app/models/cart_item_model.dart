import 'package:get/get.dart';


class CartItem {
  DateTime? initDate;
  DateTime? endDate;


  CartItem({
    this.initDate,
    this.endDate,
  });
}

class Prices {
  double price = 0;
  double comission = 0;
  double deliveryCost = 0;
  double total = 0;
  double taxes = 0;
  double insurance = 0;

  Prices({
    required this.price,
    required this.comission,
    required this.deliveryCost,
    required this.total,
    required this.taxes,
    required this.insurance,
  });
}
