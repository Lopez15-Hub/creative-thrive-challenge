
import 'package:file_picker/file_picker.dart';
import 'package:shopping_app/createProductOrCategory/models/file_model.dart';

class FilePickerService {
  Future<FileModel> openFilePicker() async {
    FileModel fileModel = FileModel(file: '',path: ''); 
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
        
      );
      if (result != null) {
         fileModel = FileModel(
            path: result.files.single.path.toString(),
            file: result.files.single.name.toString());
      }


    } on Exception catch (error) {
      throw Exception(error);
    }
   return fileModel;
  }
}
