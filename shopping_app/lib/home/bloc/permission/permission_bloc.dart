import 'package:bloc/bloc.dart';
import '../../repository/permission_repository.dart';
part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc({required this.permissionRepository})
      : super(PermissionInitial()) {
    on<GetCameraPermissionEvent>((event, emit) {
      permissionRepository.getCameraAccess();
    });
  }
  final PermissionRepository permissionRepository;
}
