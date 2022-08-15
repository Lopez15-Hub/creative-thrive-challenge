import 'package:shopping_app/createProductOrCategory/services/database_service.dart';

import '../../categories/models/category_model.dart';
import '../models/product_model.dart';

class ProductsRepository {
  final databaseService = DatabaseService();
  Stream<List<ProductModel>> getProductsStream() =>
      databaseService.retrieveProductsStream();
  Future<List<ProductModel>> getProducts() async =>
      await databaseService.retrieveProducts();
  Future<List<ProductModel>> getProductsFavorites() async =>
      await databaseService.retrieveProductsFavorites();

  Future<void> createProduct(ProductModel product) async =>
      await databaseService.createProduct(product);
  Future<void> deleteProduct(String productId) async =>
      await databaseService.deleteProduct(productId);
  Future<void> updateProduct(
          String productId, ProductModel newProductData) async =>
      await databaseService.updateProduct(productId, newProductData);
  Future<void> updateProductIsFavorite(
          String productId, bool isFavorite) async =>
      await databaseService.updateProductIsFavorite(productId, isFavorite);
  Future<void> updateProductCategory(
          String productId, CategoryModel newCategory) async =>
      await databaseService.updateProductCategory(productId, newCategory);
}
