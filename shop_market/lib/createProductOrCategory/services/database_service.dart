import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class DatabaseService {

  final productsCollection = FirebaseFirestore.instance.collection("products");
  final categoriesCollection = FirebaseFirestore.instance.collection("categories");
  
  Future<List<ProductModel>> retrieveProducts() {
    return productsCollection.get().then((snapshot) => snapshot.docs
        .map((product) => ProductModel.fromSnapshot(product))
        .toList());
  }
  Future<List<ProductModel>> retrieveProductsFavorites() {
    return productsCollection.where('isFavorite',isEqualTo:true ).get().then((snapshot) => snapshot.docs
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
      await productsCollection.doc(productId).update({
        'isFavorite': isFavorite
      });
}
