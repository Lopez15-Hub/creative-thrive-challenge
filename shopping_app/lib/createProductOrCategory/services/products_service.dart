import 'package:cloud_firestore/cloud_firestore.dart';

import '../../categories/models/category_model.dart';
import '../../shop/models/product_arragment_model.dart';
import '../models/models.dart';

class ProductsService{
  
  final productsCollection = FirebaseFirestore.instance.collection("products");

//? Products Database operations
  Stream<List<ProductModel>> retrieveProductsStream() => productsCollection
      .orderBy("category")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((product) => ProductModel.fromSnapshot(product))
          .toList());

  Future<List<ProductModel>> retrieveProducts() {
    return productsCollection.get().then((snapshot) => snapshot.docs
        .map((product) => ProductModel.fromSnapshot(product))
        .toList());
  }

  Future<List<ProductModel>> retrieveProductsByCategory(
      CategoryModel productCategory) {
    return productsCollection
        .where("category", isEqualTo: productCategory.toJson())
        .get()
        .then((snapshot) => snapshot.docs
            .map((product) => ProductModel.fromSnapshot(product))
            .toList());
  }

  Stream<List<ProductModel>> retrieveProductsByCategoryStream(
          CategoryModel productCategory) =>
      productsCollection
          .where("category", isEqualTo: productCategory.toJson())
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((product) => ProductModel.fromSnapshot(product))
              .toList());

  Future<List<ProductArragmentModel>> retrieveProductsWithCategory(
      {required CategoryModel productCategory}) async {
    List<ProductArragmentModel> productArragmentModelList = [];
    List<ProductModel> productsList = [];
    productsCollection.snapshots().map((event) => event.docs.map((product) =>
        productsList.add(ProductModel.fromJson(product.data(), product.id))));
    await productsCollection
        .where("category.categoryName", isEqualTo: productCategory.categoryName)
        .get()
        .then((value) {
      productsList.addAll(value.docs
          .map((product) => ProductModel.fromJson(product.data(), product.id)));
    });

    productArragmentModelList.add(ProductArragmentModel(
        category: productCategory, products: productsList));
    return productArragmentModelList;
  }

  Future<List<ProductArragmentModel>> retrieveProductsFavorites(
      {required CategoryModel productCategory}) async {
    List<ProductArragmentModel> productArragmentModelList = [];
    List<ProductModel> productsList = [];
    await productsCollection
        .where("category.categoryName", isEqualTo: productCategory.categoryName)
        .where("isFavorite", isEqualTo: true)
        .get()
        .then((value) {
      productsList.addAll(value.docs
          .map((product) => ProductModel.fromJson(product.data(), product.id)));
    });

    productArragmentModelList.add(ProductArragmentModel(
        category: productCategory, products: productsList));
    return productArragmentModelList;
  }

  Future<List<ProductModel>> retrieveProduct({required String productName}) {
    return productsCollection
        .where("productName", isEqualTo: productName)
        .get()
        .then((snapshot) => snapshot.docs
            .map((product) => ProductModel.fromSnapshot(product))
            .toList());
  }

  Future<void> createProduct(ProductModel product) async =>
      await productsCollection.add(product.toJson());
  Future<void> deleteProduct(String productId) async =>
      await productsCollection.doc(productId).delete();
  Future<void> deleteProductsWhenCategoryWasDeleted(
      CategoryModel category) async {
    final products = await productsCollection
        .where("category.categoryName", isEqualTo: category.categoryName)
        .get()
        .then((snapshot) => snapshot.docs
            .map((product) => ProductModel.fromSnapshot(product))
            .toList());
    for (int i = 0; i < products.length; i++) {
      await productsCollection.doc(products[i].productId).delete();
    }
  }

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
      await productsCollection
          .doc(productId)
          .update({'category': newCategory.toJson()});

  //Search products
  Stream<List<ProductModel>> searchProductsStream( {required String searchTerm}) {

    return productsCollection.where("productName", isGreaterThanOrEqualTo: searchTerm).snapshots().map((snapshot) => snapshot.docs .map((product) => ProductModel.fromSnapshot(product)) .toList());
    

  }
}