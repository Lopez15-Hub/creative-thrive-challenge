part of 'upload_image_bloc.dart';

class UploadImageState extends Equatable {
  final String imageUrl;

  const UploadImageState(this.imageUrl);
  @override
  List<Object?> get props => [imageUrl];
}

class UploadImageSuccess extends UploadImageState {
  final String imagePath;
  const UploadImageSuccess({required this.imagePath}) : super(imagePath);
  @override
  List<Object?> get props => [imagePath];
}

class ImageIsSubmit extends UploadImageState {
  final String imagePath;
  final bool isSubmit;
  const ImageIsSubmit({required this.imagePath, this.isSubmit = false})
      : super(imagePath);
  @override
  List<Object?> get props => [imagePath, isSubmit];
}
