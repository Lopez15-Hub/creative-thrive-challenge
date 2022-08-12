import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'title_changer_event.dart';

class TitleChangerBloc extends Bloc<TitleChangerEvent, bool> {
  TitleChangerBloc() : super(false) {


    on<ChangeTitle>((event, emit) => emit(event.formIndex));
  }
}
