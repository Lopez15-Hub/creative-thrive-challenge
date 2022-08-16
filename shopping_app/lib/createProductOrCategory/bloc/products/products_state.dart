part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsRetrieved extends ProductsState {
  final List<ProductModel> retrievedProducts;
  const ProductsRetrieved({required this.retrievedProducts});

  @override
  List<Object> get props => [retrievedProducts];
}

class ProductsFavoriteRetrieved extends ProductsState {
  final List<ProductArragmentModel> retrievedProducts;
  const ProductsFavoriteRetrieved({required this.retrievedProducts});

  @override
  List<Object> get props => [retrievedProducts];
}

class ProductsLoaded extends ProductsState {}

class ProductsListIsEmpty extends ProductsState {}

class ProductsRetrievedError extends ProductsState {
  final Object error;
  const ProductsRetrievedError({required this.error});
  @override
  List<Object> get props => [error];
}

class ProductsIsOnSubmit extends ProductsState {
  final bool isOnSubmit;
  const ProductsIsOnSubmit({this.isOnSubmit = false});
  @override
  List<Object> get props => [isOnSubmit];
}
class ProductsArragmentRetrieved extends ProductsState {
  final List<ProductArragmentModel> retrievedProducts;
  const ProductsArragmentRetrieved({required this.retrievedProducts});

  @override
  List<Object> get props => [retrievedProducts];
}
