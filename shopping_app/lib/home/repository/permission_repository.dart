import 'package:shopping_app/home/services/permission_handler_service.dart';

class PermissionRepository{
  final _permissionHandlerService = PermissionHandlerService();

  Future getCameraAccess() async => await _permissionHandlerService.getCameraAccess();
  Future getStorageAccess() async => await _permissionHandlerService.getStorageAccess();
  Future getCameraAcessStatus() async => await _permissionHandlerService.getCameraAcessStatus();
  Future getStorageAcessStatus() async => await _permissionHandlerService.getStorageAcessStatus();

}