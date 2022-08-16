part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesDateAddRetrieved extends FavoritesState {
  final List<FavoriteModel> favoritesList;
  FavoritesDateAddRetrieved({required this.favoritesList});
  List<Object?> get props => [favoritesList];
}
