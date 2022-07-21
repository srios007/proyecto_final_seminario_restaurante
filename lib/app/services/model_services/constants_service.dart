import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_seminario_restaurante/app/utils/utils.dart';
import '../../models/constants_model.dart';
import '../firebase_services/database_service.dart';

class ConstantsService {
  static String constantsReference = firebaseReferences.constants;

  Future<Constants> getConstants() async {
    List<Constants> constantsList = [];

    QuerySnapshot _querySnapshot =
        await database.getDataById(constantsReference, constantsReference);

    if (_querySnapshot.docs.isEmpty) return Constants();
    for (var element in _querySnapshot.docs) {
      constantsList.add(
        Constants.fromJson((element.data() as Map<String, dynamic>)),
      );
    }
    constants.firebaseVersion = constantsList[0].firebaseVersion!;
    constants.supportPhoneNumber = constantsList[0].supportPhoneNumber!;
    constants.appStoreUrl = constantsList[0].urlStores!.appStore!;
    constants.playStoreUrl = constantsList[0].urlStores!.playStore!;
    constants.productUrl = constantsList[0].urlExcel!.productUrl!;
    constants.servicesUrl = constantsList[0].urlExcel!.servicesUrl!;
    constants.termsUrl = constantsList[0].urlTerms!.terms!;
    constants.policiesUrl = constantsList[0].urlTerms!.policies!;
    constants.supportEmail = constantsList[0].emailSender!.supportEmail!;
    constants.mailToSend = constantsList[0].emailSender!.mailToSend!;
    constants.sendGridToken = constantsList[0].emailSender!.sendGridToken!;
    constants.emailName = constantsList[0].emailSender!.emailName!;
    constants.wompiPubKey = constantsList[0].wompiKeys!.wompiPubKey!;
    constants.wompiPrvKey = constantsList[0].wompiKeys!.wompiPrvKey!;
    constants.truoraToken = constantsList[0].truoraKeys!.token!;
    constants.truoraEndpoint = constantsList[0].truoraKeys!.endpoint!;
    constants.truoraSystem = constantsList[0].truoraKeys!.system!;
    constants.truoraMinScore = constantsList[0].truoraKeys!.truoraMinScore!;
    constants.emailValidationEndpoint =
        constantsList[0].emailValidationKeys!.endpoint!;
    constants.emailValidationToken =
        constantsList[0].emailValidationKeys!.token!;

    return constantsList[0];
  }
}

ConstantsService constantsService = ConstantsService();
