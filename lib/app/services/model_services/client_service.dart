import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_seminario_restaurante/app/services/services.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import '../../models/models.dart';
import '../../models/client_model.dart';
import '../firebase_services/database_service.dart';

class ClientService {
  static String usersReference = firebaseReferences.clients;
  static String addressReference = firebaseReferences.addresses;

  static final ClientService _instance = ClientService._internal();

  factory ClientService() {
    return _instance;
  }

  ClientService._internal();
  var firestore = FirebaseFirestore.instance;

  //Para paginacion
  DocumentSnapshot? lastDocument;

  Future<bool> save({
    required Client user,
    required String customId,
    required Address address,
  }) async {
    try {
      // user.created = DateTime.now();
      // switch (user.userType) {
      //   case 'CLIENT':
      //     await database.saveUserWithCustomIdAndSubcollection(
      //       user.toJson(),
      //       client!.toJson(),
      //       usersReference,
      //       firebaseReferences.client,
      //       customId,
      //       address.toJson(),
      //     );
      //     break;
      //   case 'BUSSINESS':
      //     await database.saveUserWithCustomIdAndSubcollection(
      //       user.toJson(),
      //       bussiness!.toJson(),
      //       usersReference,
      //       firebaseReferences.bussiness,
      //       customId,
      //       address.toJson(),
      //     );
      //     break;
      //   default:
      // }
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete(Client user) async {
    try {
      await database.deleteDocument(user.id, usersReference);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> update(Client user) async {
    try {
      DocumentReference _docRef = database.getDocumentReference(
        collection: usersReference,
        documentId: user.id!,
      );

      await _docRef.update(user.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Bank Accounts
  Future<bool> addBankAccount({
    required String documentId,
    required BankAccount bankAccount,
  }) async {
    try {
      await database.saveDocumentInSubcollection(
        collection: firebaseReferences.clients,
        subcollection: firebaseReferences.bankAccounts,
        documentId: documentId,
        subcollectionData: bankAccount.toJson(),
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteBankAccount({
    required String collectionDocumentId,
    required String subcollectionDocumentId,
  }) async {
    try {
      await database.deleteDocumentFromSubcollection(
        collectionDocumentId,
        firebaseReferences.clients,
        subcollectionDocumentId,
        firebaseReferences.bankAccounts,
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<BankAccount>> getUserBankAccounts({
    required String documentId,
  }) async {
    List<BankAccount> list = [];
    try {
      var subcollection = await database.getSubcollectionFromDocument(
          documentId,
          firebaseReferences.clients,
          firebaseReferences.bankAccounts);

      for (var bankAccountDoc in subcollection.docs) {
        var newBankAccount = BankAccount.fromJson(bankAccountDoc.data());
        newBankAccount.id = bankAccountDoc.id;
        list.add(newBankAccount);
      }
      return list;
    } on Exception catch (e) {
      print(e);
      return list;
    }
  }

  // Credit cards
  Future<bool> addCreditCard({
    required String documentId,
    required CreditCard creditCard,
  }) async {
    try {
      await database.saveDocumentInSubcollection(
        collection: firebaseReferences.clients,
        subcollection: firebaseReferences.creditCards,
        documentId: documentId,
        subcollectionData: creditCard.toJson(),
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteCreditCard({
    required String collectionDocumentId,
    required String subcollectionDocumentId,
  }) async {
    try {
      await database.deleteDocumentFromSubcollection(
        collectionDocumentId,
        firebaseReferences.clients,
        subcollectionDocumentId,
        firebaseReferences.creditCards,
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<CreditCard>> getUserCreditCards({
    required String documentId,
  }) async {
    List<CreditCard> list = [];
    try {
      var subcollection = await database.getSubcollectionFromDocument(
          documentId,
          firebaseReferences.clients,
          firebaseReferences.creditCards);

      for (var creditCardDoc in subcollection.docs) {
        var newCreditCard = CreditCard.fromJson(creditCardDoc.data());
        newCreditCard.id = creditCardDoc.id;
        list.add(newCreditCard);
      }
      return list;
    } on Exception catch (e) {
      print(e);
      return list;
    }
  }

  Future<List<Address>> getUserAddresses({
    required String documentId,
  }) async {
    List<Address> list = [];
    try {
      var subcollection = await database.getSubcollectionFromDocument(
          documentId, firebaseReferences.clients, firebaseReferences.addresses);

      for (var addressDoc in subcollection.docs) {
        var address = Address.fromJson(addressDoc.data());
        address.id = addressDoc.id;
        list.add(address);
      }
      return list;
    } on Exception catch (e) {
      print(e);
      return list;
    }
  }

  Future<bool> updateUserAddresses({
    required String collectionDocumentId,
    required String subcollectionDocumentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await database.updateDocumentFromSubcollection(
        collectionDocumentId,
        usersReference,
        subcollectionDocumentId,
        addressReference,
        data,
      );
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool?> deleteUserAddresses({
    required String collectionDocumentId,
    required String subcollectionDocumentId,
  }) async {
    try {
      await database.deleteDocumentFromSubcollection(collectionDocumentId,
          usersReference, subcollectionDocumentId, addressReference);
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Client>> getNextPaginated(
    int paginationNum,
    String filterPropery,
    dynamic filterValue,
  ) async {
    var _query = await database.getNextPaginatedCollectionSnapshot(
      usersReference,
      "createdAt",
      paginationNum,
      lastDocument!,
      filterPropery,
      filterValue,
    );

    if (_query.docs.isNotEmpty) {
      lastDocument = _query.docs.last;
      // return _query.docs.map((e) => User.fromJson(e.data())).toList();
    }

    return [];
  }

  clearPaginatedReferences() {
    lastDocument = null;
  }

  Future<Client?> getUserDocumentById(
    String documentId,
  ) async {
    var _querySnapshot = await database.getDocument(
      collection: 'users',
      documentId: documentId,
    );

    if (!_querySnapshot.exists) return null;

    return Client.fromJson(
      _querySnapshot.data() as Map<String, dynamic>,
    );
  }

  /// Gets an user by phone number
  Future<Client?> getUserDocumentByPhoneNumber(
    String phoneNumber,
  ) async {
    dynamic userJson;

    var _querySnapshot = await database.getCollection(
      'users',
      'contactInfo.phoneNumber.basePhoneNumber',
      phoneNumber,
    );
    if (_querySnapshot.docs.isEmpty) return null;

    // Loops through response although there should only be one user per phone number
    for (var user in _querySnapshot.docs) {
      userJson = user.data();
    }
    return Client.fromJson(
      userJson as Map<String, dynamic>,
    );
  }

  Future<Client?> getCurrentUser() async {
    var currentFirebaseUser = auth.getCurrentUser();
    print(currentFirebaseUser!.uid);
    var user = await getUserDocumentById(
      currentFirebaseUser.uid,
    );
    return user;
  }
}

ClientService clientService = ClientService();
