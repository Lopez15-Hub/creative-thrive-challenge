import 'package:shopping_app/createProductOrCategory/services/services.dart';
import 'package:shopping_app/shop/models/product_arragment_model.dart';

import '../../categories/models/category_model.dart';
import '../models/product_model.dart';

class ProductsRepository {
  final _productsService = ProductsService();
  Stream<List<ProductModel>> getProductsStream() =>_productsService.retrieveProductsStream();
  Stream<List<ProductModel>> getProductsByCategoryStream(
          CategoryModel productCategory) =>
      _productsService.retrieveProductsByCategoryStream(productCategory);
  Stream<List<ProductModel>> searchProductStream(String searchTerm) =>
      _productsService.searchProductsStream(searchTerm: searchTerm);

  Future<List<ProductModel>> getProducts() async =>
      await _productsService.retrieveProducts();
  Future<List<ProductModel>> getProduct(String productName) async =>
      await _productsService.retrieveProduct(productName: productName);
  Future<List<ProductModel>> getProductsByCategory(
          CategoryModel productCategory) async =>
      await _productsService.retrieveProductsByCategory(productCategory);
  Future<List<ProductArragmentModel>> getProductsWithCategory(
          CategoryModel productCategory) async =>
      await _productsService.retrieveProductsWithCategory(
          productCategory: productCategory);
  Future<List<ProductArragmentModel>> getProductsFavorites(
          CategoryModel productCategory) async =>
      await _productsService.retrieveProductsFavorites(
          productCategory: productCategory);
  Future<void> createProduct(ProductModel product) async =>
      await _productsService.createProduct(product);
  Future<void> deleteProduct(String productId) async =>
      await _productsService.deleteProduct(productId);
  Future<void> deleteProductsWhenCategoryWasDeleted(
          CategoryModel productCategory) async =>
      await _productsService
          .deleteProductsWhenCategoryWasDeleted(productCategory);
  Future<void> updateProduct(
          String productId, ProductModel newProductData) async =>
      await _productsService.updateProduct(productId, newProductData);
  Future<void> updateProductIsFavorite(
          String productId, bool isFavorite) async =>
      await _productsService.updateProductIsFavorite(productId, isFavorite);
  Future<void> updateProductCategory(
          String productId, CategoryModel newCategory) async =>
      await _productsService.updateProductCategory(productId, newCategory);
}
