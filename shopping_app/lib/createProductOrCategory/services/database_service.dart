import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/favorites/models/favorite_model.dart';

import '../../categories/models/category_model.dart';
import '../../shop/models/product_arragment_model.dart';
import '../models/product_model.dart';

class DatabaseService {
  final productsCollection = FirebaseFirestore.instance.collection("products");
  final categoriesCollection =
      FirebaseFirestore.instance.collection("categories");
  final favoritesCollection =
      FirebaseFirestore.instance.collection("favorites");

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
  Stream<List<ProductArragmentModel>> retrieveProductsWithCategoryStream(CategoryModel productCategory) =>
      productsCollection.where("category", isEqualTo: productCategory.toJson()).snapshots()
          .map((snapshot) => snapshot.docs
              .map((product) => ProductArragmentModel.fromSnapshot(product))
              .toList());


  Future<List<ProductArragmentModel>> retrieveProductsWithCategory({required CategoryModel productCategory} ) async {
    List<ProductArragmentModel> productArragmentModelList = [];
    List<ProductModel> productsList = [];
    productsCollection.snapshots().map(
        (event) => event.docs.map((product) => productsList
            .add(ProductModel.fromJson(product.data(), product.id))));
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

  Future<List<ProductArragmentModel>> retrieveProductsFavorites({required CategoryModel productCategory} ) async {
    List<ProductArragmentModel> productArragmentModelList = [];
    List<ProductModel> productsList = [];
    await productsCollection.where("category.categoryName", isEqualTo: productCategory.categoryName).where("isFavorite",isEqualTo: true)
        .get()
        .then((value) {
      productsList.addAll(value.docs
          .map((product) => ProductModel.fromJson(product.data(), product.id)));
    });

    productArragmentModelList.add(ProductArragmentModel(
        category: productCategory, products: productsList));
    return productArragmentModelList;
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

//? Categories Database operations
  Stream<List<CategoryModel>> retrieveCategoriesStream() => categoriesCollection
      .orderBy('pos', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((category) => CategoryModel.fromSnapshot(category))
          .toList());

  Future<List<CategoryModel>> retrieveCategories() {
    return categoriesCollection.get().then((snapshot) => snapshot.docs
        .map((category) => CategoryModel.fromSnapshot(category))
        .toList());
  }

  Future<List<CategoryModel>> retrieveCategory(String categoryName) {
    return categoriesCollection
        .where("categoryName", isEqualTo: categoryName)
        .get()
        .then((snapshot) => snapshot.docs
            .map((category) => CategoryModel.fromSnapshot(category))
            .toList());
  }

  Future<void> createCategory(CategoryModel category) async =>
      await categoriesCollection.add(category.toJson());
  Future<void> deleteCategory(String categoryId) async =>
      await categoriesCollection.doc(categoryId).delete();
  Future<void> updateCategory(
          String categoryId, CategoryModel newCategoryData) async =>
      await categoriesCollection
          .doc(categoryId)
          .update(newCategoryData.toJson());
  Future<void> updateCategoryStatus(bool isOpen, String categoryId) async =>
      await categoriesCollection.doc(categoryId).update({'isOpen': isOpen});

  Future<List<FavoriteModel>> retrieveFavoriteDateAdd(productId) {
    return favoritesCollection
        .where("productId", isEqualTo: productId)
        .get()
        .then((snapshot) => snapshot.docs
            .map((favorite) => FavoriteModel.fromSnapshot(favorite))
            .toList());
  }

  Future<void> createFavorite(FavoriteModel favorite) async =>
      await favoritesCollection.doc(favorite.productId).set(favorite.toJson());
  Future<void> deleteFavorite(String productId) async =>
      await favoritesCollection.doc(productId).delete();
}
