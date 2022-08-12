import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/createProductOrCategory/bloc/products/products_bloc.dart';
import 'package:shop_market/createProductOrCategory/repository/products/products_repository.dart';
import 'package:shop_market/home/home.dart';
import 'createProductOrCategory/create_product_or_category.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({Key? key, required this.productRepository}) : super(key: key);
  final ProductRepository productRepository;
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    
    return MultiBlocProvider(
    
      providers: [
        BlocProvider<BottombarNavigationBloc>( create: (context) => BottombarNavigationBloc(),),
        BlocProvider<TitleChangerBloc>       ( create: (context) => TitleChangerBloc()       ,),
        BlocProvider<ProductsBloc>          ( create: (context) => ProductsBloc(productRepository:productRepository )          ,),
      ],
    
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        
        home: Scaffold(

          key: scaffoldKey,
          
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          appBar:                       AppbarWidget(scaffoldKey: scaffoldKey),
          drawer:               const   DrawerWidget(),
          body:                 const   PagesView(),
          floatingActionButton: const   FabWidget(),
          bottomNavigationBar:  const   BottombarWidget(),
        
        ),
      ),
    );
  }
}
