import 'package:flutter/material.dart';
import 'custom_dynamic_title_widget.dart';

class AppbarFormWidget extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppbarFormWidget({Key? key, required this.scaffoldKey})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const DynamicTitleWidget(),
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

