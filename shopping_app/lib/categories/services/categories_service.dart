import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';

class CategoriesService {
  final categoriesCollection =
      FirebaseFirestore.instance.collection("categories");

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




}
