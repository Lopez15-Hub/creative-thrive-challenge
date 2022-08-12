import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/createProductOrCategory/create_product_or_category.dart';
import '../bloc/bottombar_navigation/bottombar_navigation_bloc.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationBloc = context.read<BottombarNavigationBloc>();
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(216, 67, 21, 1),
            ),
            child: Center(
                child: Text(
              'Shop Market',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )),
          ),
          ListTile(
            title: const Text('Shop'),
            leading: const Icon(Icons.shopping_bag),
            onTap: () {
              navigationBloc.add(const ChangePageView(0));
              Navigator.pop(context);
            },
          ),
          ListTile(
              title: const Text('Favourites'),
              leading: const Icon(Icons.star),
              onTap: () {
                navigationBloc.add(const ChangePageView(1));
                Navigator.pop(context);
              }),
          ListTile(
              title: const Text('Categories'),
              leading: const Icon(Icons.category),
              onTap: () {
                navigationBloc.add(const ChangePageView(2));
                Navigator.pop(context);
              }),
          const Divider(),
          ListTile(
            title: const Text('Add product'),
            leading: const Icon(Icons.add),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const FormCreateProductOrCategoryView())),
          ),
          ListTile(
            title: const Text('Add category'),
            leading: const Icon(Icons.add),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const FormCreateProductOrCategoryView())),
          ),
        ],
      ),
    );
  }
}
