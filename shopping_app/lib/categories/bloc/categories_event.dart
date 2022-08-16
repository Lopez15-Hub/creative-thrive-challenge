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

class UpdateCategoriesStatusEvent extends CategoriesEvent {
  final bool isOpen;
  final String categoryId;
  final BuildContext context;
  const UpdateCategoriesStatusEvent(
      {required this.isOpen, required this.categoryId, required this.context});
  @override
  List<Object> get props => [isOpen, categoryId, context];
}

class DeleteCategoryEvent extends CategoriesEvent {
  final String categoryId;
  final BuildContext context;
  const DeleteCategoryEvent({required this.categoryId, required this.context});
  @override
  List<Object> get props => [categoryId, context];
}

class ListeningCategoriesEvent extends CategoriesEvent {
  final bool isLoadedData;
  const ListeningCategoriesEvent({this.isLoadedData = false});
  @override
  List<Object> get props => [isLoadedData];
}

class ListeningCategoriesFavoritesEvent extends CategoriesEvent {}

class CategorySubmittedEvent extends CategoriesEvent {
  final BuildContext context;
  const CategorySubmittedEvent({required this.context});
  @override
  List<Object> get props => [context];
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
  final CategoryModel category;
  final BuildContext context;
  const CheckIfCategoryExistsEvent(
      {required this.categoryName, required this.context,required this.category});
  @override
  List<Object> get props => [categoryName, context,category];
}

class CategoryAlreadyExistsEvent extends CategoriesEvent {
  final BuildContext context;
  const CategoryAlreadyExistsEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class CategoriesAreOnLoadingEvent extends CategoriesEvent {
  final bool isLoading;
  const CategoriesAreOnLoadingEvent({required this.isLoading});
  @override
  List<Object> get props => [isLoading];
}
