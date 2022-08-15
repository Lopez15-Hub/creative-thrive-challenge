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
  final BuildContext context;
  const CreateCategoryEvent({required this.category, required this.context});
  @override
  List<Object> get props => [category, context];
}

class UpdateCategoriesEvent extends CategoriesEvent {
  final String categoryId;
  final CategoryModel category;
  const UpdateCategoriesEvent({required this.category, this.categoryId = ""});
  @override
  List<Object> get props => [category, categoryId];
}

class UpdateCategoriesFavoriteEvent extends CategoriesEvent {
  final String categoryId;
  const UpdateCategoriesFavoriteEvent({this.categoryId = ""});
  @override
  List<Object> get props => [categoryId];
}

class DeleteCategoryEvent extends CategoriesEvent {
  final String categoryId;
  final BuildContext context;
  const DeleteCategoryEvent({required this.categoryId, required this.context});
  @override
  List<Object> get props => [categoryId, context];
}

class ListeningCategoriesEvent extends CategoriesEvent {
  const ListeningCategoriesEvent();
  @override
  List<Object> get props => [];
}

class ListeningCategoriesFavoritesEvent extends CategoriesEvent {}

class CategorySubmittedEvent extends CategoriesEvent {
  final BuildContext context;
  const CategorySubmittedEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class ChangeDropdownCategoryEvent extends CategoriesEvent {
  final CategoryModel categorySelected;
  final List<CategoryModel> retrievedCategories;
  const ChangeDropdownCategoryEvent(
      {required this.categorySelected, required this.retrievedCategories});
  @override
  List<Object> get props => [categorySelected, retrievedCategories];
}

class CategoryWasDeletedEvent extends CategoriesEvent {
  final BuildContext context;
  const CategoryWasDeletedEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class CategoriesFuctionWasErrorEvent extends CategoriesEvent {
  final BuildContext context;
  final String error;
  const CategoriesFuctionWasErrorEvent(
      {required this.context, required this.error});
  @override
  List<Object> get props => [context, error];
}

class CheckIfCategoryExistsEvent extends CategoriesEvent {
  final String categoryName;
  final BuildContext context;
  const CheckIfCategoryExistsEvent(
      {required this.categoryName, required this.context});
  @override
  List<Object> get props => [categoryName, context];
}
class CategoryAlreadyExistsEvent extends CategoriesEvent {
    final BuildContext context;
    const CategoryAlreadyExistsEvent({required this.context});
    @override
    List<Object> get props => [context];
}