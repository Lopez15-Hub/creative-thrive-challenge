import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  CategoryModel({
    required this.categoryName,
    required this.categoryColor,
  });

  String categoryName;
  String categoryColor;

  factory CategoryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CategoryModel(
      categoryName: data?['categoryName'],
      categoryColor: data?['categoryColor'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
       "name": categoryName,
      "image": categoryColor,
    };
  }
}
