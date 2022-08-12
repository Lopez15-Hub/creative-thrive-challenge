import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget with PreferredSizeWidget {
@override
  final Size preferredSize;

  AppbarWidget({Key? key}) : preferredSize = const Size.fromHeight(56.0), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
          centerTitle: true,
          backgroundColor:Colors.transparent,

          elevation: 0,
          title: const Text('Shop Market',style: TextStyle(color:Colors.black),),
          toolbarHeight: 80,
          leading: IconButton(
            icon: const Icon(Icons.menu_sharp,color: Color.fromRGBO(216, 67, 21, 1),size: 30,),
            onPressed: ()=> Navigator.pop(context),
          ),
        );
  }
}