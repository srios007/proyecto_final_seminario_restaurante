import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/references.dart';

class Database {
  var firestore = FirebaseFirestore.instance;

  /// Obtiene todos los registros de una coleccion
  Future<QuerySnapshot> getData(String collection) {
    return firestore.collection(collection).get();
  }

  /// Obtiene el stream de una coleccion
  Stream<QuerySnapshot> getCollectionSnapshot(String collection) {
    return firestore.collection(collection).snapshots();
  }

  /// Obtiene un documento dentro de una coleccion mediante su ID
  Future<QuerySnapshot> getDataById(String documentId, String collection) {
    return firestore
        .collection(collection)
        .where('id', isEqualTo: documentId)
        .get();
  }

  /// Obtiene un documento dentro de una coleccion mediante un campo específico
  Future<QuerySnapshot> getDataByCustonParam(
      String documentId, String collection, String param) {
    return firestore
        .collection(collection)
        .where(param, isEqualTo: documentId)
        .get();
  }

  /// Obtiene un registro de una coleccion
  Future<QuerySnapshot> getOneDataFromSubcollection({
    required String documentId,
    required String collection,
    required String subcollection,
  }) {
    return firestore
        .collection(collection)
        .doc(documentId)
        .collection(subcollection)
        .limit(1)
        .get();
  }

  /// Obtiene una subcolección dentro de una coleccion mediante el ID de un documento
  Future<QuerySnapshot> getSubcollectionFromDocumentWithLimit(
    String documentId,
    String collection,
    String subcollection,
  ) {
    return firestore
        .collection(collection)
        .doc(documentId)
        .collection(subcollection)
        .limit(5)
        .get();
  }

  /// Obtiene una subcolección dentro de una coleccion mediante el ID de un documento
  Future<QuerySnapshot<Map<String, dynamic>>> getSubcollectionFromDocument(
      String documentId, String collection, String subcollection) {
    return firestore
        .collection(collection)
        .doc(documentId)
        .collection(subcollection)
        .get();
  }

  /// Obtiene una subcolección dentro de una coleccion mediante el ID de un documento con filtro
  Future<QuerySnapshot<Map<String, dynamic>>>
      getSubcollectionFromDocumentFilter(String documentId, String collection,
          String subcollection, String property, dynamic value) {
    return firestore
        .collection(collection)
        .doc(documentId)
        .collection(subcollection)
        .where(property, isEqualTo: value)
        .get();
  }

