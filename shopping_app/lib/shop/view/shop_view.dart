import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/home/widgets/custom_circular_progress_indicator_widget.dart';
import 'package:shopping_app/shop/models/product_arragment_model.dart';
import '../../categories/bloc/categories_bloc.dart';
import '../../categories/models/category_model.dart';
import '../../createProductOrCategory/bloc/products/products_bloc.dart';
import '../../createProductOrCategory/view/form_create_product_or_category_view.dart';
import '../../createProductOrCategory/widgets/form_widgets/widgets.dart';
import '../../home/bloc/blocs.dart';
import '../widgets/widgets.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  late List<DragAndDropList> _contents;
  late List<CategoryModel> _categories;
  List<ProductArragmentModel> _products = [];
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

  generateDraggableItems(List<ProductArragmentModel> products, int index) {
    _products = products;
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
                      productId:
                          products[index].products[productIndex].productId,
                      category: products[index].products[productIndex].category,
                      categories: _categories));
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
              ),
            ),
          );
        }));
  }

  configureDraggableItemList() {
    return DragAndDropLists(
      contentsWhenEmpty: const Text("No products yet"),
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

      // _products[newListIndex].products.insert(newItemIndex, movedItem);
    });
    // var newCategory = _products[newListIndex].products[newItemIndex].category;
    // var newProductId = _products[oldListIndex].products[oldItemIndex].productId;
    // print(newCategory.toJson());
    // print(newProductId.toString());
    // _productsBloc.add(UpdateProductsCategoryEvent(
    //     newCategory: newCategory,
    //     context: context,
    //     productId: newProductId,
    //     categories: _categories));
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {});
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
                      isEnabled: true,
                      label: 'Create my first category',
                      iconButton: Icons.plus_one,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FormCreateProductOrCategoryView(
                                    addCategory: true,
                                  ))),
                    ),
                  ),
                ],
              );
            }
            if (state is CategoriesRetrieved) {
              _categories = state.retrievedCategories;
              _productsBloc.add(RetrieveProductsWithCategoryEvent(
                  category: state.retrievedCategories));
              final int categoriesIndex = state.retrievedCategories.length;
              return Column(
                children: [
                  Form(child: CustomFormFieldWidget(
                    label: 'Search ',
                    isEnabled: true,
                    keyboardType: TextInputType.text,
                    obscureText:false,

                    onChanged: (value) {
                     
                    }, icon: const Icon(Icons.search),
                  )),
                  
                  Expanded(
                    child: BlocBuilder<ProductsBloc, ProductsState>(
                      builder: (context, state) {
                        if (state is ProductsArragmentRetrieved) {
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
                                  isEnabled: true,
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
            return const CustomCircularProgressIndicatorWidget(
              text: "Loading Categories",
            );
          },
        ));
  }
}
