part of 'navigation_bloc.dart';

abstract class NavigationEvent {
  const NavigationEvent();
  List<Object> get props => [];
}

class ChangePageViewEvent extends NavigationEvent {
  final int newIndex;

  const ChangePageViewEvent(this.newIndex);
  @override
  List<Object> get props => [newIndex];
}
