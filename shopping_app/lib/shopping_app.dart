import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/createProductOrCategory/bloc/products/products_bloc.dart';
import 'package:shop_market/createProductOrCategory/repository/products/products_repository.dart';
import 'package:shop_market/home/home.dart';
import 'createProductOrCategory/create_product_or_category.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({Key? key, required ProductsRepository productRepository})
      : _productRepository = productRepository,
        super(key: key);
  final ProductsRepository _productRepository;
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductsRepository>(
            create: (context) => _productRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BottombarNavigationBloc>(
            create: (context) => BottombarNavigationBloc(),
          ),
          BlocProvider<TitleChangerBloc>(
            create: (context) => TitleChangerBloc(),
          ),
          BlocProvider<ProductsBloc>(
            create: (context) => ProductsBloc(
                productRepository: RepositoryProvider.of<ProductsRepository>(context)),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            key: scaffoldKey,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            appBar: AppbarWidget(scaffoldKey: scaffoldKey),
            drawer: const DrawerWidget(),
            body: const PagesView(),
            floatingActionButton: const FabWidget(),
            bottomNavigationBar: const BottombarWidget(),
          ),
        ),
      ),
    );
  }
}
