import 'package:flutter/material.dart';

import '../../shop/view/shop_view.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
 
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Shop Market'),
          ),
          ListTile(
            title: const Text('Shop'),
            leading: const Icon(Icons.shopping_bag),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShopView(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Favourites'),
            leading: const Icon(Icons.bookmark_add),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShopView(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Add product'),
            leading: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShopView(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Add category'),
            leading: const Icon(Icons.category),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShopView(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
