import 'package:get/get.dart';

class Client {
  String? id;
  DateTime? created;
  String? profilePictureUrl;
  ContactInfo? contactInfo;
  String? userType;
  String? password;
  List<BankAccount> bankAccounts = [];
  List<Address> addresses = [];

  Client({
    this.id,
    this.created,
    this.profilePictureUrl,
    this.contactInfo,
    this.userType,
    this.password,
  });

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json["created"].toDate();
    profilePictureUrl = json['profilePictureUrl'];
    contactInfo = json['contactInfo'] != null
        ? ContactInfo?.fromJson(json['contactInfo'])
        : null;
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['profilePictureUrl'] = profilePictureUrl;
    if (contactInfo != null) {
      data['contactInfo'] = contactInfo?.toJson();
    }
    data['userType'] = userType;
    return data;
  }
}

class ContactInfo {
  String? name;
  String? lastName;
  String? email;
  PhoneNumber? phoneNumber;

  ContactInfo({
    this.name,
    this.lastName,
    this.email,
    this.phoneNumber,
  });

  ContactInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];

    phoneNumber = json['phoneNumber'] != null
        ? PhoneNumber?.fromJson(json['phoneNumber'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    if (phoneNumber != null) {
      data['phoneNumber'] = phoneNumber?.toJson();
    }
    return data;
  }
}

class PhoneNumber {
  String? basePhoneNumber;
  String? dialingCode;
  String? code;

  PhoneNumber({
    this.basePhoneNumber,
    this.dialingCode,
    this.code,
  });

  PhoneNumber.fromJson(Map<String, dynamic> json) {
    basePhoneNumber = json['basePhoneNumber'];
    dialingCode = json['dialingCode'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['basePhoneNumber'] = basePhoneNumber;
    data['dialingCode'] = dialingCode;
    data['code'] = code;
    return data;
  }
}

class Contact {
  bool? whatsapp;
  bool? email;
  bool? phone;
  String? startHour;
  String? endHour;

  Contact(
      {this.whatsapp, this.email, this.phone, this.startHour, this.endHour});

  Contact.fromJson(Map<String, dynamic> json) {
    whatsapp = json['whatsapp'];
    email = json['email'];
    phone = json['phone'];
    startHour = json['startHour'];
    endHour = json['endHour'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['whatsapp'] = whatsapp;
    data['email'] = email;
    data['phone'] = phone;
    data['startHour'] = startHour;
    data['endHour'] = endHour;
    return data;
  }
}

class BankAccount {
  OwnerInfo? ownerInfo;
  String? id;
  String? bank;
  String? type;
  String? number;

  BankAccount({this.ownerInfo, this.bank, this.type, this.number});

  BankAccount.fromJson(Map<String, dynamic> json) {
    ownerInfo = json['ownerInfo'] != null
        ? OwnerInfo?.fromJson(json['ownerInfo'])
        : null;
    bank = json['bank'];
    type = json['type'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    if (ownerInfo != null) {
      data['ownerInfo'] = ownerInfo?.toJson();
    }
    data['bank'] = bank;
    data['type'] = type;
    data['number'] = number;
    return data;
  }
}

class OwnerInfo {
  String? name;
  String? documentId;
  String? typeId;

  OwnerInfo({this.name, this.documentId, this.typeId});

  OwnerInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    documentId = json['documentId'];
    typeId = json['typeId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['documentId'] = documentId;
    data['typeId'] = typeId;
    return data;
  }
}

class CreditCard {
  String? id;
  String? lastFourDigits;
  int? paymentSourceId;
  String? type;

  CreditCard({this.lastFourDigits, this.paymentSourceId, this.type});

  CreditCard.fromJson(Map<String, dynamic> json) {
    lastFourDigits = json['lastFourDigits'];
    paymentSourceId = json['paymentSourceId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lastFourDigits'] = lastFourDigits;
    data['paymentSourceId'] = paymentSourceId;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}

class Address {
  String? id;
  String? name;
  String? additionalInfo;
  bool? isMainAddress;
  RxBool? isSelected = false.obs;
  Coordinates? coordinates;
  String? address;

  Address({
    this.name,
    this.additionalInfo,
    this.isMainAddress,
    this.isSelected,
    this.coordinates,
    this.address,
  });

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    additionalInfo = json['additionalInfo'];
    isMainAddress = json['isMainAddress'];
    coordinates = json['coordinates'] != null
        ? Coordinates?.fromJson(json['coordinates'])
        : null;
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['additionalInfo'] = additionalInfo;
    data['isMainAddress'] = isMainAddress;
    if (coordinates != null) {
      data['coordinates'] = coordinates?.toJson();
    }
    data['address'] = address;
    return data;
  }
}

class Coordinates {
  String? lat;
  String? lng;

  Coordinates({this.lat, this.lng});

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

