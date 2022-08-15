import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';

final currencyFormat = NumberFormat.currency(symbol: "\$", decimalDigits: 0);
final requestFormat =
    NumberFormat.currency(symbol: "", decimalDigits: 0, locale: "es_ES");

class Styles {
  TextStyle tittleRegister = const TextStyle(
    color: Palette.darkBlue,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  TextStyle tittleDrawer = const TextStyle(
    color: Palette.white,
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
  );

  TextStyle subtittleRegister = const TextStyle(
    color: Palette.darkBlue,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  TextStyle labelRegister = const TextStyle(
    color: Palette.darkBlue,
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
  );

  TextStyle hintTextStyle = const TextStyle(
    color: Palette.purple,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  TextStyle hintTextStyleRegister = const TextStyle(
    color: Palette.darkBlue,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );
  TextStyle profileLabelStyle = const TextStyle(
    color: Palette.darkBlue,
    fontSize: 15,
    fontWeight: FontWeight.w300,
  );
  TextStyle errorStyle = const TextStyle(
    fontSize: 14,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
  UnderlineInputBorder borderTextField = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Palette.darkBlue,
      width: 2.0,
    ),
  );

  InputBorder borderPhoneTextField = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Palette.darkBlue,
      width: 2.0,
    ),
    borderRadius: BorderRadius.circular(20),
  );

  InputBorder noBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Palette.white,
      width: 2.0,
    ),
    borderRadius: BorderRadius.circular(20),
  );

  OutlineInputBorder offerBorderTextField = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      width: 2,
      color: Palette.lightGray,
    ),
  );

  TextStyle titleOffer = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: Palette.darkBlue,
  );
  TextStyle editProfile = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: Palette.lightBlue,
  );
  TextStyle nameProfile = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: Palette.darkBlue,
  );
  TextStyle titleOfferCard = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Palette.darkBlue,
  );
  TextStyle purpleboldStyle = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 13,
    color: Palette.purple,
  );
  TextStyle titleHomeStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: Palette.darkBlue,
  );
  TextStyle titleOrders = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    color: Palette.darkBlue,
  );
  TextStyle hintTextStyleOffer = const TextStyle(
    color: Palette.lightGray,
    fontWeight: FontWeight.bold,
  );
}

Styles styles = Styles();
