import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopping_app/createProductOrCategory/services/services.dart';

class StorageRepository{
  final StorageService _storageService = StorageService();
  Future<TaskSnapshot> uploadImage(String filePath,String fileName) async => await _storageService.uploadImage(filePath,fileName);
  Future<String> getImageUrl(Reference imageReference) async => await _storageService.downloadLink(imageReference);
}