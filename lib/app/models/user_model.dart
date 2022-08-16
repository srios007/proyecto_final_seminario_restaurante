import 'package:get/get.dart';

class User {
  String? id;
  DateTime? created;
  String? profilePictureUrl;
  ContactInfo? contactInfo;
  String? userType;
  String? password;
  CreditCard? creditCard;
  Address? address;

  User({
    this.id,
    this.created,
    this.profilePictureUrl,
    this.contactInfo,
    this.userType,
    this.password,
    this.creditCard,
    this.address,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json["created"].toDate();
    profilePictureUrl = json['profilePictureUrl'];
    contactInfo = json['contactInfo'] != null
        ? ContactInfo?.fromJson(json['contactInfo'])
        : null;
    userType = json['userType'];
    address = json['address'] != null
        ? Address.fromJson(
            json['address'],
          )
        : null;
    creditCard = json['creditCard'] != null
        ? CreditCard.fromJson(
            json['creditCard'],
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
    if (address != null) {
      data['address'] = address?.toJson();
    }
    if (creditCard != null) {
      data['creditCard'] = creditCard?.toJson();
    }
    return data;
  }
}

class ContactInfo {
  String? email;
  String? fullName;
  PhoneNumber? phoneNumber;

  ContactInfo({
    this.email,
    this.fullName,
    this.phoneNumber,
  });

  ContactInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'] != null
        ? PhoneNumber?.fromJson(json['phoneNumber'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['fullName'] = fullName;
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

class CreditCard {
  String? cardNumber;
  String? month;
  String? year;
  int? cvv;
  String? type;
  String? ownerName;
  String? ownerDocumentId;

  CreditCard({
    this.cardNumber,
    this.month,
    this.year,
    this.cvv,
    this.type,
    this.ownerName,
    this.ownerDocumentId,
  });

  CreditCard.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardNumber'];
    month = json['month'];
    year = json['year'];
    cvv = json['cvv'];
    type = json['type'];
    ownerName = json['ownerName'];
    ownerDocumentId = json['ownerDocumentId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cardNumber'] = cardNumber;
    data['month'] = month;
    data['year'] = year;
    data['cvv'] = cvv;
    data['type'] = type;
    data['ownerName'] = ownerName;
    data['ownerDocumentId'] = ownerDocumentId;
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
class UserLocation {
  String? address;
  String? additionalInfo;
  double? latitude;
  double? longitude;

  UserLocation({
    this.address,
    this.additionalInfo,
    this.latitude,
    this.longitude,
  });

  UserLocation.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    additionalInfo = json['additionalInfo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address'] = address;
    data['additionalInfo'] = additionalInfo;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}