import 'package:bloc/bloc.dart';
import 'package:shopping_app/categories/categories.dart';
part 'dropdown_button_event.dart';


class DropdownButtonBloc extends Bloc<DropdownButtonEvent, CategoryModel> {
  DropdownButtonBloc() : super(CategoryModel(categoryName: 'Shoes', categoryColor:'0xff5b10e2')) {
    on<SelectCategory> ((event, emit) {
      emit(event.selectedCategory);
    });
  }
}
