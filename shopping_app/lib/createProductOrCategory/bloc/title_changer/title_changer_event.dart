part of 'title_changer_bloc.dart';

abstract class TitleChangerEvent extends Equatable {
  const TitleChangerEvent();

  @override
  List<Object> get props => [];
}

class ChangeTitle extends TitleChangerEvent {
  final bool formIndex;
  const ChangeTitle(this.formIndex);
  @override
  List<Object> get props => [formIndex];
}
