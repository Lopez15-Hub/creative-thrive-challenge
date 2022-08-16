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
  const UpdateProductsCategoryEvent(
      {required this.newCategory, this.productId = ""});
  @override
  List<Object> get props => [newCategory, productId];
}

class UpdateProductsFavoriteEvent extends ProductsEvent {
  final String productId;
  final bool isFavorite;
  const UpdateProductsFavoriteEvent(
      {required this.isFavorite, this.productId = ""});
  @override
  List<Object> get props => [isFavorite, productId];
}

class DeleteProductEvent extends ProductsEvent {
  final String productId;
  const DeleteProductEvent({required this.productId});
  @override
  List<Object> get props => [productId];
}

class ListeningProductsEvent extends ProductsEvent {}
class ListeningProductsByCategoryEvent extends ProductsEvent {
  final CategoryModel category;
  const ListeningProductsByCategoryEvent({required this.category});
  @override
  List<Object> get props => [category];
}

class ListeningProductsFavoritesEvent extends ProductsEvent {}

class NotifyProductsListIsEmptyEvent extends ProductsEvent {}

class ProductSubmittedEvent extends ProductsEvent {
  final BuildContext context;

  const ProductSubmittedEvent(this.context);
  @override
  List<Object> get props => [context];
}

class ProductIsOnSubmitedEvent extends ProductsEvent {
  final bool isOnSubmit;
  const ProductIsOnSubmitedEvent({required this.isOnSubmit});
  @override
  List<Object> get props => [isOnSubmit];
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
class ProducWasSubmitEvent extends ProductsEvent {

}