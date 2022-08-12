import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/categories/view/categories_view.dart';
import 'package:shop_market/favourites/view/favourites_view.dart';
import 'package:shop_market/home/bloc/bottombar_navigation/bottombar_navigation_bloc.dart';
import 'package:shop_market/shop_market.dart';

class PagesView extends StatelessWidget {
  const PagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottombarNavigationBloc, int>(
      builder: (context, currentIndex) {
        switch (currentIndex) {
          case 0:
            return const ShopMarket();
          case 1:
            return const FavouritesView();
          case 2:
            return const CategoriesView();
          default:
            return const ShopMarket();
        }
      },
    );
  }
}
