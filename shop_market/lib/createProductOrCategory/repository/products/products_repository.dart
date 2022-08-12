import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/product_model.dart';


class ProductRepository {
  final productsCollection = FirebaseFirestore.instance.collection("products");


  Future<CollectionReference<ProductModel>> getProducts() async {
    final products = productsCollection.withConverter<ProductModel>(
        fromFirestore: (snapshot, _) => ProductModel.fromFirestore(snapshot, _),
        toFirestore: (product, _) => product.toFirestore());
    return products;
  }

  Future<void> createProduct(ProductModel product) async => await productsCollection.add(product.toFirestore());
  Future<void> deleteProduct(String productId) async =>  await productsCollection.doc(productId).delete();


  Future<void> updateProduct(
      String productId, ProductModel newProductData) async {
    await productsCollection
        .doc(productId)
        .update(newProductData.toFirestore());
  }
}
