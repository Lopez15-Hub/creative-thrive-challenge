import 'package:cloud_firestore/cloud_firestore.dart';

import '../../categories/models/category_model.dart';
import '../models/product_model.dart';

class DatabaseService {
  final productsCollection = FirebaseFirestore.instance.collection("products");
  final categoriesCollection =
      FirebaseFirestore.instance.collection("categories");
  Stream<List<ProductModel>> retrieveProductsStream() =>
      productsCollection.orderBy("category").snapshots().map((snapshot) => snapshot.docs
          .map((product) => ProductModel.fromSnapshot(product))
          .toList());
          
  Future<List<ProductModel>> retrieveProducts() {
    return productsCollection.get().then((snapshot) => snapshot.docs
        .map((product) => ProductModel.fromSnapshot(product))
        .toList());
  }



  Future<List<ProductModel>> retrieveProductsFavorites() {
    return productsCollection.where('isFavorite', isEqualTo: true).get().then(
        (snapshot) => snapshot.docs
            .map((product) => ProductModel.fromSnapshot(product))
            .toList());
  }

  Future<void> createProduct(ProductModel product) async =>
      await productsCollection.add(product.toJson());
  Future<void> deleteProduct(String productId) async =>
      await productsCollection.doc(productId).delete();
  Future<void> updateProduct(
          String productId, ProductModel newProductData) async =>
      await productsCollection.doc(productId).update(newProductData.toJson());
  Future<void> updateProductIsFavorite(
          String productId, bool isFavorite) async =>
      await productsCollection
          .doc(productId)
          .update({'isFavorite': isFavorite});
  Future<void> updateProductCategory(
          String productId, CategoryModel newCategory) async =>
      await productsCollection.doc(productId).update({'category': newCategory});



  Future<List<CategoryModel>> retrieveCategories() {
    return categoriesCollection.get().then((snapshot) => snapshot.docs
        .map((product) => CategoryModel.fromSnapshot(product))
        .toList());
  }
  Future<void> createCategory(CategoryModel category) async =>await categoriesCollection.add(category.toJson());
  Future<void> deleteCategory(String categoryId) async => await categoriesCollection.doc(categoryId).delete();
  Future<void> updateCategory( String categoryId, CategoryModel newCategoryData) async => await categoriesCollection.doc(categoryId).update(newCategoryData.toJson());
}
