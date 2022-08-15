import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/createProductOrCategory/models/product_model.dart';
import 'package:shopping_app/home/widgets/custom_circular_progress_indicator_widget.dart';
import '../../categories/bloc/categories_bloc.dart';
import '../../createProductOrCategory/bloc/products/products_bloc.dart';
import '../../createProductOrCategory/view/form_create_product_or_category_view.dart';
import '../../createProductOrCategory/widgets/form_widgets/widgets.dart';
import '../widgets/widgets.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  late List<DragAndDropList> _contents;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesBloc>(context)
        .add(const ListeningCategoriesEvent());
    //test
  }

  @override
  Widget build(BuildContext context) {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    productsBloc.add(ListeningProductsEvent());
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if( state is CategoriesListIsEmpty){
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
              final int categoriesIndex = state.retrievedCategories.length;
              return BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsRetrieved) {
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

  generateDraggableItems(List<ProductModel> products, int index) {
    return DragAndDropList(
        header: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesRetrieved) {
              return Column(
                children: <Widget>[
                  DragAndDropListHeaderWidget(
                    index: index,
                    categories: state.retrievedCategories,
                  ),
                ],
              );
            }
            return const CustomCircularProgressIndicatorWidget(
              text: "Loading Categories",
            );
          },
        ),
        children: List<DragAndDropItem>.generate(products.length, (index) {
          return DragAndDropItem(
            child: Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      !products[index].isFavorite
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
                  productsBloc.add(
                      DeleteProductEvent(productId: products[index].productId));
                  productsBloc.add(ProductWasDeletedEvent(context: context));
                }
                if (direction == DismissDirection.startToEnd) {
                  productsBloc.add(UpdateProductsFavoriteEvent(
                      isFavorite: !products[index].isFavorite,
                      productId: products[index].productId));
                  if (!products[index].isFavorite) {
                    productsBloc
                        .add(ProductWasAddedToFavoritesEvent(context: context));
                  } else {
                    productsBloc.add(
                        ProductWasDeletedFromFavoritesEvent(context: context));
                  }
                }
              },
              child: DragAndDropItemContentWidget(
                index: index,
                products: products,
              ),
            ),
          );
        }));
  }

  configureDraggableItemList() {
    return DragAndDropLists(
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
}
