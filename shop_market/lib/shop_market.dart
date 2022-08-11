import 'package:flutter/material.dart';
import 'package:shop_market/views/shop_view.dart';

class ShopMarket extends StatelessWidget {
  const ShopMarket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:Colors.transparent,

          elevation: 0,
          title: const Text('Shop Market',style: TextStyle(color:Colors.black),),
          toolbarHeight: 80,
          leading: IconButton(
            icon: const Icon(Icons.menu_sharp,color: Color.fromRGBO(216, 67, 21, 1),size: 30,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        drawer: Drawer(
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
                      builder: (context) =>  const ShopView(),
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
        ),
        body:  const ShopView(),
        bottomNavigationBar: BottomNavigationBar(
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
          currentIndex: 0,
          selectedItemColor: Colors.deepOrange[800],
          onTap: (int index) =>  print('onTap: $index'),
        ),
      ),
    );
  }
}
