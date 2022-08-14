import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final_seminario_restaurante/app/models/restaurant_model.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import '../firebase_services/database_service.dart';

class RestaurantService {
  static String restaurantsReference = firebaseReferences.restaurants;
  static String addressReference = firebaseReferences.addresses;

  static final RestaurantService _instance = RestaurantService._internal();

  factory RestaurantService() {
    return _instance;
  }

  RestaurantService._internal();
  var firestore = FirebaseFirestore.instance;

  //Para paginacion
  DocumentSnapshot? lastDocument;

  Future<bool> save({
    required Restaurant restaurant,
    required String customId,
  }) async {
    try {
      restaurant.created = DateTime.now();

      await database.saveUserWithCustomIdAndSubcollection(
        restaurant.toJson(),
        restaurantsReference,
        customId,
      );

      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> delete(Restaurant user) async {
    try {
      await database.deleteDocument(user.id, restaurantsReference);
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> update(Restaurant user) async {
    try {
      DocumentReference docRef = database.getDocumentReference(
        collection: restaurantsReference,
        documentId: user.id!,
      );

      await docRef.update(user.toJson());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<Restaurant?> getUserDocumentById(
    String documentId,
  ) async {
    print(documentId);
    var querySnapshot = await database.getDocument(
      collection: 'restaurants',
      documentId: documentId,
    );

    if (!querySnapshot.exists) return null;

    return Restaurant.fromJson(
      querySnapshot.data() as Map<String, dynamic>,
    );
  }

  Future<Restaurant?> getUserDocumentByPhoneNumber(
    String phoneNumber,
  ) async {
    dynamic userJson;

    var querySnapshot = await database.getCollection(
      'users',
      'contactInfo.phoneNumber.basePhoneNumber',
      phoneNumber,
    );
    if (querySnapshot.docs.isEmpty) return null;
    for (var user in querySnapshot.docs) {
      userJson = user.data();
    }
    return Restaurant.fromJson(
      userJson as Map<String, dynamic>,
    );
  }

  Future<Restaurant?> getCurrentUser() async {
    var currentFirebaseUser = auth.getCurrentUser();
    debugPrint('UID: ${currentFirebaseUser!.uid}');
    var user = await getUserDocumentById(
      currentFirebaseUser.uid,
    );
    return user;
  }
}

RestaurantService restaurantService = RestaurantService();
