part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductsEvent {}

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
  const UpdateProductsEvent({required this.productId, required this.product});
  @override
  List<Object> get props => [productId, product];
}

class DeleteProductsEvent extends ProductsEvent {}
