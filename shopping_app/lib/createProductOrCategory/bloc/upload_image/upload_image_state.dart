part of 'upload_image_bloc.dart';

class UploadImageState extends Equatable {
  final String imageUrl;
  const UploadImageState( this.imageUrl);
  @override
  List<Object?> get props => [imageUrl];
}

class UploadImageSuccess extends UploadImageState {
  final String imagePath;
  final Reference reference;
  const UploadImageSuccess({required this.imagePath,required this.reference}) : super(imagePath);
  @override
  List<Object?> get props => [imagePath];
}

class ImageIsSubmit extends UploadImageState {
  final String imagePath;
  final bool isSubmit;
    final Reference reference;
  const ImageIsSubmit({required this.imagePath,required this.reference, this.isSubmit = false,})
      : super(imagePath);
  @override
  List<Object?> get props => [imagePath, isSubmit,reference];
}
