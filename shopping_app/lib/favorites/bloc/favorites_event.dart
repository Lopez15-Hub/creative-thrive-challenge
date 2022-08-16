part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent extends Equatable {}



class CreateFavoriteEvent extends FavoritesEvent {
  final FavoriteModel favorite;
  CreateFavoriteEvent({ required this.favorite});

  @override
  List<Object> get props => [favorite];
}

class DeleteFavoriteEvent extends FavoritesEvent {
  final String productId;
  DeleteFavoriteEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}

class ListeningFavoriteDateAddEvent extends FavoritesEvent {
  final String productId;
  ListeningFavoriteDateAddEvent({required this.productId});
  
  @override
  List<Object?> get props => [productId];


}
