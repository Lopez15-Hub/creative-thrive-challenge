import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/repository/categories_repository.dart';
import 'package:shopping_app/createProductOrCategory/repository/file_picker_repository.dart';
import 'package:shopping_app/createProductOrCategory/repository/products_repository.dart';
import 'package:shopping_app/createProductOrCategory/repository/storage_repository.dart';
import 'package:shopping_app/favorites/bloc/favorites_bloc.dart';
import 'package:shopping_app/favorites/repository/favorites_repository.dart';
import 'package:shopping_app/home/home.dart';
import 'categories/bloc/categories_bloc.dart';
import 'createProductOrCategory/create_product_or_category.dart';

class ShoppingApp extends StatelessWidget {
  const ShoppingApp(
      {Key? key,
      required ProductsRepository productRepository,
      required CategoriesRepository categoriesRepository,
      required FavoritesRepository favoritesRepository,
      required FilePickerRepository filePickerRepository,
      required StorageRepository storageRepository
      })
      : _productRepository = productRepository,
        _categoriesRepository = categoriesRepository,

        _favoritesRepository = favoritesRepository,
        _filePickerRepository = filePickerRepository,
        _storageRepository = storageRepository,
        super(key: key);

  final ProductsRepository _productRepository;
  final CategoriesRepository _categoriesRepository;
  final FavoritesRepository _favoritesRepository;
  final FilePickerRepository _filePickerRepository;
  final StorageRepository _storageRepository;
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductsRepository>(
            create: (context) => _productRepository),
        RepositoryProvider<CategoriesRepository>(
            create: (context) => _categoriesRepository),
        RepositoryProvider<FavoritesRepository>(
            create: (context) => _favoritesRepository),
        RepositoryProvider<FilePickerRepository>(
            create: (context) => _filePickerRepository),
        RepositoryProvider<StorageRepository>(create: (context) => _storageRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FormValidationsBloc>(
              create: (context) => FormValidationsBloc()),
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(),
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
          BlocProvider<FilePickerBloc>(
            create: (context) => FilePickerBloc(filePickerRepository:RepositoryProvider.of<FilePickerRepository>(context)),
          ),
          BlocProvider<UploadImageBloc>(
            create: (context) => UploadImageBloc(storageRepository:RepositoryProvider.of<StorageRepository>(context)),
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
