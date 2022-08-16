import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';

class CustomAppbarWidget extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppbarWidget({Key? key, required this.scaffoldKey})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const DynamicTextAppbarWidget(),
      toolbarHeight: 80,
      leading: IconButton(
        icon: const Icon(
          Icons.menu_sharp,
          color: Color.fromRGBO(216, 67, 21, 1),
          size: 30,
        ),
        onPressed: () => scaffoldKey.currentState!.openDrawer(),
      ),
    );
  }
}

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
