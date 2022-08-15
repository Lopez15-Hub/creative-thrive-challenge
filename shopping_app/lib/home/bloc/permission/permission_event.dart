part of 'permission_bloc.dart';


abstract class PermissionEvent {}

class GetCameraPermissionEvent extends PermissionEvent {}
class GetLocalStoragePermissionEvent extends PermissionEvent {}
