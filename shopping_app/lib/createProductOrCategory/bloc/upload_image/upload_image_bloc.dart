import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/createProductOrCategory/models/file_model.dart';

import 'package:shopping_app/createProductOrCategory/repository/storage_repository.dart';

import '../../../home/bloc/blocs.dart';
part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  final snackbarBloc = SnackbarBloc();
  UploadImageBloc({required this.storageRepository})
      : super(const UploadImageState('')) {
    on<UploadImageEvent>((event, emit) async {

      emit(ImageIsSubmit(imagePath: event.fileModel.path, isSubmit: true));
      await storageRepository.uploadImage(event.fileModel.path, event.fileModel.file);
      add(ImageWasUploadedEvent(imagePath: event.fileModel.path,file: event.fileModel,buildContext: event.context));
      
    });

    on<ImageWasUploadedEvent>((event, emit) {
      snackbarBloc.add(SnackbarSuccessEvent(event.context, 'Image uploaded successfully'));

      emit(UploadImageSuccess(imagePath: event.imagePath));

      emit(ImageIsSubmit(imagePath: event.fileModel.path, isSubmit: false));
    });

  }

  final StorageRepository storageRepository;
}
