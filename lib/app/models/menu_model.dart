class Menu {
  String? id;
  DateTime? created;
  String? restaurantId;
  String? name;

  Menu({
    this.id,
    this.created,
    this.restaurantId,
    this.name,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'].toDate();
    restaurantId = json['restaurantId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['restaurantId'] = restaurantId;
    data['name'] = name;
    return data;
  }
}
