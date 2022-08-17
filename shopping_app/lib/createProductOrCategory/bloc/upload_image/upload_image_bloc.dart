import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/createProductOrCategory/bloc/blocs.dart';
import 'package:shopping_app/createProductOrCategory/models/file_model.dart';
import 'package:shopping_app/createProductOrCategory/repository/file_picker_repository.dart';

import 'package:shopping_app/createProductOrCategory/repository/storage_repository.dart';

import '../../../home/bloc/blocs.dart';
part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  final snackbarBloc = SnackbarBloc();
  final FilePickerBloc filePickerBloc =
      FilePickerBloc(filePickerRepository: FilePickerRepository());
  UploadImageBloc({required this.storageRepository})
      : super(const UploadImageState('')) {
    on<UploadImageEvent>((event, emit) async {
      emit(ImageIsSubmit(imagePath: event.fileModel.path, isSubmit: true));
      final TaskSnapshot taskSnapshot = await storageRepository.uploadImage(
          event.fileModel.path, event.fileModel.file);
      print(taskSnapshot.state);
      if (taskSnapshot.state == TaskState.success) {
      filePickerBloc.add(CompletedEvent());
        add(ImageWasUploadedEvent(
            imagePath: event.fileModel.path,
            file: event.fileModel,
            buildContext: event.context,
            reference: taskSnapshot.ref));
      }

      if (taskSnapshot.state == TaskState.error) {
        taskSnapshot.ref.delete();
      }
    });

    on<ImageWasUploadedEvent>((event, emit) async {
      final String imageUrl = await storageRepository.getImageUrl(event.reference);
      print(imageUrl);
      emit(UploadImageSuccess(imagePath: imageUrl));
      emit(ImageIsSubmit(imagePath: imageUrl, isSubmit: false));

    });
    on<SuccessImageUpload>((event, emit) {
      snackbarBloc.add(
          SnackbarSuccessEvent(event.context, 'Image uploaded successfully'));
    });
  }

  final StorageRepository storageRepository;
}
