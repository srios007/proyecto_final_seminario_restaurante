import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class StorageService {
  Future<String?> uploadFile(String userID, String folder, File file) async {
    var tmpDir = await path_provider.getTemporaryDirectory();
    var targetName = DateTime.now().millisecondsSinceEpoch;
    final compressFile = await FlutterImageCompress.compressAndGetFile(
      file.path,
      "${tmpDir.absolute.path}/$targetName.jpg",
      quality: 70,
      // minWidth: 500,
      // minHeight: 500,
    );
 
    var fstorage = FirebaseStorage.instance;
    final image = compressFile!;
    Reference storageRef = fstorage.ref().child('Users_files/$userID/$folder');
    UploadTask uploadTask = storageRef.putFile(File(image.path));
    return   await (await uploadTask).ref.getDownloadURL();
  }

  Future<bool> deleteFile({required String urlFile}) async {
    String filePath = urlFile.replaceAll(
        "https://firebasestorage.googleapis.com/v0/b/lizit-production.appspot.com/o/Users_files%2F",
        "");

    try {
      await FirebaseStorage.instance.refFromURL(urlFile).delete();
      print('Successfully deleted $filePath storage item');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}

final StorageService storageService = StorageService();
