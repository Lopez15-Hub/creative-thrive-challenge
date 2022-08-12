import 'package:cloud_firestore/cloud_firestore.dart';

import 'category_model.dart';

class ProductModel {
  ProductModel({
    required this.productName,
    required this.productImage,
    required this.category,
    required this.isFavorite,
    required this.productPrice,
  });

  CategoryModel category;
  String productName;
  String productImage;
  String productPrice;
  bool isFavorite;

  static ProductModel fromSnapshot(DocumentSnapshot snapshot) {
    return ProductModel(
      productName: snapshot['productName'],
      productImage: snapshot['productImage'],
      category: CategoryModel.fromJson(snapshot['category']),
      isFavorite: snapshot['isFavorite'],
      productPrice: snapshot['productPrice'],
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productName: json["productName"],
        productImage: json["productImage"],
        category: CategoryModel.fromJson(json["category"]),
        isFavorite: json["isFavorite"],
        productPrice: json["productPrice"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "productImage": productImage,
        "category": category.toJson(),
        "isFavorite": isFavorite,
        "productPrice": productPrice,
      };
}
