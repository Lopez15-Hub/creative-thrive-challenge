part of 'file_picker_bloc.dart';

abstract class FilePickerState extends Equatable {}

class FilePickerInitial extends FilePickerState {
  @override
  List<Object?> get props => [];
}

class SetImageFile extends FilePickerState {
  final FileModel file;
  
  SetImageFile({required this.file});

  @override
  List<Object?> get props => [file];
}
class IsClosed extends FilePickerState {
  @override
  List<Object?> get props => [];
}
