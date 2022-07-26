import 'package:get/get.dart';

class Restaurant {
  String? id;
  DateTime? created;
  String? profilePictureUrl;
  ContactInfo? contactInfo;
  String? userType;
  String? password;
  String? restaurantName;
  BankAccount? bankAccount;
  Address? address;

  Restaurant({
    this.id,
    this.created,
    this.profilePictureUrl,
    this.contactInfo,
    this.userType,
    this.password,
    this.restaurantName,
    this.bankAccount,
    this.address,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json["created"].toDate();
    profilePictureUrl = json['profilePictureUrl'];
    contactInfo = json['contactInfo'] != null
        ? ContactInfo?.fromJson(json['contactInfo'])
        : null;
    userType = json['userType'];
    restaurantName = json['restaurantName'];
    address = json['addresses'] != null
        ? Address.fromJson(
            json['addresses'],
          )
        : null;
    bankAccount = json['bankAccount'] != null
        ? BankAccount.fromJson(
            json['bankAccount'],
          )
        : null;
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
    data['restaurantName'] = restaurantName;
    if (address != null) {
      data['address'] = address?.toJson();
    }
    if (bankAccount != null) {
      data['bankAccount'] = bankAccount?.toJson();
    }
    return data;
  }
}

class ContactInfo {
  String? email;
  PhoneNumber? phoneNumber;

  ContactInfo({
    this.email,
    this.phoneNumber,
  });

  ContactInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phoneNumber = json['phoneNumber'] != null
        ? PhoneNumber?.fromJson(json['phoneNumber'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
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

class Address {
  String? name;
  String? additionalInfo;
  String? address;

  Address({
    this.name,
    this.additionalInfo,
    this.address,
  });

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    additionalInfo = json['additionalInfo'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['additionalInfo'] = additionalInfo;
    data['address'] = address;
    return data;
  }
}
