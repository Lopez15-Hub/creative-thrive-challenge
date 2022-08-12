
import 'package:shop_market/createProductOrCategory/services/database_service.dart';

import '../../models/product_model.dart';

class ProductsRepository {
  final databaseService = DatabaseService();


  Future<List<ProductModel>> getProducts() async=> await databaseService.retrieveProducts();
  Future<void> createProduct(ProductModel product) async => await databaseService.createProduct(product);
  Future<void> deleteProduct(String productId) async => await databaseService.deleteProduct(productId);
  Future<void> updateProduct(String productId, ProductModel newProductData) async => await databaseService.updateProduct(productId, newProductData);
}
