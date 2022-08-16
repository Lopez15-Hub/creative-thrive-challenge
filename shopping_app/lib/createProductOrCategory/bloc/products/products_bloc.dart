import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/categories/categories.dart';
import 'package:shopping_app/createProductOrCategory/bloc/blocs.dart';
import 'package:shopping_app/createProductOrCategory/models/product_model.dart';
import 'package:shopping_app/favorites/bloc/favorites_bloc.dart';
import 'package:shopping_app/favorites/models/favorite_model.dart';
import 'package:shopping_app/favorites/repository/favorites_repository.dart';
import 'package:shopping_app/home/bloc/snackbar/snackbar_bloc.dart';
import 'package:shopping_app/shop/models/product_arragment_model.dart';
import '../../repository/repositories.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  SnackbarBloc snackbarBloc = SnackbarBloc();
  FavoritesBloc favoritesBloc =
      FavoritesBloc(favoritesRepository: FavoritesRepository());
  UploadImageBloc uploadImageBloc =
      UploadImageBloc(storageRepository: StorageRepository());
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
      } else {
        favoritesBloc.add(DeleteFavoriteEvent(productId: event.productId));
      }
      add(RetrieveProductsWithCategoryEvent(category: event.categories));
    });

    on<UpdateProductsCategoryEvent>((event, emit) {
      productRepository.updateProductCategory(
          event.productId, event.newCategory);
    });

    on<DeleteProductEvent>((event, emit) {
      productRepository.deleteProduct(event.productId);
      add(RetrieveProductsWithCategoryEvent(category: event.categories));
    });

    on<ListeningProductsFavoritesEvent>((event, emit) async {
      List<ProductArragmentModel> favoritesProducts =
          await productRepository.getProductsFavorites(event.categories);

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
      add(RetrieveProductsWithCategoryEvent(category: event.categories));
    });

    on<ProductFunctionHasErrorEvent>((event, emit) async {
      snackbarBloc.add(SnackbarErrorEvent(
          event.context, 'An ocurred error: ${event.error}'));
    });

    on<ProductSubmittedEvent>((event, emit) async {
      snackbarBloc.add(SnackbarSuccessEvent(event.context, 'Product created'));
    });
    on<ProductWasDeletedEvent>((event, emit) async {
      snackbarBloc.add(SnackbarSuccessEvent(event.context, 'Product was deleted'));
    });
    on<ProductWasAddedToFavoritesEvent>((event, emit) async {
      snackbarBloc.add(
          SnackbarSuccessEvent(event.context, 'Product added to favorites'));
    });
    on<ProductWasDeletedFromFavoritesEvent>((event, emit) async {
      snackbarBloc.add(SnackbarSuccessEvent(
          event.context, 'Product removed from favorites'));
    });

    on<RetrieveProductsWithCategoryEvent>((event, emit) async {
      List<ProductArragmentModel> productsList = [];
      List<CategoryModel> categories = event.category;

      for (int i = 0; i < categories.length; i++) {
        final response =
            await productRepository.getProductsWithCategory(categories[i]);
            productsList.addAll(response);
      }

      if (productsList.isEmpty) return emit(ProductsListIsEmpty());
      emit(ProductsArragmentRetrieved(retrievedProducts: productsList));
    });

    on<RetrieveProductsFavoritesWithCategoryEvent>((event, emit) async {
      List<ProductArragmentModel> productsList = [];
      List<CategoryModel> categories = event.category;

      for (int i = 0; i < categories.length; i++) {
        final response =
            await productRepository.getProductsFavorites(categories[i]);
        productsList.addAll(response);
      }

      if (productsList.isEmpty) return emit(ProductsListIsEmpty());
      emit(ProductsFavoriteRetrieved(retrievedProducts: productsList));
    });
  }

  final ProductsRepository productRepository;
}
