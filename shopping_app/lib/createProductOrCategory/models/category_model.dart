import 'package:cloud_firestore/cloud_firestore.dart';


class CategoryModel {
  CategoryModel({
    required this.categoryName,
    required this.categoryColor,
  });

  String categoryName;
  String categoryColor;

  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CategoryModel(
      categoryName: snapshot['categoryName'],
      categoryColor: snapshot['categoryColor'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      "name": categoryName,
      "color": categoryColor,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryName: json["categoryName"],
        categoryColor: json["categoryColor"],
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "categoryColor": categoryColor,
      };
}
