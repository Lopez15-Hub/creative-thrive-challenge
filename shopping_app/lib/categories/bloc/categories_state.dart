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
  const CategoriesRetrieved(
      {required this.retrievedCategories});

  @override
  List<Object> get props => [retrievedCategories, ];
}

class CategoriesFavoriteRetrieved extends CategoriesState {
  final List<CategoryModel> retrievedCategories;
  const CategoriesFavoriteRetrieved({required this.retrievedCategories});

  @override
  List<Object> get props => [retrievedCategories];
}

class CategoriesLoaded extends CategoriesState {}

class CategoriesListIsEmpty extends CategoriesState {}
class CategoryIsChanged extends CategoriesState {
  final CategoryModel category;
  const CategoryIsChanged({required this.category}): super (currentCategorySelected: category);
  @override
  List<Object> get props => [category];
}