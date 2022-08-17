import 'package:cloud_firestore/cloud_firestore.dart';

import '../../favorites/models/favorite_model.dart';

class FavoritesService{
    

  final favoritesCollection =
      FirebaseFirestore.instance.collection("favorites");
  Future<List<FavoriteModel>> retrieveFavoriteDateAdd(productId) {
    return favoritesCollection
        .where("productId", isEqualTo: productId)
        .get()
        .then((snapshot) => snapshot.docs
            .map((favorite) => FavoriteModel.fromSnapshot(favorite))
            .toList());
  }

  Future<void> createFavorite(FavoriteModel favorite) async =>
      await favoritesCollection.doc(favorite.productId).set(favorite.toJson());
  Future<void> deleteFavorite(String productId) async =>
      await favoritesCollection.doc(productId).delete();
}