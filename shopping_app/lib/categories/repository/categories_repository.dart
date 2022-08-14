import 'package:cloud_firestore/cloud_firestore.dart';

import '../../createProductOrCategory/services/database_service.dart';
import '../models/category_model.dart';

class CategoriesRepository {
    final databaseService = DatabaseService();
  final categoriesCollection =
      FirebaseFirestore.instance.collection("categories");

  Future<List<CategoryModel>> getCategories() => databaseService.retrieveCategories();

  Future<void> createCategory(CategoryModel category) async => await categoriesCollection.add(category.toJson());
  Future<void> deleteCategory(String categoryId) async => await categoriesCollection.doc(categoryId).delete();
  Future<void> updateCategory( String categoryId, CategoryModel newCategoryData) async =>await categoriesCollection.doc(categoryId).update(newCategoryData.toJson());
}
