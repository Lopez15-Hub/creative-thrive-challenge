import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/navigation/navigation_bloc.dart';
class DynamicTextAppbarWidget extends StatelessWidget {
  const DynamicTextAppbarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, int>(
      builder: (context, currentIndex) {
        switch (currentIndex) {
          case 0:
            return const Text(
              'Shop',
              style: TextStyle(color: Colors.black),
            );
          case 1:
            return const Text(
              'Favorites',
              style: TextStyle(color: Colors.black),
            );
          case 2:
            return const Text(
              'Categories',
              style: TextStyle(color: Colors.black),
            );
          default:
            return const Text(
              'Shop',
              style: TextStyle(color: Colors.black),
            );
        }
      },
    );
  }
}
