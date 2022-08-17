import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class StorageService {
  final _storage = FirebaseStorage.instance.refFromURL("gs://creativethrivechallenge.appspot.com/productImages/");

  Future<TaskSnapshot> uploadImage(String filePath, String fileName) async {
    File file = File(filePath);
    String newTagfile = 'product_$fileName';
    try {
      final TaskSnapshot taskSnaphot = await _storage
          .child(newTagfile)
          .putFile(file).timeout(const Duration(seconds: 60));
      return taskSnaphot;
    } on FirebaseException catch (error) {
      throw Exception(error);
    }
  }

  Future<String> downloadLink(Reference ref) async {
    String imageLink = '';
    await ref.getDownloadURL().then((value) => imageLink = value);

    await Clipboard.setData(
      ClipboardData(text: imageLink),
    );
    return Future.value(imageLink);
  }
}
