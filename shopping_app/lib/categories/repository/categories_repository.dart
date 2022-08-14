import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';

class CategoriesRepository {
  final categoriesCollection =
      FirebaseFirestore.instance.collection("categories");

  Stream<List<CategoryModel>> getCategories() {
    return categoriesCollection.snapshots().map((snapshot) => snapshot.docs
        .map((category) => CategoryModel.fromSnapshot(category))
        .toList());
  }

  Future<void> createCategory(CategoryModel category) async =>
      await categoriesCollection.add(category.toJson());
  Future<void> deleteCategory(String categoryId) async =>
      await categoriesCollection.doc(categoryId).delete();
  Future<void> updateCategory(
          String categoryId, CategoryModel newCategoryData) async =>
      await categoriesCollection.doc(categoryId).update(newCategoryData.toJson());
}
