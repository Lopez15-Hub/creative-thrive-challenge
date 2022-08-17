import 'package:animate_do/animate_do.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/home/bloc/blocs.dart';
import 'package:shopping_app/shop/models/models.dart';
import '../../categories/bloc/categories_bloc.dart';
import '../../categories/models/category_model.dart';
import '../../createProductOrCategory/bloc/products/products_bloc.dart';
import '../../createProductOrCategory/models/models.dart';
import '../../home/widgets/custom_circular_progress_indicator_widget.dart';
import '../../shop/helpers/helpers.dart';
import '../../shop/widgets/widgets.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late List<DragAndDropList> _contents;
  final List<CategoryModel> _categories = [];
  List<ProductModel> productsList = [];
  late ProductsBloc _productsBloc;
  late ShowPopupBloc _showPopupBloc;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesBloc>(context)
        .add(const ListeningCategoriesEvent());
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _showPopupBloc = BlocProvider.of<ShowPopupBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FadeIn(
          animate: true,
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesRetrieved) {
                _productsBloc.add(RetrieveProductsFavoritesWithCategoryEvent(
                    category: state.retrievedCategories));
                int categoriesIndex = state.retrievedCategories.length;
                return BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductsFavoriteRetrieved) {
                      _contents = List.generate(
                          categoriesIndex,
                          (categoriesIndex) => generateDraggableItems(
                              productsList,
                              OptionsModel(
                                  context: context,
                                  showPopupBloc: _showPopupBloc,
                                  categoryIndex: categoriesIndex,
                                  productIndex: productsList.length,
                                  categories: _categories,
                                  productsArragment: state.retrievedProducts)));
                      return configureDraggableItemList(_contents);
                    }

                    if (state is ProductsRetrievedError)return Center(child: Text(state.error.toString()),);
                    if (state is ProductsListIsEmpty)  return const CustomMessageIsEmptyWidget(label: 'Add one',message: 'You don\'t have products yet.',);
                    return const CustomCircularProgressIndicatorWidget(
                        text: "Loading Products");
                  },
                );
              }
              if (state is CategoriesRetrievedError) {
                return Center(
                  child: Text(state.error.toString()),
                );
              }
              if (state is CategoriesListIsEmpty)return const CustomMessageIsEmptyWidget(label: 'Create my first category',message: 'You don\'t have any products and categories yet.',);
              return const CustomCircularProgressIndicatorWidget(text: "Loading Categories",);
            },
          ),
        ));
  }
}
