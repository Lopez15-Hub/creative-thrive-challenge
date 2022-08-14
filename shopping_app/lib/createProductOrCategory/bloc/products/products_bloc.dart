import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_app/createProductOrCategory/models/product_model.dart';
import '../../repository/products_repository.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required this.productRepository}) : super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) {
      productRepository.getProducts();
    });
    on<CreateProductEvent>((event, emit) {
      productRepository.createProduct(event.product);
    });
    on<UpdateProductsEvent>((event, emit) {
      productRepository.updateProduct(event.productId, event.product);
    });
    on<UpdateProductsFavoriteEvent>((event, emit) {
      productRepository.updateProductIsFavorite(
          event.productId, event.isFavorite);
    });

    on<ListeningProductsEvent>((event, emit) async {
      List<ProductModel> productsList = await productRepository.getProducts();
      if (productsList.isEmpty) emit(ProductsListIsEmpty());
      emit(ProductsRetrieved(retrievedProducts: productsList));
    });
    on<ListeningProductsFavoritesEvent>((event, emit) async {
      List<ProductModel> favoritesProducts =
          await productRepository.getProductsFavorites();

      if (favoritesProducts.isEmpty) emit(ProductsListIsEmpty());

      emit(ProductsFavoriteRetrieved(retrievedProducts: favoritesProducts));
    });
    on<NotifyProductsListIsEmpty>((event, emit) async {
      emit(ProductsListIsEmpty());
    });
  }

  final ProductsRepository productRepository;
}
