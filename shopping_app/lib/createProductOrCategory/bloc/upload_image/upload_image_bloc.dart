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
//TODO: Fix Upload image
class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  final snackbarBloc = SnackbarBloc();
  final FilePickerBloc filePickerBloc =
      FilePickerBloc(filePickerRepository: FilePickerRepository());

  UploadImageBloc({required this.storageRepository})
      : super(const UploadImageState('')) {
    on<UploadImageEvent>((event, emit) async {
      await storageRepository.uploadImage(event.fileModel.path, event.fileModel.file);
      add(TestEvent(context: event.context, fileModel: event.fileModel));
    });

    on<SuccessImageUpload>((event, emit) {
      snackbarBloc.add(
          SnackbarSuccessEvent(event.context, 'Image uploaded successfully'));
    });
  }

  final StorageRepository storageRepository;
}
