part of 'file_picker_bloc.dart';

abstract class FilePickerEvent extends Equatable {}

class LauchFilePickerEvent extends FilePickerEvent {
  @override
  List<Object?> get props => [];
}

class CompletedEvent extends FilePickerEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
