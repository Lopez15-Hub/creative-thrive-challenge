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
      await emit.forEach(categoriesRepository.getCategoriesStream(),
          onData: (data) => CategoriesRetrieved(
              retrievedCategories: categoriesList,
              currentCategory: categoriesList.first),
          onError: (error, stackTrace) =>
              CategoriesRetrievedError(error: error.toString()));
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
      snackbarBloc.add(SnackbarSuccessEvent(event.context, 'Category Deleted Successfully'));
    });
    on<CategoriesFuctionWasErrorEvent>((event, emit) async {
      snackbarBloc.add(SnackbarErrorEvent(event.context, 'An ocurred error: ${event.error}'));
    });
    on<CheckIfCategoryExistsEvent>((event, emit) async {
      final List<CategoryModel> categoriesOnBd =await categoriesRepository.getCategory(event.categoryName);

      if (categoriesOnBd.isNotEmpty) {
       return add(CategoryAlreadyExistsEvent(context: event.context));
      } 
      if(categoriesOnBd.isEmpty){
        return add(CreateCategoryEvent( category: event.category, context: event.context));
      }
    });

    on<CategoryAlreadyExistsEvent>((event, emit) {
      emit(const CategoryExists(categoryExists: true));
      return snackbarBloc
          .add(SnackbarInfoEvent(event.context, 'Category already exists'));
    });

    on<UpdateCategoriesStatusEvent>((event, emit) {
      categoriesRepository
          .updateCategoryStatus(event.isOpen, event.categoryId)
          .then((value) {
                if (event.isOpen)return snackbarBloc.add(SnackbarSuccessEvent(event.context, 'Category is now open'));
                snackbarBloc.add(SnackbarInfoEvent(event.context, 'Category is now closed'));
              });
      add(const ListeningCategoriesEvent(isLoadedData: true));
    });
    on<CategoriesAreOnLoadingEvent>((event, emit) {
      emit(CategoriesIsLoading(isLoading: event.isLoading));
    });
    on<UpdateCategoriesPositionEvent>((event, emit) {
       emit(CategoriesRetrieved(currentCategory: event.categoriesList.first,retrievedCategories:event.categoriesList));
    });
  }
  final CategoriesRepository categoriesRepository;
}
