import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/categories/view/categories_view.dart';
import 'package:shop_market/favorites/view/favorites_view.dart';
import 'package:shop_market/home/bloc/bottombar_navigation/bottombar_navigation_bloc.dart';
import 'package:shop_market/shop/view/shop_view.dart';

class PagesView extends StatelessWidget {
  const PagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottombarNavigationBloc, int>(
      builder: (context, currentIndex) {
        switch (currentIndex) {
          case 0:
            return const ShopView();
          case 1:
            return const FavoritesView();
          case 2:
            return const CategoriesView();
          default:
            return const ShopView();
        }
      },
    );
  }
}
