part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  final dynamic currentCategorySelected;
  const CategoriesState({this.currentCategorySelected});

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesRetrieved extends CategoriesState {
  final List<CategoryModel> retrievedCategories;
    final CategoryModel currentCategory;
  const CategoriesRetrieved(
      {required this.retrievedCategories,required this.currentCategory}):super(currentCategorySelected: currentCategory);

  @override
  List<Object> get props => [retrievedCategories, currentCategory];
}

class CategoriesFavoriteRetrieved extends CategoriesState {
  final List<CategoryModel> retrievedCategories;

  const CategoriesFavoriteRetrieved({required this.retrievedCategories});

  @override
  List<Object> get props => [retrievedCategories];
}

class CategoriesIsLoading extends CategoriesState {
  final bool isLoading;
  const CategoriesIsLoading({required this.isLoading});
  @override
  List<Object> get props => [];
}

class CategoriesListIsEmpty extends CategoriesState {}
class CategoryIsChanged extends CategoriesState {
  final CategoryModel category;
  const CategoryIsChanged({required this.category}): super (currentCategorySelected: category);
  @override
  List<Object> get props => [category];
}
class CategoriesRetrievedError extends CategoriesState {
  final Object error;
  const CategoriesRetrievedError({required this.error});
  @override
  List<Object> get props => [error];
}
class CategoryExists extends CategoriesState {
  final bool categoryExists;
  const CategoryExists({required this.categoryExists});
  @override
  List<Object> get props => [categoryExists];
}