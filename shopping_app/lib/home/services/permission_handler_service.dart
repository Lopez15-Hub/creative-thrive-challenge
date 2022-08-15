import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {
  Future getCameraAccess() async => await Permission.camera.request();
  Future getStorageAccess() async => await Permission.storage.request();
  Future getCameraAcessStatus() async => await Permission.camera.status;
  Future getStorageAcessStatus() async => await Permission.storage.status;
}
