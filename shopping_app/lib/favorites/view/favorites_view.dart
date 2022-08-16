import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/createProductOrCategory/models/product_model.dart';
import 'package:shopping_app/createProductOrCategory/widgets/form_widgets/custom_button_small_widget.dart';
import 'package:shopping_app/createProductOrCategory/widgets/form_widgets/custom_title_widget.dart';
import 'package:shopping_app/home/bloc/bottombar_navigation/bottombar_navigation_bloc.dart';
import '../../categories/bloc/categories_bloc.dart';
import '../../createProductOrCategory/bloc/products/products_bloc.dart';
import '../../home/widgets/custom_circular_progress_indicator_widget.dart';
import '../../shop/widgets/widgets.dart';
import '../bloc/favorites_bloc.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  late List<DragAndDropList> _contents;
  @override
  void initState() {
    super.initState();

    //test
  }

   generateDraggableItems(List<ProductModel> products, int index,state) {
    BlocProvider.of<FavoritesBloc>(context).add(ListeningFavoriteDateAddEvent(productId: state.retrievedProducts[index].productId));
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
                isFavoriteView: true,
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

  @override
  Widget build(BuildContext context) {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    final navigationBloc = BlocProvider.of<BottombarNavigationBloc>(context);
    productsBloc.add(ListeningProductsFavoritesEvent());
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsListIsEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const CustomTitleWidget(title: 'You dont have favorites', alignment: TextAlign.center),
                  Center(
                    child: CustomButtonSmallWidget(
                      label: 'Go to shop',
                      iconButton: Icons.shopping_cart,
                      onPressed: () => navigationBloc.add(const ChangePageView(0)),
                    ),
                  ),
                ],
              );
            }
            if (state is ProductsFavoriteRetrieved) {

              _contents = List.generate(
                  state.retrievedProducts.length,
                  (index) => generateDraggableItems(state.retrievedProducts, index,state));
              return configureDraggableItemList();
            }

            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromRGBO(216, 67, 21, 1),
            ));
          },
        ));
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
