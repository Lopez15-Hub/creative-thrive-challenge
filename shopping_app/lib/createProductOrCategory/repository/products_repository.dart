import 'package:shopping_app/createProductOrCategory/services/database_service.dart';

import '../models/product_model.dart';

class ProductsRepository {
  final databaseService = DatabaseService();

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
}