import 'package:cloud_firestore/cloud_firestore.dart';


class FavoriteModel {
  FavoriteModel({

    required this.productId,
    required this.dateAdded,      
             this.favoriteId = ""
  });


  String productId,favoriteId;

  DateTime dateAdded;

  static FavoriteModel fromSnapshot(DocumentSnapshot snapshot) {
    return FavoriteModel(
      //id
      favoriteId: snapshot.id,
      productId:  snapshot['productId'],
      dateAdded: snapshot['dateAdded'].toDate(),
    );
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        favoriteId: json['id'],
        productId: json['productId'],
        dateAdded: json["dateAdded"].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "dateAdded": dateAdded,
        "productId": productId,
      };
}
