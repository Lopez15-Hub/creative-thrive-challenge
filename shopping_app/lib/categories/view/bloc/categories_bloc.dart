import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/categories/repository/categories_repository.dart';

import '../../models/category_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required this.categoriesRepository}) : super(CategoriesInitial()) {

    on<CategoriesEvent>((event, emit) {});

    on<CreateCategoryEvent>((event, emit) {
      categoriesRepository.createCategory(event.category);
    });

    on<ListeningCategoriesEvent>((event, emit) async {
      final categoriesList = await categoriesRepository.getCategories();
      if (categoriesList.isEmpty) emit(CategoriesListIsEmpty());
      emit(SelectedCategory(categoriesList.first));
      emit(CategoriesRetrieved(retrievedCategories: categoriesList));
    });

    on<SelectCategory>((event, emit) {


      emit(CategoriesRetrieved(retrievedCategories: event.currentCategories));
    });
  }
  final CategoriesRepository categoriesRepository;
}
