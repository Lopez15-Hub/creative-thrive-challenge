import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final _storage = FirebaseStorage.instance.ref("/productImages/");

  Future<String> uploadImage(String filePath,String fileName) async {
    File file = File(filePath);
    String newTagfile = 'product_$fileName';
    try {
      final url = await _storage.child(newTagfile).putFile(file);
      return url.ref.getDownloadURL();
    } on FirebaseException catch (error) {
      throw Exception(error);
    }

  }

}
