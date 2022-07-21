import 'package:get/get.dart';

class User {
  String? id;
  DateTime? created;
  String? description;
  String? profilePictureUrl;
  ContactInfo? contactInfo;
  UserStatus? userStatus;
  double? clientRating;
  double? lizerRating;
  String? role;
  String? userType;
  String? pushNotificationsToken;
  String? password;
  ExtraConfig? extraConfig;
  List<BankAccount> bankAccounts = [];
  List<CreditCard> creditCards = [];
  List<Address> addresses = [];

  User({
    this.id,
    this.created,
    this.description,
    this.profilePictureUrl,
    this.contactInfo,
    this.userStatus,
    this.clientRating,
    this.lizerRating,
    this.role,
    this.userType,
    this.pushNotificationsToken,
    this.password,
    this.extraConfig,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    created = json["created"].toDate();
    description = json['description'];
    profilePictureUrl = json['profilePictureUrl'];
    contactInfo = json['contactInfo'] != null
        ? ContactInfo?.fromJson(json['contactInfo'])
        : null;
    userStatus = json['userStatus'] != null
        ? UserStatus?.fromJson(json['userStatus'])
        : null;
    clientRating = json['clientRating'];
    lizerRating = json['lizerRating'];
    role = json['role'];
    userType = json['userType'];
    pushNotificationsToken = json['pushNotificationsToken'];
    extraConfig = json['extraConfig'] != null
        ? ExtraConfig?.fromJson(json['extraConfig'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['description'] = description;
    data['profilePictureUrl'] = profilePictureUrl;
    if (contactInfo != null) {
      data['contactInfo'] = contactInfo?.toJson();
    }
    if (userStatus != null) {
      data['userStatus'] = userStatus?.toJson();
    }
    data['clientRating'] = clientRating;
    data['lizerRating'] = lizerRating;
    data['role'] = role;
    data['userType'] = userType;
    data['pushNotificationsToken'] = pushNotificationsToken;
    if (extraConfig != null) {
      data['extraConfig'] = extraConfig?.toJson();
    }
    return data;
  }
}

class ContactInfo {
  String? name;
  String? lastName;
  String? email;
  Document? document;
  PhoneNumber? phoneNumber;

  ContactInfo(
      {this.name, this.lastName, this.email, this.document, this.phoneNumber});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastName = json['lastName'];
    email = json['email'];
    document =
        json['document'] != null ? Document?.fromJson(json['document']) : null;
    phoneNumber = json['phoneNumber'] != null
        ? PhoneNumber?.fromJson(json['phoneNumber'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    if (document != null) {
      data['document'] = document?.toJson();
    }
    if (phoneNumber != null) {
      data['phoneNumber'] = phoneNumber?.toJson();
    }
    return data;
  }
}

class Document {
  String? documentId;
  String? typeId;

  Document({this.documentId, this.typeId});

  Document.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'];
    typeId = json['typeId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['documentId'] = documentId;
    data['typeId'] = typeId;
    return data;
  }
}

class Truora {
  String? id;
  bool? idValidated;
  String? validationId;
  bool? isBackgroundCheck;
  String? checkId;
  String? documentId;
  double? score;
  bool? forced;

  Truora({
    this.id,
    this.idValidated,
    this.validationId,
    this.isBackgroundCheck,
    this.checkId,
    this.documentId,
    this.score,
    this.forced,
  });

  Truora.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idValidated = json['idValidated'];
    validationId = json['validationId'];
    isBackgroundCheck = json['isBackgroundCheck'];
    checkId = json['checkId'];
    documentId = json['documentId'];
    score = double.parse(json['score'].toString());
    forced = json['forced'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['idValidated'] = idValidated;
    data['validationId'] = validationId;
    data['isBackgroundCheck'] = isBackgroundCheck;
    data['checkId'] = checkId;
    data['documentId'] = documentId;
    data['score'] = score;
    data['forced'] = forced;
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

class UserStatus {
  bool? isActive;
  bool? isApproved;
  bool? isBanned;
  bool? isRejected;

  UserStatus({this.isActive, this.isApproved, this.isBanned, this.isRejected});

  UserStatus.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
    isApproved = json['isApproved'];
    isBanned = json['isBanned'];
    isRejected = json['isRejected'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isActive'] = isActive;
    data['isApproved'] = isApproved;
    data['isBanned'] = isBanned;
    data['isRejected'] = isRejected;
    return data;
  }
}

class ExtraConfig {
  bool? hasOwnTerms;
  String? ownTermsUrl;
  Contact? contact;

  ExtraConfig({this.hasOwnTerms, this.ownTermsUrl, this.contact});

  ExtraConfig.fromJson(Map<String, dynamic> json) {
    hasOwnTerms = json['hasOwnTerms'];
    ownTermsUrl = json['ownTermsUrl'];
    contact =
        json['contact'] != null ? Contact?.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hasOwnTerms'] = hasOwnTerms;
    data['ownTermsUrl'] = ownTermsUrl;
    if (contact != null) {
      data['contact'] = contact?.toJson();
    }
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
  String? country;
  String? state;
  String? city;
  String? neighborhood;
  String? typeStreet;
  String? street;
  String? number1;
  String? number2;
  String? additionalInfo;
  bool? isMainAddress;
  RxBool? isSelected = false.obs;
  Coordinates? coordinates;

  Address(
      {this.name,
      this.country,
      this.state,
      this.city,
      this.neighborhood,
      this.typeStreet,
      this.street,
      this.number1,
      this.number2,
      this.additionalInfo,
      this.isMainAddress,
      this.isSelected,
      this.coordinates});

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    neighborhood = json['neighborhood'];
    typeStreet = json['typeStreet'];
    street = json['street'];
    number1 = json['number1'];
    number2 = json['number2'];
    additionalInfo = json['additionalInfo'];
    isMainAddress = json['isMainAddress'];
    coordinates = json['coordinates'] != null
        ? Coordinates?.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['neighborhood'] = neighborhood;
    data['typeStreet'] = typeStreet;
    data['street'] = street;
    data['number1'] = number1;
    data['number2'] = number2;
    data['additionalInfo'] = additionalInfo;
    data['isMainAddress'] = isMainAddress;
    if (coordinates != null) {
      data['coordinates'] = coordinates?.toJson();
    }
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
