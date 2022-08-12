import 'package:bloc/bloc.dart';

part 'bottombar_navigation_event.dart';

class BottombarNavigationBloc extends Bloc<BottombarNavigationEvent, int> {
  BottombarNavigationBloc() : super(0) {
    on<ChangePageView>((event, emit) {
      emit(event.newIndex);
    });
  }
}
