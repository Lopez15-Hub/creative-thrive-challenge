import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'pages_view.dart';
class HomeView extends StatelessWidget {
  const HomeView({
    Key? key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
        var scaffoldKey = GlobalKey<ScaffoldState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
        appBar: CustomAppbarWidget(scaffoldKey: scaffoldKey),
        drawer: const CustomDrawerWidget(),
        body: const PagesView(),
        floatingActionButton: const CustomFabWidget(),
        bottomNavigationBar: const CustomBottombarWidget(),
      ),
    );
  }
}