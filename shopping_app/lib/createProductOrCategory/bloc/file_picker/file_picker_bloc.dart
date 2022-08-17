import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/createProductOrCategory/models/file_model.dart';
import 'package:shopping_app/createProductOrCategory/repository/file_picker_repository.dart';


part 'file_picker_event.dart';
part 'file_picker_state.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  FilePickerBloc({required this.filePickerRepository})
      : super(FilePickerInitial()) {
    on<LauchFilePickerEvent>((event, emit) async {
       await filePickerRepository.openFilePicker().then((value) => emit(SetImageFile(file: value)));

    });
    on<CompletedEvent>((event, emit) {
      emit(IsClosed());
    });
  }
  final FilePickerRepository filePickerRepository;
}
