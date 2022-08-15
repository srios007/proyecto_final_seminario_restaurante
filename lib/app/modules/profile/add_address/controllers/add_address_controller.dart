
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../home/controllers/home_controller.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import '../../../../models/restaurant_model.dart';
import '../../../../widgets/snackbars.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';


class AddAddressController extends GetxController {
  TextEditingController additionalInfoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<geocoding.Placemark> placemarksInfo = [];
  HomeController homeController = Get.find();
  UserLocation userLocation = UserLocation();
  List<geocoding.Placemark> placemarks = [];
  late CameraPosition currentCameraPosition;
  List<Marker> allMarkers = <Marker>[].obs;
  final q2FormKey = GlobalKey<FormState>();
  late PermissionStatus permissionGranted;
  RxBool isLoadingBtn = false.obs;

  Location location = Location();
  RxBool isOpening = false.obs;
  RxBool isLoading = false.obs;
  bool serviceEnabled = false;
  RxBool isOpen = false.obs;
  double lng = -74.085644;
  LatLng? currentPosition;
  double lat = 4.692008;

  @override
  void onInit() {
    isLoading.value = true;

    currentCameraPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 15,
    );
    addMarker(LatLng(lat, lng));
    isLoading.value = false;
    super.onInit();
  }

  // Pone mi ubicación actual en el mapa
  locateMe(Completer<GoogleMapController> googleMapController) async {
    isLoading.value = true;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        isLoading.value = false;

        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.deniedForever) {
      SnackBars.showErrorSnackBar(
        'Para utilizar mi ubicación actual, por favor ve a al configuración de tu celular y activa los permisos de ubicación de Lizit',
      );
    } else if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        SnackBars.showErrorSnackBar(
          'Para utilizar mi ubicación actual, por favor acepta los permisos de ubicación',
        );
        isLoading.value = false;
        return;
      }
    }
    await location.getLocation().then((res) async {
      final GoogleMapController controller = await googleMapController.future;
      final position = CameraPosition(
        target: LatLng(res.latitude!, res.longitude!),
        zoom: 15,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(position));

      lat = res.latitude!;
      lng = res.longitude!;
    });
    currentPosition = LatLng(lat, lng);
    addMarker(LatLng(lat, lng));
    convertCordinates();
    isLoading.value = false;
  }

  // Pone mi ubicación actual en el mapa de acuerdo a la búsqueda
  locateMeWithSearchResult(
    Completer<GoogleMapController> googleMapController,
    LatLng latlng,
  ) async {
    final GoogleMapController controller = await googleMapController.future;
    final position = CameraPosition(
      target: latlng,
      zoom: 15,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
    currentPosition = latlng;
  }

  // Abre el container de escribe tu dirección
  openContainer() {
    isOpening.value = true;
    if (!isOpen.value) {
      isOpen.value = true;

      isOpening.value = false;
    }
  }

  // Cierra el container de escribe tu dirección
  closeContainer() {
    isOpening.value = true;
    if (isOpen.value) {
      isOpen.value = false;

      isOpening.value = false;
    }
  }

  //Agrega un marcador al mapa
  void addMarker(LatLng pos) async {
    isLoading.value = true;

    Marker marker = Marker(
      markerId: const MarkerId('marker'),
      infoWindow: const InfoWindow(title: ''),
      icon: BitmapDescriptor.defaultMarker,
      position: pos,
    );
    allMarkers.add(marker);
    userLocation.latitude = pos.latitude;
    userLocation.longitude = pos.longitude;
    print('latitud: ${userLocation.latitude}');
    print('longitud: ${userLocation.longitude}');
    isLoading.value = false;
  }

  // Convierte de coordenadas a dirección
  convertCordinates() async {
    placemarks = await geocoding.placemarkFromCoordinates(
      currentPosition!.latitude,
      currentPosition!.longitude,
    );
    if (placemarks.isNotEmpty) {
      addressController.text = placemarks[0].street!;
      addressController.text = placemarks[0].street!;
      userLocation.address = placemarks[0].street;

      print('longitud: ${userLocation.longitude}');
    }
  }

  void createAddress() async {
    if (addressController.text.isNotEmpty) {
      isLoadingBtn.value = false;

      Address address = Address(
        address: addressController.text,
        additionalInfo: additionalInfoController.text,
      );
      homeController.restaurant.address = address;
      restaurantService.update(homeController.restaurant);
      Get.back();

      isLoadingBtn.value = false;
    } else {
      SnackBars.showErrorSnackBar('Por favor, llena los datos');
    }
  }
}
