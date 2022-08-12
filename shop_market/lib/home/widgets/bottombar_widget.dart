import 'package:flutter/material.dart';
import 'package:shop_market/home/bloc/bottombar_navigation/bottombar_navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottombarWidget extends StatelessWidget {
  const BottombarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationBloc = context.read<BottombarNavigationBloc>();
    return BlocBuilder<BottombarNavigationBloc, int>(
      builder: (context, currentIndex) {
        return BottomNavigationBar(
          elevation: 0,
          iconSize: 30,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.deepOrange[800],
          onTap: (int index) => () => navigationBloc.add(ChangePageView(index)),
        );
      },
    );
  }
}
