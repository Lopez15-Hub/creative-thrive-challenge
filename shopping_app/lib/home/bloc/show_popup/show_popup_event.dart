part of 'show_popup_bloc.dart';

class ShowPopupEvent extends Equatable {
  final bool mustBeShowed;
  final BuildContext context;
  final String categoryId, productId;
  final List<CategoryModel> categories;
  final CategoryModel category;
  const ShowPopupEvent({
    required this.mustBeShowed,
    required this.context,
    required this.categories,
    required this.category,
    this.categoryId = '',
    this.productId = '',
  });

  @override
  List<Object?> get props =>
      [mustBeShowed, context, categoryId, productId, categories,category];
}
