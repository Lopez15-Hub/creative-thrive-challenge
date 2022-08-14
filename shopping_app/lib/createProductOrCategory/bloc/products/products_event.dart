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

  const CreateProductEvent({required this.product});
  @override
  List<Object> get props => [product];

}

class UpdateProductsEvent extends ProductsEvent {
  final String productId;
  final ProductModel product;
  const UpdateProductsEvent({required this.product,this.productId=""});
  @override
  List<Object> get props => [product,productId];
}
class UpdateProductsFavoriteEvent extends ProductsEvent {
  final String productId;
  final bool isFavorite;
  const UpdateProductsFavoriteEvent({required this.isFavorite,this.productId=""});
  @override
  List<Object> get props => [isFavorite,productId];
}

class DeleteProductsEvent extends ProductsEvent {}

class ListeningProductsEvent extends ProductsEvent {}
class ListeningProductsFavoritesEvent extends ProductsEvent {}

class NotifyProductsListIsEmpty extends ProductsEvent {}