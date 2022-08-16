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
      CheckIfCategoryExistsEvent(
          categoryName: event.category.categoryName, context: event.context);
      categoriesRepository
          .createCategory(event.category)
          .then((value) => add(CategorySubmittedEvent(context: event.context)))
          .catchError((error) => add(CategoriesFuctionWasErrorEvent(
              context: event.context, error: error.toString())));
    });

    on<ListeningCategoriesEvent>((event, emit) async {
      final categoriesList = await categoriesRepository.getCategories();
      if (categoriesList.isEmpty) return emit(CategoriesListIsEmpty());
      await emit.forEach(
        categoriesRepository.getCategoriesStream(),
        onData: (data) => CategoriesRetrieved(
            retrievedCategories: categoriesList,
            currentCategory: categoriesList.first),
      );
    });
    on<CategorySubmittedEvent>((event, emit) async {
      snackbarBloc.add(
          SnackbarSuccessEvent(event.context, 'Category added successfully'));
    });
    on<DeleteCategoryEvent>((event, emit) {
      categoriesRepository
          .deleteCategory(event.categoryId)
          .then((value) => add(CategoryWasDeletedEvent(context: event.context)))

          
          .catchError((error) => add(CategoriesFuctionWasErrorEvent(context: event.context, error: error.toString())));
    });
    on<CategoryWasDeletedEvent>((event, emit) async {
      Navigator.of(event.context).pop();
      snackbarBloc.add(
          SnackbarSuccessEvent(event.context, 'Category Deleted Successfully'));
    });
    on<CategoriesFuctionWasErrorEvent>((event, emit) async {
      snackbarBloc.add(SnackbarErrorEvent(
          event.context, 'An ocurred error: ${event.error}'));
    });
    on<CheckIfCategoryExistsEvent>((event, emit) async {
      final categoryName =
          await categoriesRepository.getCategory(event.categoryName);
      if (categoryName.isNotEmpty)add(CategoryAlreadyExistsEvent(context: event.context));
    });
    on<CategoryAlreadyExistsEvent>((event, emit) {
      return snackbarBloc
          .add(SnackbarInfoEvent(event.context, 'Category already exists'));
    });
  }
  final CategoriesRepository categoriesRepository;
}
