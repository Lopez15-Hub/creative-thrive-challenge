import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/categories/repository/categories_repository.dart';

import '../../models/category_model.dart';


part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required this.categoriesRepository}) : super(CategoriesInitial()) {
    on<CategoriesEvent>((event, emit) {});
  }
  final CategoriesRepository categoriesRepository;
}
