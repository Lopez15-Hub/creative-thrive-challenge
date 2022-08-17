part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductsEvent {
  const GetProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProductEvent extends ProductsEvent {}

class CreateProductEvent extends ProductsEvent {
  final ProductModel product;
  final BuildContext context;
  const CreateProductEvent({required this.product, required this.context});
  @override
  List<Object> get props => [product];
}

class UpdateProductsEvent extends ProductsEvent {
  final String productId;
  final ProductModel product;
  const UpdateProductsEvent({required this.product, this.productId = ""});
  @override
  List<Object> get props => [product, productId];
}

class UpdateProductsCategoryEvent extends ProductsEvent {
  final String productId;
  final CategoryModel newCategory;
  final BuildContext context;
  final List<CategoryModel> categories;
  const UpdateProductsCategoryEvent(
      {required this.newCategory,
      required this.context,
      this.productId = "",
      required this.categories});
  @override
  List<Object> get props => [newCategory, productId, context];
}

class UpdateProductsFavoriteEvent extends ProductsEvent {
  final String productId;
  final bool isFavorite;
  final List<CategoryModel> categories;
  const UpdateProductsFavoriteEvent({
    required this.isFavorite,
    required this.categories,
    this.productId = "",
  });
  @override
  List<Object> get props => [isFavorite, productId, categories];
}

class DeleteProductEvent extends ProductsEvent {
  final String productId;
  final BuildContext context;
  final List<CategoryModel> categories;
  const DeleteProductEvent(
      {required this.productId,
      required this.categories,
      required this.context});
  @override
  List<Object> get props => [productId, categories, context];
}

class ListeningProductsEvent extends ProductsEvent {
  final List<CategoryModel> categories;
  const ListeningProductsEvent({required this.categories});

  @override
  List<Object> get props => [categories];
}

class ListeningProductsByCategoryEvent extends ProductsEvent {
  final CategoryModel category;
  const ListeningProductsByCategoryEvent({required this.category});
  @override
  List<Object> get props => [category];
}

class ListeningProductsFavoritesEvent extends ProductsEvent {
  final CategoryModel categories;
  const ListeningProductsFavoritesEvent({required this.categories});
  @override
  List<Object> get props => [categories];
}

class NotifyProductsListIsEmptyEvent extends ProductsEvent {}

class ProductSubmittedEvent extends ProductsEvent {
  final BuildContext context;

  const ProductSubmittedEvent(this.context);
  @override
  List<Object> get props => [context];
}

class ProductIsOnSubmitedEvent extends ProductsEvent {
  final bool isOnSubmit;
  final List<CategoryModel> categories;
  const ProductIsOnSubmitedEvent(
      {required this.isOnSubmit, required this.categories});
  @override
  List<Object> get props => [isOnSubmit, categories];
}

class ProductWasDeletedEvent extends ProductsEvent {
  final BuildContext context;
  const ProductWasDeletedEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class ProductWasAddedToFavoritesEvent extends ProductsEvent {
  final BuildContext context;
  const ProductWasAddedToFavoritesEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class ProductWasDeletedFromFavoritesEvent extends ProductsEvent {
  final BuildContext context;
  const ProductWasDeletedFromFavoritesEvent({required this.context});
  @override
  List<Object> get props => [context];
}

class ProductFunctionHasErrorEvent extends ProductsEvent {
  final String error;
  final BuildContext context;
  const ProductFunctionHasErrorEvent(
      {required this.error, required this.context});
  @override
  List<Object> get props => [error, context];
}

class ProductOnSubmitedEvent extends ProductsEvent {
  final BuildContext context;
  final String productName, productPrice, productImage;
  final CategoryModel productCategory;
  final bool isFavorite;
  const ProductOnSubmitedEvent(
      {required this.context,
      required this.productName,
      required this.productPrice,
      required this.productCategory,
      required this.productImage,
      required this.isFavorite});
  @override
  List<Object> get props => [
        context,
        productName,
        productPrice,
        productCategory,
        productImage,
        isFavorite
      ];
}

class GetProductImageEvent extends ProductsEvent {
  final String productImageUrl;
  const GetProductImageEvent({required this.productImageUrl});
  @override
  List<Object> get props => [productImageUrl];
}

class ProducWasSubmitEvent extends ProductsEvent {}

class RetrieveProductsWithCategoryEvent extends ProductsEvent {
  final List<CategoryModel> category;
  const RetrieveProductsWithCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}

class RetrieveProductsFavoritesWithCategoryEvent extends ProductsEvent {
  final List<CategoryModel> category;
  const RetrieveProductsFavoritesWithCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}

class UpdateProductsPositionEvent extends ProductsEvent {
  final List<ProductArragmentModel> productsList;
  const UpdateProductsPositionEvent({required this.productsList});
  @override
  List<Object> get props => [productsList];
}

class UpdateProductsFavoritesPositionEvent extends ProductsEvent {
  final List<ProductArragmentModel> productsList;
  const UpdateProductsFavoritesPositionEvent({required this.productsList});
  @override
  List<Object> get props => [productsList];
}

class DeleteProductsWhenCategoryWasDeletedEvent extends ProductsEvent {
  final CategoryModel category;
  final BuildContext context;
  const DeleteProductsWhenCategoryWasDeletedEvent(
      {required this.category, required this.context});
  @override
  List<Object> get props => [category];
}

class CheckIfProductExistsEvent extends ProductsEvent {
  final String productName;
  final ProductModel product;
  final BuildContext context;
  const CheckIfProductExistsEvent(
      {
        required this.productName,
        required this.context,
        required this.product

      });
  @override
  List<Object> get props => [productName, context, product];
}
class ProductAlreadyExistsEvent extends ProductsEvent {
  final BuildContext context;
  const ProductAlreadyExistsEvent({required this.context});
  @override
  List<Object> get props => [context];
}