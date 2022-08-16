import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/favorites/models/favorite_model.dart';
import 'package:shopping_app/favorites/repository/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required this.favoritesRepository})
      : super(FavoritesInitial()) {
    on<CreateFavoriteEvent>((event, emit) {
      favoritesRepository.addFavorite(event.favorite);
    });
    on<DeleteFavoriteEvent>((event, emit) {
      favoritesRepository.removeFavorite(event.productId);
    });
    on<ListeningFavoriteDateAddEvent>((event, emit) async {
      List<FavoriteModel> favoritesList =await favoritesRepository.getFavoriteDateAdd(event.productId);
      emit(FavoritesDateAddRetrieved(favoritesList: favoritesList)) ;
    });
  }
  final FavoritesRepository favoritesRepository;
}
