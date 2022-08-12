import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_market/createProductOrCategory/repository/products/products_repository.dart';
import 'package:shop_market/shopping_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ShoppingApp(productRepository: ProductRepository(),));
}
