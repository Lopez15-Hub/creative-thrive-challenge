import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  CategoryModel(
      {required this.categoryName,
      required this.categoryColor,
      this.categoryId = ''});

  String categoryName;
  String categoryColor;
  String categoryId;

  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    return CategoryModel(
      categoryId: snapshot.id,
      categoryName: snapshot['categoryName'],
      categoryColor: snapshot['categoryColor'],
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categoryId: json['id']?? '',
        categoryName: json["categoryName"],
        categoryColor: json["categoryColor"],
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "categoryColor": categoryColor,
      };
}
