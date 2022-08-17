import '../../createProductOrCategory/services/services.dart';
import '../models/favorite_model.dart';

class FavoritesRepository {
  final _favoritesService = FavoritesService();
  Future<void> addFavorite(FavoriteModel favorite) =>
      _favoritesService.createFavorite(favorite);
  Future<void> removeFavorite(String productId) async =>
      _favoritesService.deleteFavorite(productId);
  Future<List<FavoriteModel>> getFavoriteDateAdd(String productId) =>
      _favoritesService.retrieveFavoriteDateAdd(productId);
}
