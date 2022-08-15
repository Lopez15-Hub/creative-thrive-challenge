import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image) async {
    return Future.delayed(const Duration(seconds: 5));
  }

}