import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/add_address_controller.dart';
import '../../../../widgets/purple_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../utils/utils.dart';
import 'package:get/get.dart';
import 'dart:async';

class AddAddressView extends GetView<AddAddressController> {
  AddAddressView({Key? key}) : super(key: key);
  late final Completer<GoogleMapController> mapController = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Dirección',
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Obx(
              () => GoogleMap(
                onTap: (latLng) async {
                  controller.addMarker(latLng);
                  controller.currentPosition = latLng;
                  await controller.convertCordinates();
                },
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                myLocationButtonEnabled: false,
                initialCameraPosition: controller.currentCameraPosition,
                markers: Set<Marker>.of(controller.allMarkers),
                onMapCreated: (GoogleMapController controller) {
                  mapController.complete(controller);
                },
              ),
            ),
          ),
          SizedBox(
            height: Get.height,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _AditionalInfoTextField(
                    title: 'Información adicional',
                    titleColor: Palette.purple,
                    color: Colors.transparent,
                    hintText:
                        'Ejemplo: Barrio, apartamento, casa, manzana, etc',
                    textEditingController: controller.additionalInfoController,
                    maxLines: 2,
                    error: false.obs,
                  ),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: PurpleButton(
                      width: 272,
                      height: 67,
                      borderRadius: 30,
                      isLoading: false.obs,
                      onPressed: controller.createAddress,
                      buttonText: 'Siguiente',
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          Form(
            key: controller.q2FormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => !controller.isOpening.value
                        ? Container(
                            height: 180,
                            width: Get.width,
                            decoration: const BoxDecoration(
                              color: Palette.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Text(
                                    'Escribe tu dirección',
                                    style: TextStyle(
                                      color: Palette.darkBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _ButtonSearch(
                                  onChanged: (value) {},
                                  onTap: () async {
                                    controller.openContainer();
                                  },
                                  hintText: '',
                                  textEditingController:
                                      controller.addressController,
                                  error: false.obs,
                                  enabled: false,
                                  autofocus: false,
                                ),
                                const SizedBox(height: 10),
                                CupertinoButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  onPressed: () async {
                                    controller.locateMe(mapController);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Icon(
                                          Icons.pin_drop,
                                          color: Palette.purple,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Usar mi ubicación actual',
                                        style: const TextStyle(
                                          color: Palette.purple,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textScaleFactor:
                                            context.textScaleFactor > 1.2
                                                ? 1.2
                                                : context.textScaleFactor,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : AnimatedContainer(
                            height: 356,
                            width: Get.width,
                            decoration: const BoxDecoration(
                              color: Palette.white,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                              ),
                            ),
                            duration: const Duration(milliseconds: 500),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 40),
                                  child: Text(
                                    'Escribe tu dirección',
                                    style: TextStyle(
                                      color: Palette.darkBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SearchTextField(
                                  controller: controller,
                                  mapController: mapController,
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AditionalInfoTextField extends StatelessWidget {
  _AditionalInfoTextField({
    Key? key,
    required this.hintText,
    required this.title,
    required this.textEditingController,
    required this.error,
    this.color,
    this.maxLines,
    this.titleColor,
  }) : super(key: key);

  String hintText;
  bool? isRequired;
  TextEditingController textEditingController;
  String? Function(String?)? validator;
  Color? color;
  String? title;
  int? maxLines;
  double? width;
  Color? titleColor;
  RxBool? error;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: titleColor ?? Palette.darkBlue,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width ?? Get.width - 140,
                  child: TextFormField(
                    controller: textEditingController,
                    maxLines: maxLines ?? 1,
                    style: const TextStyle(
                      color: Palette.darkBlue,
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      border: styles.noBorder,
                      enabledBorder: styles.noBorder,
                      focusedBorder: styles.noBorder,
                      errorBorder: styles.noBorder,
                      focusedErrorBorder: styles.noBorder,
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        color: Palette.lightGray,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonSearch extends StatelessWidget {
  _ButtonSearch({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.error,
    required this.onTap,
    required this.onChanged,
    required this.enabled,
    required this.autofocus,
  }) : super(key: key);

  String hintText;
  TextEditingController textEditingController;
  Color? color;
  int? maxLines;
  double? width;
  Color? titleColor;
  RxBool? error;
  bool enabled;
  bool autofocus;
  void Function() onTap;
  void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width ?? Get.width - 80,
              child: TextFormField(
                autofocus: autofocus,
                enabled: enabled,
                controller: textEditingController,
                onChanged: onChanged,
                style: const TextStyle(
                  color: Palette.darkBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(15.0),
                    // child: Image.asset(
                    //   iconsReferences.pinMap,
                    //   height: 20,
                    //   width: 20,
                    //   color: Palette.lightGray,
                    // ),
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(15.0),
                    // child: Image.asset(
                    //   iconsReferences.searchMap,
                    //   height: 20,
                    //   width: 20,
                    //   color: Palette.lightGray,
                    // ),
                  ),
                  border: styles.noBorder,
                  enabledBorder: styles.noBorder,
                  focusedBorder: styles.noBorder,
                  errorBorder: styles.noBorder,
                  focusedErrorBorder: styles.noBorder,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Palette.lightGray,
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatefulWidget {
  SearchTextField({
    required this.controller,
    required this.mapController,
  });
  AddAddressController? controller;
  Completer<GoogleMapController> mapController;

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  void initState() {
    String apiKey = 'AIzaSyCGjgzJM6m3KEjVtNoO2dL1X_cSZqvNDzo';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 303,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _ButtonSearch(
            onChanged: (value) {},
            onTap: () {
              widget.controller!.openContainer();
            },
            hintText: '',
            textEditingController: widget.controller!.addressController,
            error: false.obs,
            enabled: true,
            autofocus: true,
          ),
          const SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: [
                CupertinoButton(
                  onPressed: () {
                    widget.controller!.locateMe(widget.mapController);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.pin_drop),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Usar mi ubicación actual',
                        style: const TextStyle(
                          color: Palette.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textScaleFactor: context.textScaleFactor > 1.2
                            ? 1.2
                            : context.textScaleFactor,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CupertinoButton(
                  onPressed: () {
                    widget.controller!.closeContainer();
                  },
                  child: const Icon(
                    Icons.close,
                    color: Palette.purple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
