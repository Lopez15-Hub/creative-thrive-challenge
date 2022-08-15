import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/createProductOrCategory/models/product_model.dart';
import 'package:shopping_app/home/widgets/custom_circular_progress_indicator_widget.dart';
import '../../categories/bloc/categories_bloc.dart';
import '../../createProductOrCategory/bloc/products/products_bloc.dart';
import '../../createProductOrCategory/view/form_create_product_or_category_view.dart';
import '../../createProductOrCategory/widgets/form_widgets/widgets.dart';
import '../widgets/custom_drag_and_drop_item_widget.dart';
import '../widgets/widgets.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  late List<DragAndDropList> _contents;
  late CategoriesBloc categoriesBloc;
  late ProductsBloc productsBloc;
  @override
  void initState() {
    super.initState();
    categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    categoriesBloc.add(const ListeningCategoriesEvent());
    productsBloc = BlocProvider.of<ProductsBloc>(context);
    //test
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
              final int categoriesIndex = state.retrievedCategories.length;
              _contents = List.generate(categoriesIndex,
                  (categoriesIndex) => generateDraggableItems(categoriesIndex));
              return configureDraggableItemList();
            }
            return const CustomCircularProgressIndicatorWidget(
              text: "Loading Categories",
            );
          },
        ));
  }

  generateDraggableItems(int index) {
    final List<ProductModel> products = [];
    return DragAndDropList(
        header: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesRetrieved) {
              final category = state.retrievedCategories;
              productsBloc.add(ListeningProductsByCategoryEvent(category: state.retrievedCategories[index]));

              return BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  // if (state is ProductsListIsEmpty) const CustomTitleWidget(title: 'You dont have products in this category',alignment: TextAlign.center);

                    return Column(
                      children: <Widget>[
                        DragAndDropListHeaderWidget(
                          index: index,
                          categories: category,
                        ),
                      ],
                    );

                },
              );
            }
            return const CustomCircularProgressIndicatorWidget(
              text: "Loading Categories",
            );
          },
        ),
        children: List<DragAndDropItem>.generate(products.length,(index) => customDragAndDropItemWidget(context, products, index)));
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
