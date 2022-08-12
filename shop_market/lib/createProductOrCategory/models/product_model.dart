import 'package:cloud_firestore/cloud_firestore.dart';

import 'category_model.dart';

class ProductModel {
  ProductModel({
    required this.productName,
    required this.productImage,
    required this.category,
    required this.isFavorite,
  });

  String productName;
  String productImage;
  CategoryModel category;
  bool isFavorite;

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
      productName: data?['productName'],
      productImage: data?['productImage'],
      category: CategoryModel.fromFirestore(data?['category'], options),
      isFavorite: data?['isFavorite'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "productName": productName,
      "productImage": productImage,
      "category": category.toFirestore(),
      "isFavorite": isFavorite,
    };
  }
}
