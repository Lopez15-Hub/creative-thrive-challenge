
import 'package:shopping_app/createProductOrCategory/services/services.dart';
import 'package:shopping_app/shop/models/product_arragment_model.dart';

import '../../categories/models/category_model.dart';
import '../models/product_model.dart';

class ProductsRepository {
  final _databaseService = DatabaseService();
  Stream<List<ProductModel>>          getProductsStream() =>_databaseService.retrieveProductsStream();
  Stream<List<ProductModel>>          getProductsByCategoryStream(CategoryModel productCategory) =>_databaseService.retrieveProductsByCategoryStream(productCategory);
  Stream<List<ProductArragmentModel>> getProductsWithCategoryStream(CategoryModel productCategory) =>_databaseService.retrieveProductsWithCategoryStream(productCategory);

  Future<List<ProductModel>>          getProducts() async =>await _databaseService.retrieveProducts();
  Future<List<ProductModel>>          getProductsByCategory(CategoryModel productCategory)   async => await _databaseService.retrieveProductsByCategory(productCategory);
  Future<List<ProductArragmentModel>> getProductsWithCategory(CategoryModel productCategory) async => await _databaseService.retrieveProductsWithCategory(productCategory: productCategory);
  Future<List<ProductArragmentModel>> getProductsFavorites(CategoryModel productCategory)    async => await  _databaseService.retrieveProductsFavorites(productCategory:productCategory);

  Future<void> createProduct(ProductModel product) async=>await _databaseService.createProduct(product);

  Future<void> deleteProduct(String productId) async => await _databaseService.deleteProduct(productId);
  Future<void> deleteProductsWhenCategoryWasDeleted(CategoryModel productCategory) async => await _databaseService.deleteProductsWhenCategoryWasDeleted(productCategory);

  Future<void> updateProduct( String productId, ProductModel newProductData) async => await _databaseService.updateProduct(productId, newProductData);

  Future<void> updateProductIsFavorite( String productId, bool isFavorite) async =>await _databaseService.updateProductIsFavorite(productId, isFavorite);

  Future<void> updateProductCategory( String productId, CategoryModel newCategory) async =>await _databaseService.updateProductCategory(productId, newCategory);
}
