part of 'bottombar_navigation_bloc.dart';

abstract class BottombarNavigationEvent {
  const BottombarNavigationEvent();
  @override
  List<Object> get props => [];
}

class ChangePageView extends BottombarNavigationEvent {
  final int newIndex;

  const ChangePageView(this.newIndex);
  @override
  List<Object> get props => [newIndex];
}
