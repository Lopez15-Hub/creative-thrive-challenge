import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class StorageService {
  final _storage = FirebaseStorage.instance
      .refFromURL("gs://creativethrivechallenge.appspot.com/productImages/");
  Reference _storageReference = FirebaseStorage.instance.ref();
  get storage => _storage;
  get storageReference => _storageReference;
  set storageRef(value) => _storageReference = value;
  Future<String> uploadImage(String filePath, String fileName) async {
    File file = File(filePath);
    String newTagfile = 'product_$fileName';
    try {
      await _storage.child(newTagfile).putFile(file);
      return _storage.child(newTagfile).getDownloadURL();
    } on FirebaseException catch (error) {
      throw Exception(error.message);
    }
  }

  Future<String> downloadLink(Reference ref) async {
    String imageLink = '';
    ref.getDownloadURL().then((value) => imageLink = value);

    await Clipboard.setData(
      ClipboardData(text: imageLink),
    );
    return Future.value(imageLink);
  }
}
