import 'package:shopping_app/createProductOrCategory/services/services.dart';

class StorageRepository{
  final StorageService _storageService = StorageService();
  Future<void> uploadImage(String filePath,String fileName) async => await _storageService.uploadImage(filePath,fileName);
}