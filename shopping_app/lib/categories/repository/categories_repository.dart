import '../../createProductOrCategory/services/database_service.dart';
import '../models/category_model.dart';

class CategoriesRepository {
  final _databaseService = DatabaseService();

  Future<List<CategoryModel>> getCategories() => _databaseService.retrieveCategories();
  Stream<List<CategoryModel>> getCategoriesStream() => _databaseService.retrieveCategoriesStream();
  Future<List<CategoryModel>> getCategory(String categoryName) => _databaseService.retrieveCategory(categoryName);

  Future<void> createCategory(CategoryModel category) async =>await _databaseService.createCategory(category);
  Future<void> deleteCategory(String categoryId) async =>await _databaseService.deleteCategory(categoryId);
  Future<void> updateCategory(String categoryId, CategoryModel newCategoryData) async =>await _databaseService.updateCategory(categoryId, newCategoryData);
  Future<void> updateCategoryStatus(bool isOpen,String categoryId) async =>await _databaseService.updateCategoryStatus(isOpen,categoryId);
}
