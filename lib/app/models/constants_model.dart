class Constants {
  int? commission;
  int? firebaseVersion;
  UrlStores? urlStores;
  UrlTerms? urlTerms;
  UrlExcel? urlExcel;
  EmailSender? emailSender;
  String? supportPhoneNumber;
  WompiKeys? wompiKeys;
  TruoraKeys? truoraKeys;
  EmailValidationKeys? emailValidationKeys;

  Constants({
    this.commission,
    this.firebaseVersion,
    this.urlStores,
    this.urlTerms,
    this.urlExcel,
    this.emailSender,
    this.supportPhoneNumber,
    this.wompiKeys,
    this.truoraKeys,
    this.emailValidationKeys,
  });

  Constants.fromJson(Map<String, dynamic> json) {
    commission = json['commission'];
    firebaseVersion = json['firebaseVersion'];
    urlStores = json['urlStores'] != null
        ? UrlStores?.fromJson(json['urlStores'])
        : null;
    urlTerms =
        json['urlTerms'] != null ? UrlTerms?.fromJson(json['urlTerms']) : null;
    wompiKeys = json['wompiKeys'] != null
        ? WompiKeys?.fromJson(json['wompiKeys'])
        : null;
    urlExcel =
        json['urlExcel'] != null ? UrlExcel?.fromJson(json['urlExcel']) : null;
    emailSender = json['emailSender'] != null
        ? EmailSender?.fromJson(json['emailSender'])
        : null;
    supportPhoneNumber = json['supportPhoneNumber'];
    truoraKeys = json['truoraKeys'] != null
        ? TruoraKeys?.fromJson(json['truoraKeys'])
        : null;
    emailValidationKeys = json['emailValidateKeys'] != null
        ? EmailValidationKeys?.fromJson(json['emailValidateKeys'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['commission'] = commission;
    data['firebaseVersion'] = firebaseVersion;
    if (urlStores != null) {
      data['urlStores'] = urlStores?.toJson();
    }
    if (urlTerms != null) {
      data['urlTerms'] = urlTerms?.toJson();
    }
    if (wompiKeys != null) {
      data['wompiKeys'] = wompiKeys?.toJson();
    }
    if (urlExcel != null) {
      data['urlExcel'] = urlExcel?.toJson();
    }
    if (emailSender != null) {
      data['emailSender'] = emailSender?.toJson();
    }
    data['supportPhoneNumber'] = supportPhoneNumber;

    if (truoraKeys != null) {
      data['truoraKeys'] = truoraKeys?.toJson();
    }

    return data;
  }
}

class UrlStores {
  String? appStore;
  String? playStore;

  UrlStores({this.appStore, this.playStore});

  UrlStores.fromJson(Map<String, dynamic> json) {
    appStore = json['appStore'];
    playStore = json['playStore'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['appStore'] = appStore;
    data['playStore'] = playStore;
    return data;
  }
}

class UrlTerms {
  String? policies;
  String? terms;

  UrlTerms({this.policies, this.terms});

  UrlTerms.fromJson(Map<String, dynamic> json) {
    policies = json['policies'];
    terms = json['terms'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['policies'] = policies;
    data['terms'] = terms;
    return data;
  }
}

class UrlExcel {
  String? servicesUrl;
  String? productUrl;

  UrlExcel({this.servicesUrl, this.productUrl});

  UrlExcel.fromJson(Map<String, dynamic> json) {
    servicesUrl = json['servicesUrl'];
    productUrl = json['productUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['servicesUrl'] = servicesUrl;
    data['productUrl'] = productUrl;
    return data;
  }
}

class WompiKeys {
  String? wompiPubKey;
  String? wompiPrvKey;

  WompiKeys({this.wompiPubKey, this.wompiPrvKey});

  WompiKeys.fromJson(Map<String, dynamic> json) {
    wompiPrvKey = json['wompiPrvKey'];
    wompiPubKey = json['wompiPubKey'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['wompiPubKey'] = wompiPubKey;
    data['wompiPrvKey'] = wompiPrvKey;
    return data;
  }
}

class TruoraKeys {
  String? token;
  String? endpoint;
  String? system;
  double? truoraMinScore;

  TruoraKeys({
    this.token,
    this.endpoint,
    this.system,
    this.truoraMinScore,
  });

  TruoraKeys.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    endpoint = json['endpoint'];
    system = json['system'];
    truoraMinScore = json['truoraMinScore'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['endpoint'] = endpoint;
    data['system'] = system;
    data['truoraMinScore'] = truoraMinScore;
    return data;
  }
}

class EmailValidationKeys {
  String? token;
  String? endpoint;

  EmailValidationKeys({this.token, this.endpoint});

  EmailValidationKeys.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    endpoint = json['endpoint'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['endpoint'] = endpoint;
    return data;
  }
}

class EmailSender {
  String? supportEmail;
  String? mailToSend;
  String? sendGridToken;
  String? emailName;

  EmailSender({
    this.supportEmail,
    this.mailToSend,
    this.sendGridToken,
    this.emailName,
  });

  EmailSender.fromJson(Map<String, dynamic> json) {
    supportEmail = json['supportEmail'];
    mailToSend = json['mailToSend'];
    sendGridToken = json['sendGridToken'];
    emailName = json['emailName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['supportEmail'] = supportEmail;
    data['mailToSend'] = mailToSend;
    data['sendGridToken'] = sendGridToken;
    data['emailName'] = emailName;

    return data;
  }
}
