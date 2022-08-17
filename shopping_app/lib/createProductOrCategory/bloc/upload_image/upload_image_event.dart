part of 'upload_image_bloc.dart';

class UploadImageEvent extends Equatable {
  final FileModel fileModel;
  final BuildContext context;

  const UploadImageEvent({
    required this.fileModel,
    required this.context,
  });
  @override
  List<Object> get props => [fileModel, context];
}

class ImageWasUploadedEvent extends UploadImageEvent {
  final String imagePath;
  final FileModel file;
  final BuildContext buildContext;
  final Reference reference;
  const ImageWasUploadedEvent(
      {required this.imagePath,
      required this.file,
      required this.buildContext,
      required this.reference})
      : super(fileModel: file, context: buildContext);
  @override
  List<Object> get props => [imagePath, file, buildContext, reference];
}

class SuccessImageUpload extends UploadImageEvent {
  final String imagePath;
  final BuildContext buildContext;
  final FileModel file;
  const SuccessImageUpload({required this.imagePath, required this.buildContext,required this.file}) : super(fileModel: file, context: buildContext);
  @override
  List<Object> get props => [imagePath, buildContext, file];
}

class GetImageUrl extends UploadImageEvent {
  final BuildContext buildContext;
  final FileModel file;
  const GetImageUrl({required this.buildContext,required this.file}) : super(fileModel: file, context: buildContext);
  @override
  List<Object> get props => [buildContext, file];
}
