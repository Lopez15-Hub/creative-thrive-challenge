part of 'navigation_bloc.dart';

abstract class NavigationEvent {
  const NavigationEvent();
  List<Object> get props => [];
}

class ChangePageView extends NavigationEvent {
  final int newIndex;

  const ChangePageView(this.newIndex);
  @override
  List<Object> get props => [newIndex];
}
