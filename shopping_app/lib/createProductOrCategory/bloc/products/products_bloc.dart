import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/categories/categories.dart';
import 'package:shopping_app/createProductOrCategory/bloc/blocs.dart';
import 'package:shopping_app/createProductOrCategory/models/product_model.dart';
import 'package:shopping_app/favorites/bloc/favorites_bloc.dart';
import 'package:shopping_app/favorites/models/favorite_model.dart';
import 'package:shopping_app/favorites/repository/favorites_repository.dart';
import 'package:shopping_app/home/bloc/blocs.dart';
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

    on<DeleteProductEvent>((event, emit) {
      productRepository
          .deleteProduct(event.productId)
          .then((value) => add(ProductWasDeletedEvent(context: event.context)))
          .onError((error, stackTrace) => ProductFunctionHasErrorEvent(
              error: error.toString(), context: event.context));
      add(RetrieveProductsWithCategoryEvent(category: event.categories));
    });
    on<DeleteProductsWhenCategoryWasDeletedEvent>((event, emit) async {
      await productRepository
          .deleteProductsWhenCategoryWasDeleted(event.category)
          .then((value) => snackbarBloc.add(SnackbarSuccessEvent(
              event.context, 'Products deleted successfully')))
          .onError((error, stackTrace) => snackbarBloc.add(SnackbarErrorEvent(
              event.context,
              'Delete category products fails, error: ${error.toString()}')));
    });

    on<ProductSubmittedEvent>((event, emit) async {
      snackbarBloc.add(SnackbarSuccessEvent(event.context, 'Product created'));
    });
    on<ProductIsOnSubmitedEvent>((event, emit) async {
      emit(ProductsIsOnSubmit(isOnSubmit: event.isOnSubmit));
      add(RetrieveProductsWithCategoryEvent(category: event.categories));
    });
    on<ProductOnSubmitedEvent>((event, emit) async {
      final productModel = ProductModel(
          category: event.productCategory,
          isFavorite: event.isFavorite,
          productImage: event.productImage,
          productName: event.productName,
          productPrice: event.productPrice);
      add(CheckIfProductExistsEvent(
          context: event.context,
          product: productModel,
          productName: event.productName));
    });


    on<ProductWasDeletedEvent>((event, emit) async {
      Navigator.of(event.context).pop();
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

    on<ProductFunctionHasErrorEvent>((event, emit) async {
      snackbarBloc.add(SnackbarErrorEvent(
          event.context, 'An ocurred error: ${event.error}'));
    });
    on<ProductAlreadyExistsEvent>((event, emit) async {
      snackbarBloc.add(SnackbarInfoEvent(event.context, 'Product already exists'));
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

    on<CheckIfProductExistsEvent>((event, emit) async {
      final productsOnBd =
          await productRepository.getProduct(event.productName);
      if (productsOnBd.isNotEmpty) {
        return add(ProductAlreadyExistsEvent(context: event.context));
      }
      if (productsOnBd.isEmpty) {
        return add(
            CreateProductEvent(product: event.product, context: event.context));
      }
    });

    on<SearchProductEvent>((event, emit) async {
      await emit.onEach<List<ProductModel>>(
          productRepository.searchProductStream(event.searchTerm),
          onData: (data) => ProductsRetrieved(retrievedProducts: data));
    });
  }

  final ProductsRepository productRepository;
}
