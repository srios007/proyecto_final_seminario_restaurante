
class Notification {
  String? id;
  DateTime? created;
  String? purcahseId;
  String? message;
  String? status;
  bool? isSeen;
  String? type;

  Notification({
    this.id,
    this.created,
    this.purcahseId,
    this.message,
    this.status,
    this.isSeen,
    this.type,
  });

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'].toDate();
    purcahseId = json['purcahseId'];
    message = json['message'];
    status = json['status'];
    isSeen = json['isSeen'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['purcahseId'] = purcahseId;
    data['message'] = message;
    data['status'] = status;
    data['isSeen'] = isSeen;
    data['type'] = type;
    return data;
  }
}