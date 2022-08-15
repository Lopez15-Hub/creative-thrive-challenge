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
class UpdateProductsCategoryEvent extends ProductsEvent {
  final String productId;
  final CategoryModel newCategory;
  const UpdateProductsCategoryEvent({required this.newCategory,this.productId=""});
  @override
  List<Object> get props => [newCategory,productId];
}
class UpdateProductsFavoriteEvent extends ProductsEvent {
  final String productId;
  final bool isFavorite;
  const UpdateProductsFavoriteEvent({required this.isFavorite,this.productId=""});
  @override
  List<Object> get props => [isFavorite,productId];
}

class DeleteProductEvent extends ProductsEvent {
    final String productId;
  const DeleteProductEvent({required this.productId});
  @override
  List<Object> get props => [productId];
}

class ListeningProductsEvent extends ProductsEvent {}
class ListeningProductsFavoritesEvent extends ProductsEvent {}

class NotifyProductsListIsEmpty extends ProductsEvent {}