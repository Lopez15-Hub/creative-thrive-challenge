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

class DeleteCategoryEvent extends CategoriesEvent {
  final String categoryId;
  const DeleteCategoryEvent({required this.categoryId});
  @override
  List<Object> get props => [categoryId];
}

class ListeningCategoriesEvent extends CategoriesEvent {
  const ListeningCategoriesEvent();
  @override
  List<Object> get props => [];
}
class ListeningCategoriesFavoritesEvent extends CategoriesEvent {}

class NotifyCategoriesListIsEmpty extends CategoriesEvent {}

class ChangeDropdownCategoryEvent  extends CategoriesEvent {
  final CategoryModel categorySelected;
  final List<CategoryModel> retrievedCategories;
  const ChangeDropdownCategoryEvent({required this.categorySelected,required this.retrievedCategories});
  @override
  List<Object> get props => [categorySelected,retrievedCategories];
}

class CategoryWasDeletedEvent extends CategoriesEvent {
  final BuildContext context;
  const CategoryWasDeletedEvent({required this.context});
  @override
  List<Object> get props => [context];
}