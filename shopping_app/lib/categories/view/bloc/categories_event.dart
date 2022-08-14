part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesEvent extends CategoriesEvent {
  const GetCategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryEvent extends CategoriesEvent {}

class CreateCategoryEvent extends CategoriesEvent {
  final CategoryModel category;

  const CreateCategoryEvent({required this.category});
  @override
  List<Object> get props => [category];

}

class UpdateCategoriesEvent extends CategoriesEvent {
  final String categoryId;
  final CategoryModel category;
  const UpdateCategoriesEvent({required this.category,this.categoryId=""});
  @override
  List<Object> get props => [category,categoryId];
}
class UpdateCategoriesFavoriteEvent extends CategoriesEvent {
  final String categoryId;
  const UpdateCategoriesFavoriteEvent({this.categoryId=""});
  @override
  List<Object> get props => [categoryId];
}

class DeleteCategoriesEvent extends CategoriesEvent {}

class ListeningCategoriesEvent extends CategoriesEvent {
  const ListeningCategoriesEvent();
  @override
  List<Object> get props => [];
}
class ListeningCategoriesFavoritesEvent extends CategoriesEvent {}

class NotifyCategoriesListIsEmpty extends CategoriesEvent {}

class SelectCategory extends CategoriesEvent {
  final CategoryModel selectedCategory;
  final List<CategoryModel> currentCategories;

  const SelectCategory({required this.selectedCategory,required this.currentCategories});
  @override
  List<Object> get props => [selectedCategory,currentCategories];
}