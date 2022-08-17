import 'package:animate_do/animate_do.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/createProductOrCategory/models/models.dart';
import 'package:shopping_app/home/widgets/custom_circular_progress_indicator_widget.dart';
import '../../categories/bloc/categories_bloc.dart';
import '../../categories/models/category_model.dart';
import '../../createProductOrCategory/bloc/products/products_bloc.dart';
import '../../home/bloc/blocs.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import '../helpers/arragment_helpers.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  late List<DragAndDropList> _contents;
  late List<CategoryModel> _categories;
  List<ProductModel> productsList = [];
  List<ProductArragmentModel> productsArragmentList = [];
  late ShowPopupBloc _showPopupBloc;
  late ProductsBloc _productsBloc;
  late CategoriesBloc _categoriesBloc;
  @override
  void initState() {
    _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    _showPopupBloc = BlocProvider.of<ShowPopupBloc>(context);
    _productsBloc = BlocProvider.of<ProductsBloc>(context);
    _categoriesBloc.add(const CategoriesAreOnLoadingEvent(isLoading: true));
    _categoriesBloc.add(const ListeningCategoriesEvent());
    super.initState();
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
                _categories = state.retrievedCategories;
                _productsBloc.add(RetrieveProductsWithCategoryEvent(
                    category: state.retrievedCategories));
                final int categoriesIndex = state.retrievedCategories.length;

                return Column(
                  children: [
                    CustomSearchBarWidget(productsBloc: _productsBloc),
                    Expanded(
                      child: BlocBuilder<ProductsBloc, ProductsState>(
                        builder: (context, state) {
                          if (state is ProductsArragmentRetrieved) {
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
                                        productsArragment:
                                            state.retrievedProducts)));

                            return configureDraggableItemList(_contents);
                          }
                          if (state is ProductsRetrievedError)return Center(child: Text(state.error.toString()),);
                          if (state is ProductsListIsEmpty)return const CustomMessageIsEmptyWidget(label: 'Add one',message: 'You don\'t have products yet.',);
                          return const CustomCircularProgressIndicatorWidget(text: "Loading Products");
                        },
                      ),
                    ),
                  ],
                );
              }
              if (state is CategoriesRetrievedError) {
                return Center(
                  child: Text(state.error.toString()),
                );
              }
              if (state is CategoriesListIsEmpty) return const CustomMessageIsEmptyWidget(label: 'Create my first category',message: 'You don\'t have any products and categories yet.',);
              return const CustomCircularProgressIndicatorWidget(
                text: "Loading Categories",
              );
            },
          ),
        ));
  }
}
