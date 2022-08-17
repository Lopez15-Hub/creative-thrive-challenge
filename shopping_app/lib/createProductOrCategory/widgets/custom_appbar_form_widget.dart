import 'package:flutter/material.dart';
import 'package:shopping_app/home/view/views.dart';
import 'custom_dynamic_title_widget.dart';

class AppbarFormWidget extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppbarFormWidget({Key? key, })
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
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
          Icons.arrow_back_ios_new,
          color: Color.fromRGBO(216, 67, 21, 1),
          size: 30,
        ),
        onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                         const HomeView())),
      ),
    );
  }
}

