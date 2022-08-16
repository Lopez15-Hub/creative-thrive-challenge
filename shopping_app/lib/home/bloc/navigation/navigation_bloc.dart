import 'package:bloc/bloc.dart';

part 'navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, int> {
  NavigationBloc() : super(0) {
    on<ChangePageView>((event, emit) => emit(event.newIndex));
  }
}
