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
      categoriesRepository
          .createCategory(event.category)
          .then((value) => add(CategorySubmittedEvent(context: event.context)))
          .catchError((error) => add(CategoriesFuctionWasErrorEvent(
              context: event.context, error: error.toString())));
    });

    on<ListeningCategoriesEvent>((event, emit) async {
      final categoriesList = await categoriesRepository.getCategories();
      if (categoriesList.isEmpty) return emit(CategoriesListIsEmpty());
      emit(CategoriesRetrieved(
          retrievedCategories: categoriesList,
          currentCategory: categoriesList.first));
    });
    on<CategorySubmittedEvent>((event, emit) async {
      snackbarBloc.add(
          SnackbarSuccessEvent(event.context, 'Category added successfully'));
    });
    on<DeleteCategoryEvent>((event, emit) {
      categoriesRepository
          .deleteCategory(event.categoryId)
          .then((value) => add(CategoryWasDeletedEvent(context: event.context)))
          .catchError((error) => add(CategoriesFuctionWasErrorEvent(
              context: event.context, error: error.toString())));

      Navigator.of(event.context).pop();
    });
    on<CategoryWasDeletedEvent>((event, emit) async {
      snackbarBloc.add(
          SnackbarSuccessEvent(event.context, 'Category Deleted Successfully'));
    });
    on<CategoriesFuctionWasErrorEvent>((event, emit) async {
      snackbarBloc.add(SnackbarErrorEvent(
          event.context, 'An ocurred error: ${event.error}'));
    });
  }
  final CategoriesRepository categoriesRepository;
}
