import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/createProductOrCategory/models/product_model.dart';

import '../../categories/models/category_model.dart';

ProductArragmentModel productArragmentModelFromJson(String str) =>
    ProductArragmentModel.fromJson(json.decode(str));

String productArragmentModelToJson(ProductArragmentModel data) =>
    json.encode(data.toJson());

class ProductArragmentModel {
  ProductArragmentModel({
    required this.category,
    required this.products,
  });

  CategoryModel category;
  List<ProductModel> products;

  static ProductArragmentModel fromSnapshot(DocumentSnapshot snapshot) {
    return ProductArragmentModel(
      //id
      category: snapshot['category'],
      products: snapshot['products'],
    );
  }

  factory ProductArragmentModel.fromJson(Map<String, dynamic> json) =>
      ProductArragmentModel(
        category: CategoryModel.fromJson(json["category"]),
        products: List<ProductModel>.from(json["items"].map(
            (product) => ProductModel.fromJson(product, product["productId"]))),
      );

  Map<String, dynamic> toJson() => {
        "category": category.toJson(),
        "items":
            List<dynamic>.from(products.map((product) => product.toJson())),
      };
}
