class Ingredient {
  String? id;
  String? name;
  String? description;
  double? price;
  bool? isAvaliable;
  int? amount;
  int? amountMeasure;
  int? amountIngredient;
  bool? isSpicy;
  bool? isMandatory;

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