  /// Guarda un documento dentro de una coleccion
  bool save(Map<String, dynamic> document, String collection) {
    try {
      String documentId = document['id'];

      if (documentId != null) {
        firestore.collection(collection).doc(documentId).set(document);
        return true;
      } else {
        String id = createId(collection);
        firestore.collection(collection).doc(id).set({'id': id, ...document});
        return true;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  /// Guarda un documento dentro de una coleccion
  bool saveDevice(Map<String, dynamic> document, String collection) {
    try {

      if (document['id'] != null) {
        firestore.collection(collection).doc(document['id'] ).set(document);
        return true;
      } else {
        String id = createId(collection);
        firestore.collection(collection).doc(id).set({'id': id, ...document});
        return true;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  /// Actualiza un documento ([data] debe ir en formato json {})
  Future updateDocument(documentID, data, collection) {
    return firestore.doc('$collection/$documentID').update(data);
  }

  /// Borra un documento de una coleccion
  deleteDocument(documentId, collection) async {
    return firestore.collection(collection).doc(documentId)..delete();
  }

  /// Crea un documento de una subcoleccion dentro de una coleccion
  Future<bool> createDocumentSubcollection(
    collectionDocumentId,
    collection,
    subcollection,
    data,
  ) async {
    try {
      String id = createId(collection);
      await firestore
          .collection(collection)
          .doc(collectionDocumentId)
          .collection(subcollection)
          .doc(id)
          .set({...data, 'id': id});

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  /// Borra un documento de una subcoleccion dentro de una coleccion
  deleteDocumentFromSubcollection(collectionDocumentId, collection,
      subcollectionDocumentId, subcollection) {
    return firestore
        .collection(collection)
        .doc(collectionDocumentId)
        .collection(subcollection)
        .doc(subcollectionDocumentId)
      ..delete();
  }

  /// Actualiza un documento de una subcoleccion dentro de una coleccion
  updateDocumentFromSubcollection(collectionDocumentId, collection,
      subcollectionDocumentId, subcollection, data) {
    return firestore
        .collection(collection)
        .doc(collectionDocumentId)
        .collection(subcollection)
        .doc(subcollectionDocumentId)
      ..update(data);
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

  /// Obtiene el stream de una coleccion pero filtrada
  Stream<QuerySnapshot> getCollectionSnapshotQuery(
    String collection,
    String property,
    String equal,
  ) {
    return firestore
        .collection(collection)
        .where(property, isEqualTo: equal)
        .snapshots();
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

  /// Obtiene una coleccion con una query custom
  Future<QuerySnapshot> getCollectionCustomQuery(Query query) {
    return query.get();
  }

  /// Obtiene el stream de una coleccion pero ordenada
  Stream<QuerySnapshot> getOrderedCollectionSnapshot(
    String collection,
    property,
    bool desc,
  ) {
    return firestore
        .collection(collection)
        .orderBy(property, descending: desc)
        .snapshots();
  }

  /// Obtiene el stream de una subcoleccion pero ordenada
  Stream<QuerySnapshot> getOrderedSubcollectionSnapshot({
    required String collection,
    required String subcollection,
    required String userId,
    required String orderProperty,
    required bool desc,
    required int limit,
  }) {
    return firestore
        .collection(collection)
        .doc(userId)
        .collection(subcollection)
        .limit(limit)
        .orderBy(orderProperty, descending: desc)
        .snapshots();
  }

  /// Obtiene el stream de una subcoleccion pero ordenada con una condicion
  Stream<QuerySnapshot> getOrderedSubcollectionSnapshotWithCondition({
    required String collection,
    required String subcollection,
    required String userId,
    required String orderProperty,
    required String whereProperty,
    required dynamic equal,
    required bool desc,
    required int limit,
  }) {
    return firestore
        .collection(collection)
        .doc(userId)
        .collection(subcollection)
        .where(whereProperty, isEqualTo: equal)
        .limit(limit)
        .orderBy(orderProperty, descending: desc)
        .snapshots();
  }

//query
  Future<QuerySnapshot> getNextPaginatedCollectionSnapshotQuery(
      String collection,
      String orderProperty,
      int limit,
      String filterProperty,
      dynamic filterValue,
      String filterProperty2,
      dynamic filterValue2,
      String filterProperty3,
      dynamic filterValue3,
      dynamic catId) async {
    try {
      print(
          "filterProperty: $filterProperty-v:$filterValue - filterProperty2: $filterProperty2-v:$filterValue2 - filterProperty3: $filterProperty3-v$filterValue3");
      if (catId != null) {
        var pageUserQuery = firestore
            .collection(collection)
            .where(filterProperty, arrayContains: filterValue)
            .where(filterProperty2, isEqualTo: filterValue2)
            .where(filterProperty3, isEqualTo: filterValue3)
            .where('categoryId', isEqualTo: catId)
            .orderBy(orderProperty, descending: true)
            .limit(limit);

        return await pageUserQuery.get();
      } else {
        var pageUserQuery = firestore
            .collection(collection)
            .where(filterProperty, arrayContains: filterValue)
            .where(filterProperty2, isEqualTo: filterValue2)
            .where(filterProperty3, isEqualTo: filterValue3)
            .orderBy(orderProperty, descending: true)
            .limit(limit);

        return await pageUserQuery.get();
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  /// Obtiene la siguiente subsecuencia de datos dada una coleccion
  Future<QuerySnapshot> getNextPaginatedCollectionSnapshot(
    String collection,
    String orderProperty,
    int limit,
    DocumentSnapshot? lastDocument,
    String filterProperty,
    dynamic filterValue,
  ) async {
    if (filterValue == null) {
      var pageUserQuery = firestore
          .collection(collection)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        pageUserQuery = pageUserQuery.startAfterDocument(lastDocument);
      }

      return await pageUserQuery.get();
    } else {
      var pageUserQuery = firestore
          .collection(collection)
          .where(filterProperty, isEqualTo: filterValue)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        pageUserQuery = pageUserQuery.startAfterDocument(lastDocument);
      }

      return await pageUserQuery.get();
    }
  }

  /// Obtiene la siguiente subsecuencia de datos dada una coleccion
  Future<QuerySnapshot> getNextPaginatedCollectionSnapshot2(
    String collection,
    String orderProperty,
    int limit,
    DocumentSnapshot? lastDocument,
    String filterProperty,
    dynamic filterValue,
    String filterProperty2,
    dynamic filterValue2,
  ) async {
    if (filterValue == null) {
      var pageUserQuery = firestore
          .collection(collection)
          // .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        pageUserQuery = pageUserQuery.startAfterDocument(lastDocument);
      }

      return await pageUserQuery.get();
    } else {
      var pageUserQuery;
      if (collection == 'purchases') {
        print(
            "$filterProperty- $filterValue-  $filterProperty2- $filterValue2-  limit$limit");
        pageUserQuery = firestore
            .collection(collection)
            .where(filterProperty, isEqualTo: filterValue)
            .where(filterProperty2, isEqualTo: filterValue2)
            .where('purchaseStatus.isCanceled', isEqualTo: false)
            .orderBy(orderProperty, descending: true)
            .limit(limit);
      } else {
        pageUserQuery = firestore
            .collection(collection)
            .where(filterProperty, isEqualTo: filterValue)
            .where(filterProperty2, isEqualTo: filterValue2)
            .orderBy(orderProperty, descending: true)
            .limit(limit);
      }

      if (lastDocument != null) {
        pageUserQuery = pageUserQuery.startAfterDocument(lastDocument);
      }

      return await pageUserQuery.get();
    }
  }

  /// Obtiene la siguiente subsecuencia de datos dada una coleccion 3 filtros
  Future<QuerySnapshot> getNextPaginatedCollectionSnapshot3(
    String collection,
    String orderProperty,
    int limit,
    DocumentSnapshot? lastDocument,
    String filterProperty,
    dynamic filterValue,
    String filterProperty2,
    dynamic filterValue2,
    String filterProperty3,
    dynamic filterValue3,
  ) async {
    if (filterValue == null) {
      var pageUserQuery = firestore
          .collection(collection)
          // .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        pageUserQuery = pageUserQuery.startAfterDocument(lastDocument);
      }

      return await pageUserQuery.get();
    } else {
      var pageUserQuery = firestore
          .collection(collection)
          .where(filterProperty, isEqualTo: filterValue)
          .where(filterProperty2, isEqualTo: filterValue2)
          .where(filterProperty3, isEqualTo: filterValue3)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        pageUserQuery = pageUserQuery.startAfterDocument(lastDocument);
      }

      return await pageUserQuery.get();
    }
  }

  /// Obtiene la siguiente subsecuencia de datos dada una coleccion 2 filtros
  Future<QuerySnapshot> getNextPaginatedCollectionSnapshotWithTwoFilters(
    String collection,
    String orderProperty,
    String filterProperty,
    dynamic filterValue,
    String filterProperty2,
    dynamic filterValue2,
  ) async {
    var pageUserQuery = firestore
        .collection(collection)
        .where(filterProperty, isEqualTo: filterValue)
        .where(filterProperty2, isEqualTo: filterValue2)
        .orderBy(orderProperty, descending: true);

    return await pageUserQuery.get();
  }

  /// Obtiene la siguiente subsecuencia de datos dada una coleccion 1 filtro
  Future<QuerySnapshot> getCollectionSnapshotWithFilter(
    String collection,
    String orderProperty,
    String filterProperty,
    dynamic filterValue,
  ) async {
    var pageUserQuery = firestore
        .collection(collection)
        .where(filterProperty, isEqualTo: filterValue)
        .orderBy(
          orderProperty,
          descending: true,
        );

    return await pageUserQuery.get();
  }

  /// Obtiene la siguiente subsecuencia de datos dada una coleccion 3 filtros
  Future<QuerySnapshot> getNextPaginatedCollectionSnapshot4(
    String collection,
    String orderProperty,
    int limit,
    DocumentSnapshot? lastDocument,
    String filterProperty,
    dynamic filterValue,
    String filterProperty2,
    dynamic filterValue2,
    String filterProperty3,
    dynamic filterValue3,
    String filterProperty4,
    dynamic filterValue4,
  ) async {
    if (filterValue == null) {
      var pageUserQuery = firestore
          .collection(collection)
          // .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        pageUserQuery = pageUserQuery.startAfterDocument(lastDocument);
      }

      return await pageUserQuery.get();
    } else {
      var pageUserQuery = firestore
          .collection(collection)
          .where(filterProperty, isEqualTo: filterValue)
          .where(filterProperty2, isEqualTo: filterValue2)
          .where(filterProperty3, isEqualTo: filterValue3)
          .where(filterProperty4, isEqualTo: filterValue4)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      if (lastDocument != null) {
        pageUserQuery = pageUserQuery.startAfterDocument(lastDocument);
      }

      return await pageUserQuery.get();
    }
  }

  Future<QuerySnapshot> getNextQuerySnapshot(
    DocumentSnapshot lastDocument,
    Query query,
  ) async {
    var pageQuery = query;

    pageQuery = pageQuery.startAfterDocument(lastDocument);

    return await pageQuery.get();
  }

  /// Obtiene la anteriror subsecuencia de datos dada una coleccion
  Future<QuerySnapshot> getBackPaginatedCollectionSnapshot(
    String collection,
    String orderProperty,
    int limit,
    DocumentSnapshot lastDocument,
    DocumentSnapshot firtsDocument,
    String filterProperty,
    dynamic filterValue,
  ) async {
    if (filterValue == null) {
      var pageUserQuery = firestore
          .collection(collection)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      pageUserQuery = pageUserQuery.startAfterDocument(firtsDocument);

      return await pageUserQuery.get();
    } else {
      var pageUserQuery = firestore
          .collection(collection)
          .where(filterProperty, isEqualTo: filterValue)
          .orderBy(orderProperty, descending: true)
          .limit(limit);

      pageUserQuery = pageUserQuery.startAfterDocument(firtsDocument);

      return await pageUserQuery.get();
    }
  }

  /// Obtiene el stream de una coleccion
  Stream<DocumentSnapshot> getCollectionByIDSnapshot(
    String collection,
    String id,
  ) {
    return firestore.collection(collection).doc(id).snapshots();
  }

  /// Guarda un documento dentro de una coleccion con un id custom
  Future<bool> saveUserWithCustomIdAndSubcollection(
    Map<String, dynamic> object,
    Map<String, dynamic> subcollectionData,
    String collection,
    String subCollection,
    String customId,
    Map<String, dynamic> addressData,
  ) async {
    try {
      CollectionReference collRef = firestore.collection(collection);
      DocumentReference docReferance = collRef.doc(customId);

      await firestore
          .collection(collection)
          .doc(docReferance.id)
          .set({...object});

      await firestore
          .collection(collection)
          .doc(docReferance.id)
          .collection(subCollection)
          .add(subcollectionData);

      await firestore
          .collection(collection)
          .doc(docReferance.id)
          .collection(firebaseReferences.addresses)
          .add(addressData);

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> saveWithCustomIdAndSubcollection(
    String collection,
    String subCollection,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      CollectionReference collRef = firestore.collection(collection);
      DocumentReference docReferance = collRef.doc(id);

      await firestore
          .collection(collection)
          .doc(docReferance.id)
          .collection(subCollection)
          .add(data);

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

 

  

  
  /// Guarda un documento dentro de una subcoleccion dado un ID
  Future<bool> saveDocumentInSubcollection({
    required String documentId,
    required String collection,
    required String subcollection,
    required Map<String, dynamic> subcollectionData,
  }) async {
    try {
      var reference = await firestore
          .collection(collection)
          .doc(documentId)
          .collection(subcollection)
          .add(subcollectionData);
      subcollectionData['id'] = reference.id;
      await reference.update(subcollectionData);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> batchUpdate({
    required Map<String, dynamic> data,
    required String collection,
    required String documentId,
    required String subcollection,
  }) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return firestore
        .collection(collection)
        .doc(documentId)
        .collection(subcollection)
        .get()
        .then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        batch.update(document.reference, data);
      }
      return batch.commit();
    });
  }

  Future<void> updateMultipleDocumentsFromSubcollection({
    required Map<String, dynamic> data,
    required String collection,
    required String documentId,
    required String subcollection,
  }) {
    return firestore
        .collection(collection)
        .doc(documentId)
        .collection(subcollection)
        .get()
        .then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        document.reference.update({...data, 'id': document.reference.id});
      }
    });
  }
}

final Database database = Database();
