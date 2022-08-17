import '../../createProductOrCategory/services/categories_service.dart';
import '../models/category_model.dart';

class CategoriesRepository {
  final _categoriesService = CategoriesService();

  Future<List<CategoryModel>> getCategories() =>
      _categoriesService.retrieveCategories();
  Stream<List<CategoryModel>> getCategoriesStream() =>
      _categoriesService.retrieveCategoriesStream();
  Future<List<CategoryModel>> getCategory(String categoryName) =>
      _categoriesService.retrieveCategory(categoryName);

  Future<void> createCategory(CategoryModel category) async =>
      await _categoriesService.createCategory(category);
  Future<void> deleteCategory(String categoryId) async =>
      await _categoriesService.deleteCategory(categoryId);
  Future<void> updateCategory(
          String categoryId, CategoryModel newCategoryData) async =>
      await _categoriesService.updateCategory(categoryId, newCategoryData);
  Future<void> updateCategoryStatus(bool isOpen, String categoryId) async =>
      await _categoriesService.updateCategoryStatus(isOpen, categoryId);
}
