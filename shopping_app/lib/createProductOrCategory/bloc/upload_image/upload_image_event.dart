part of 'upload_image_bloc.dart';

class UploadImageEvent extends Equatable {
  final FileModel fileModel;
  final BuildContext context;

  const UploadImageEvent({required this.fileModel, required this.context,});
  @override
  List<Object> get props => [fileModel, context];
}

class ImageWasUploadedEvent extends UploadImageEvent {
  final String imagePath;
  final FileModel file;
  final BuildContext buildContext;
  const ImageWasUploadedEvent(
        {
          required this.imagePath, 
          required this.file, 
          required this.buildContext
        })
      : super(fileModel: file, context: buildContext);
  @override
  List<Object> get props => [imagePath, file, buildContext];
}
