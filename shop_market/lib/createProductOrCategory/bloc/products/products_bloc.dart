import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_market/createProductOrCategory/models/product_model.dart';
import '../../repository/products/products_repository.dart';
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

    on<ListeningProductsEvent>((event, emit) async{
      List<ProductModel> products = await productRepository.getProducts();
       emit(ProductsRetrieved(retrievedProducts: products));
    });
  }

  final ProductsRepository productRepository;
}
