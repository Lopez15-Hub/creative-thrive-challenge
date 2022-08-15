import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/repository/categories_repository.dart';
import 'package:shopping_app/createProductOrCategory/repository/products_repository.dart';
import 'package:shopping_app/home/home.dart';
import 'package:shopping_app/home/repository/permission_repository.dart';
import 'categories/bloc/categories_bloc.dart';
import 'createProductOrCategory/create_product_or_category.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp(
      {Key? key,
      required ProductsRepository productRepository,
      required CategoriesRepository categoriesRepository,
      required PermissionRepository permissionRepository})
      : _productRepository = productRepository,
        _categoriesRepository = categoriesRepository,
        _permissionRepository = permissionRepository,
        super(key: key);

  final ProductsRepository _productRepository;
  final CategoriesRepository _categoriesRepository;
  final PermissionRepository _permissionRepository;
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
