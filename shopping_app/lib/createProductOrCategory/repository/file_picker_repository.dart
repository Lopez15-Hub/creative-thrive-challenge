import 'package:shopping_app/createProductOrCategory/models/file_model.dart';
import 'package:shopping_app/createProductOrCategory/services/file_picker_service.dart';

class FilePickerRepository {
  final FilePickerService _filePickerService = FilePickerService();
  Future<FileModel> openFilePicker() async => _filePickerService.openFilePicker();
}
