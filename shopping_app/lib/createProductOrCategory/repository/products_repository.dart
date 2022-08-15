import 'package:shopping_app/createProductOrCategory/services/services.dart';

import '../../categories/models/category_model.dart';
import '../models/product_model.dart';

class ProductsRepository {
  final _databaseService = DatabaseService();
  Stream<List<ProductModel>> getProductsStream() =>
      _databaseService.retrieveProductsStream();
  Future<List<ProductModel>> getProducts() async =>
      await _databaseService.retrieveProducts();
  Future<List<ProductModel>> getProductsFavorites() async =>
      await _databaseService.retrieveProductsFavorites();

  Future<void> createProduct(ProductModel product) async {
      return await _databaseService.createProduct(product);
      
      }
      
  Future<void> deleteProduct(String productId) async =>
      await _databaseService.deleteProduct(productId);
  Future<void> updateProduct(
          String productId, ProductModel newProductData) async =>
      await _databaseService.updateProduct(productId, newProductData);
  Future<void> updateProductIsFavorite(
          String productId, bool isFavorite) async =>
      await _databaseService.updateProductIsFavorite(productId, isFavorite);
  Future<void> updateProductCategory(
          String productId, CategoryModel newCategory) async =>
      await _databaseService.updateProductCategory(productId, newCategory);
}
