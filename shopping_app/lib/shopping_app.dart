import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/repository/categories_repository.dart';
import 'package:shopping_app/createProductOrCategory/repository/products_repository.dart';
import 'package:shopping_app/favorites/bloc/favorites_bloc.dart';
import 'package:shopping_app/favorites/repository/favorites_repository.dart';
import 'package:shopping_app/home/home.dart';
import 'package:shopping_app/home/repository/permission_repository.dart';
import 'categories/bloc/categories_bloc.dart';
import 'createProductOrCategory/create_product_or_category.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp(
      {Key? key,
      required ProductsRepository productRepository,
      required CategoriesRepository categoriesRepository,
      required PermissionRepository permissionRepository,
      required FavoritesRepository favoritesRepository})
      : _productRepository = productRepository,
        _categoriesRepository = categoriesRepository,
        _permissionRepository = permissionRepository,
        _favoritesRepository = favoritesRepository,
        super(key: key);

  final ProductsRepository _productRepository;
  final CategoriesRepository _categoriesRepository;
  final PermissionRepository _permissionRepository;
  final FavoritesRepository _favoritesRepository;
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductsRepository>(
            create: (context) => _productRepository),
        RepositoryProvider<CategoriesRepository>(
            create: (context) => _categoriesRepository),
        RepositoryProvider<PermissionRepository>(
            create: (context) => _permissionRepository),
        RepositoryProvider<FavoritesRepository>(
            create: (context) => _favoritesRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FormValidationsBloc>(
              create: (context) => FormValidationsBloc()),
          BlocProvider<BottombarNavigationBloc>(
            create: (context) => BottombarNavigationBloc(),
          ),
          BlocProvider<ShowPopupBloc>(
            create: (context) => ShowPopupBloc(),
          ),
          BlocProvider<DropdownButtonBloc>(
            create: (context) => DropdownButtonBloc(),
          ),
          BlocProvider<TitleChangerBloc>(
            create: (context) => TitleChangerBloc(),
          ),
          BlocProvider<PermissionBloc>(
            create: (context) => PermissionBloc(
                permissionRepository:
                    RepositoryProvider.of<PermissionRepository>(context)),
          ),
          BlocProvider<SnackbarBloc>(
            create: (context) => SnackbarBloc(),
          ),
          BlocProvider<ProductsBloc>(
            create: (context) => ProductsBloc(
                productRepository:
                    RepositoryProvider.of<ProductsRepository>(context)),
          ),
          BlocProvider<CategoriesBloc>(
            create: (context) => CategoriesBloc(
                categoriesRepository:
                    RepositoryProvider.of<CategoriesRepository>(context)),
          ),
          BlocProvider<FavoritesBloc>(
            create: (context) => FavoritesBloc(
                favoritesRepository:
                    RepositoryProvider.of<FavoritesRepository>(context)),
          ),
        ],
        child: MaterialApp(
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
        ),
      ),
    );
  }
}
