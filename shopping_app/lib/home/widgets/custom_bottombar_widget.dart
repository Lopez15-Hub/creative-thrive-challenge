import 'package:flutter/material.dart';
import 'package:shopping_app/home/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottombarWidget extends StatelessWidget {
  const CustomBottombarWidget({Key? key}) : super(key: key);
  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'Shop',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star),
      label: 'Favorites',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Categories',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final navigationBloc = context.read<NavigationBloc>();
    return BlocBuilder<NavigationBloc, int>(
      builder: (context, currentIndex) {
        return BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.deepOrange[800],
          onTap: (int index) => navigationBloc.add(ChangePageView(index)),
          elevation: 0,
          iconSize: 30,
          items: items,
        );
      },
    );
  }
}
