import '../../createProductOrCategory/services/database_service.dart';
import '../models/favorite_model.dart';

class FavoritesRepository{
final _databaseService = DatabaseService();
  


  Future<void> addFavorite(FavoriteModel favorite)=>_databaseService.createFavorite(favorite);
  Future<void> removeFavorite(String productId) async => _databaseService.deleteFavorite(productId);
  
  Future<List<FavoriteModel>> getFavoriteDateAdd(String productId) => _databaseService.retrieveFavoriteDateAdd(productId);

}