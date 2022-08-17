import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/view/categories_view.dart';
import 'package:shopping_app/favorites/view/favorites_view.dart';
import 'package:shopping_app/home/bloc/blocs.dart';
import 'package:shopping_app/shop/view/shop_view.dart';

class PagesView extends StatelessWidget {
  const PagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, int>(
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
