import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/createProductOrCategory/widgets/form_widgets/custom_button_small_widget.dart';
import 'package:shopping_app/createProductOrCategory/widgets/form_widgets/custom_title_widget.dart';
import 'package:shopping_app/home/bloc/blocs.dart';
import 'package:shopping_app/shop/models/product_arragment_model.dart';
import '../../categories/bloc/categories_bloc.dart';
import '../../categories/models/category_model.dart';
import '../../createProductOrCategory/bloc/products/products_bloc.dart';
import '../../createProductOrCategory/view/form_create_product_or_category_view.dart';
import '../../home/widgets/custom_circular_progress_indicator_widget.dart';
import '../../shop/widgets/widgets.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late List<DragAndDropList> _contents;
  final List<CategoryModel> _categories = [];
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

  generateDraggableItems(List<ProductArragmentModel> products, int index) {
    return DragAndDropList(
        header: Column(
          children: <Widget>[
            DragAndDropListHeaderWidget(
              index: index,
              categories: products[index].category,
            ),
          ],
        ),
        children: List<DragAndDropItem>.generate(
            products[index].products.length, (productIndex) {
          return DragAndDropItem(
            child: Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      !products[index].products[productIndex].isFavorite
                          ? "Add to favorites"
                          : "Remove from favorites",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Delete",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onDismissed: (direction) {
                final productsBloc = BlocProvider.of<ProductsBloc>(context);
                if (direction == DismissDirection.endToStart) {
                  _showPopupBloc.add(ShowPopupEvent(
                      mustBeShowed: true,
                      context: context,
                      categoryId: '',
                      productId: products[productIndex]
                          .products[productIndex]
                          .productId,
                      categories: _categories));

                  // productsBloc.add(ProductWasDeletedEvent(context: context));
                }
                if (direction == DismissDirection.startToEnd) {
                  productsBloc.add(UpdateProductsFavoriteEvent(
                      categories: _categories,
                      isFavorite:
                          !products[index].products[productIndex].isFavorite,
                      productId:
                          products[index].products[productIndex].productId));
                  if (!products[index].products[productIndex].isFavorite) {
                    productsBloc
                        .add(ProductWasAddedToFavoritesEvent(context: context));
                  } else {
                    productsBloc.add(
                        ProductWasDeletedFromFavoritesEvent(context: context));
                  }
                }
              },
              child: CustomDragAndDropItemContentWidget(
                index: productIndex,
                products: products[index].products,
                categories: _categories,
                isFavoriteView: true,
              ),
            ),
          );
        }));
  }

  configureDraggableItemList() {
    return DragAndDropLists(
      contentsWhenEmpty: const Text("No favorites yet"),
      children: _contents,
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
      lastItemTargetHeight: 8,
      addLastItemTargetHeightToTop: true,
      lastListTargetSize: 40,
      listPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemDivider:
          const Divider(thickness: 2, height: 2, color: Colors.transparent),
      itemDecorationWhileDragging: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      listInnerDecoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 179, 179, 179).withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      listDragHandle: const DragHandle(
        verticalAlignment: DragHandleVerticalAlignment.top,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.menu,
            color: Colors.black26,
          ),
        ),
      ),
      itemDragHandle: const DragHandle(
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.menu,
            color: Color.fromRGBO(216, 67, 21, 1),
          ),
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesListIsEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomTitleWidget(
                      title: 'You dont have categories and products yet',
                      alignment: TextAlign.center),
                  Center(
                    child: CustomButtonSmallWidget(
                      label: 'Create my first category',
                      iconButton: Icons.plus_one,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FormCreateProductOrCategoryView())),
                    ),
                  ),
                ],
              );
            }
            if (state is CategoriesRetrieved) {
              _productsBloc.add(RetrieveProductsFavoritesWithCategoryEvent(
                  category: state.retrievedCategories));
              int categoriesIndex = state.retrievedCategories.length;
              return BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsFavoriteRetrieved) {
                    _contents = List.generate(
                        categoriesIndex,
                        (index) => generateDraggableItems(
                            state.retrievedProducts, index));
                    return configureDraggableItemList();
                  }

                  if (state is ProductsRetrievedError) {
                    return Center(
                      child: Text(state.error.toString()),
                    );
                  }
                  if (state is ProductsListIsEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTitleWidget(
                            title: 'You dont have products',
                            alignment: TextAlign.center),
                        Center(
                          child: CustomButtonSmallWidget(
                            label: 'Add one',
                            iconButton: Icons.plus_one,
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FormCreateProductOrCategoryView())),
                          ),
                        ),
                      ],
                    );
                  }

                  return const CustomCircularProgressIndicatorWidget(
                    text: "Loading Products",
                  );
                },
              );
            }
            return const CustomCircularProgressIndicatorWidget(
              text: "Loading Categories",
            );
          },
        ));
  }
}
