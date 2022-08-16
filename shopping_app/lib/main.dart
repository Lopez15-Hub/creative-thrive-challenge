import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/createProductOrCategory/repository/repositories.dart';
import 'package:shopping_app/favorites/repository/favorites_repository.dart';
import 'categories/repository/categories_repository.dart';
import 'package:shopping_app/shopping_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ShoppingApp(
    favoritesRepository: FavoritesRepository(),
    filePickerRepository: FilePickerRepository(),
    categoriesRepository: CategoriesRepository(),
    productRepository: ProductsRepository(),
    storageRepository: StorageRepository(),
  ));
}
