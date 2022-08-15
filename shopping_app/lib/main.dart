import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/createProductOrCategory/repository/products_repository.dart';
import 'categories/repository/categories_repository.dart';
import 'package:shopping_app/shopping_app.dart';

import 'home/repository/permission_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ShoppingApp(

    categoriesRepository: CategoriesRepository(),
    productRepository: ProductsRepository(),
    permissionRepository: PermissionRepository(),
  ));
}
