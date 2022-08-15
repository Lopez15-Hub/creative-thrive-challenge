import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/categories/repository/categories_repository.dart';
import 'package:shopping_app/categories/models/category_model.dart';
import 'package:shopping_app/home/bloc/blocs.dart';
part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final SnackbarBloc snackbarBloc = SnackbarBloc();
  CategoriesBloc({required this.categoriesRepository})
      : super(CategoriesInitial()) {
    on<CategoriesEvent>((event, emit) {});

    on<CreateCategoryEvent>((event, emit) {
      categoriesRepository.createCategory(event.category);
    });

    on<ListeningCategoriesEvent>((event, emit) async {
      final categoriesList = await categoriesRepository.getCategories();
      if (categoriesList.isEmpty) return emit(CategoriesListIsEmpty());
      emit(CategoriesRetrieved(retrievedCategories: categoriesList));
    });
    on<ChangeDropdownCategoryEvent>((event, emit) async {
      final categoriesList = await categoriesRepository.getCategories();
      if (categoriesList.isEmpty) return emit(CategoriesListIsEmpty());
      emit(CategoriesRetrieved(
          retrievedCategories: categoriesList,));
      emit(CategoryIsChanged(category: event.categorySelected));
    });
    on<DeleteCategoryEvent>((event, emit) async {
      await categoriesRepository.deleteCategory(event.categoryId);
    });
    on<CategoryWasDeletedEvent>((event, emit) async {
      snackbarBloc.add(SnackbarSuccessEvent(event.context, 'Category Deleted Successfully'));
    });
  }
  final CategoriesRepository categoriesRepository;
}
