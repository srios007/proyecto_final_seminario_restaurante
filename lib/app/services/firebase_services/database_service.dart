import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/meal_model.dart';
import '../../models/menu_model.dart';
import '../../utils/references.dart';

class Database {
  var firestore = FirebaseFirestore.instance;

  /// Obtiene todos los registros de una coleccion
  Future<QuerySnapshot> getData(String collection) {
    return firestore.collection(collection).get();
  }

  /// Obtiene un documento dentro de una coleccion mediante un campo específico
  Future<QuerySnapshot> getDataByCustonParam(
      String documentId, String collection, String param) {
    return firestore
        .collection(collection)
        .where(param, isEqualTo: documentId)
        .get();
  }

  /// Borra un documento de una coleccion
  deleteDocument(documentId, collection) async {
    return firestore.collection(collection).doc(documentId)..delete();
  }

  /// Crea un id único en firebase
  createId(collection) {
    CollectionReference collRef = firestore.collection(collection);
    DocumentReference docReferance = collRef.doc();
    return docReferance.id;
  }

  /// Obtiene la referencia de un documento
  DocumentReference getDocumentReference({
    required String collection,
    required String documentId,
  }) {
    return firestore.collection(collection).doc(documentId);
  }

  /// Retorna un documento dado su id y en que coleccion se encuentra
  Future<DocumentSnapshot> getDocument(
      {required String documentId, required String collection}) {
    return firestore.collection(collection).doc(documentId).get();
  }

  /// Obtiene una coleccion con un parametro de filtrado
  Future<QuerySnapshot> getCollection(
    String collection,
    String property,
    dynamic equal,
  ) {
    if (property != null) {
      return firestore
          .collection(collection)
          .where(property, isEqualTo: equal)
          .get();
    } else {
      return firestore.collection(collection).get();
    }
  }

  /// Obtiene el stream de una subcoleccion pero ordenada con una condicion
  Stream<QuerySnapshot> getOrderedSubcollectionSnapshotWithCondition({
    required String collection,
    required String orderProperty,
    required String whereProperty,
    required dynamic equal,
    required bool desc,
    required int limit,
  }) {
    return firestore
        .collection(collection)
        .where(whereProperty, isEqualTo: equal)
        .limit(limit)
        .orderBy(orderProperty, descending: desc)
        .snapshots();
  }

  /// Guarda un documento dentro de una coleccion con un id custom
  Future<bool> saveUserWithCustomIdAndSubcollection(
    Map<String, dynamic> object,
    String collection,
    String customId,
  ) async {
    try {
      CollectionReference collRef = firestore.collection(collection);
      DocumentReference docReferance = collRef.doc(customId);

      await firestore
          .collection(collection)
          .doc(docReferance.id)
          .set({...object});

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> saveMealanIngredients(
      {required Meal meal,
      required String collection,
      required String customId}) async {
    try {
      CollectionReference collRef = firestore.collection(collection);
      DocumentReference docReferance = collRef.doc(customId);

      await firestore
          .collection(collection)
          .doc(docReferance.id)
          .set({...meal.toJson(), 'id': docReferance.id});

      for (int i = 0; i < meal.ingredients!.length; i++) {
        DocumentReference ingredientReference = await firestore
            .collection(collection)
            .doc(docReferance.id)
            .collection(firebaseReferences.ingredients)
            .add(meal.toJson());

        await ingredientReference
            .set({...meal.toJson(), 'id': ingredientReference.id});
      }

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> saveMenu({
    required Menu menu,
    required String collection,
    required String customId,
  }) async {
    try {
      CollectionReference collRef = firestore.collection(collection);
      DocumentReference docReferance = collRef.doc(customId);

      await firestore
          .collection(collection)
          .doc(docReferance.id)
          .set({...menu.toJson(), 'id': docReferance.id});

      return docReferance.id;
    } on Exception catch (e) {
      print(e);
      return '';
    }
  }
}

final Database database = Database();
