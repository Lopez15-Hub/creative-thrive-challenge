import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/categories/categories.dart';
import 'package:shopping_app/createProductOrCategory/models/product_model.dart';
import 'package:shopping_app/favorites/bloc/favorites_bloc.dart';
import 'package:shopping_app/favorites/models/favorite_model.dart';
import 'package:shopping_app/favorites/repository/favorites_repository.dart';
import 'package:shopping_app/home/bloc/snackbar/snackbar_bloc.dart';
import '../../repository/products_repository.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  SnackbarBloc snackbarBloc = SnackbarBloc();
  FavoritesBloc favoritesBloc =
      FavoritesBloc(favoritesRepository: FavoritesRepository());
  ProductsBloc({required this.productRepository}) : super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) {
      productRepository.getProducts();
    });
    on<CreateProductEvent>((event, emit) {
      productRepository
          .createProduct(event.product)
          .then((value) => add(ProductSubmittedEvent(event.context)))
          .catchError((error) => add(ProductFunctionHasErrorEvent(
              context: event.context, error: error.toString())));
    });
    on<UpdateProductsEvent>((event, emit) {
      productRepository.updateProduct(event.productId, event.product);
    });
    on<UpdateProductsFavoriteEvent>((event, emit) {
      productRepository.updateProductIsFavorite(
          event.productId, event.isFavorite);
      if (event.isFavorite) {
        favoritesBloc.add(CreateFavoriteEvent(
            favorite: FavoriteModel(
                productId: event.productId, dateAdded: DateTime.now())));
      }else{
        favoritesBloc.add(DeleteFavoriteEvent(productId: event.productId));
      }
    });
    on<UpdateProductsCategoryEvent>((event, emit) {
      productRepository.updateProductCategory(
          event.productId, event.newCategory);
    });
    on<DeleteProductEvent>((event, emit) {
      productRepository.deleteProduct(event.productId);
      add(ListeningProductsEvent());
    });

    on<ListeningProductsEvent>((event, emit) async {
      List<ProductModel> productsList = await productRepository.getProducts();
      if (productsList.isEmpty) return emit(ProductsListIsEmpty());
      await emit.forEach<List<ProductModel>>(
        productRepository.getProductsStream(),
        onData: (productsList) =>
            ProductsRetrieved(retrievedProducts: productsList),
        onError: (error, stackTrace) => ProductsRetrievedError(error: error),
      );
      emit(ProductsRetrieved(retrievedProducts: productsList));
    });

    on<ListeningProductsFavoritesEvent>((event, emit) async {
      List<ProductModel> favoritesProducts =
          await productRepository.getProductsFavorites();

      if (favoritesProducts.isEmpty) return emit(ProductsListIsEmpty());

      emit(ProductsFavoriteRetrieved(retrievedProducts: favoritesProducts));
    });
    on<NotifyProductsListIsEmptyEvent>((event, emit) async {
      emit(ProductsListIsEmpty());
    });
    on<ProductOnSubmitedEvent>((event, emit) async {
      final productModel = ProductModel(
          category: event.productCategory,
          isFavorite: event.isFavorite,
          productImage: event.productImage,
          productName: event.productName,
          productPrice: event.productPrice);

      add(CreateProductEvent(context: event.context, product: productModel));
    });
    on<ProductIsOnSubmitedEvent>((event, emit) async {
      emit(ProductsIsOnSubmit(isOnSubmit: event.isOnSubmit));
    });

    on<ProductFunctionHasErrorEvent>((event, emit) async {
      snackbarBloc.add(SnackbarErrorEvent(
          event.context, 'An ocurred error: ${event.error}'));
    });

    on<ProductSubmittedEvent>((event, emit) async {
      snackbarBloc.add(SnackbarSuccessEvent(event.context, 'Product created'));
    });
    on<ProductWasDeletedEvent>((event, emit) async {
      snackbarBloc
          .add(SnackbarSuccessEvent(event.context, 'Product was deleted'));
    });
    on<ProductWasAddedToFavoritesEvent>((event, emit) async {
      snackbarBloc.add(
          SnackbarSuccessEvent(event.context, 'Product added to favorites'));
    });
    on<ProductWasDeletedFromFavoritesEvent>((event, emit) async {
      snackbarBloc.add(SnackbarSuccessEvent(
          event.context, 'Product removed from favorites'));
    });
  }

  final ProductsRepository productRepository;
}
