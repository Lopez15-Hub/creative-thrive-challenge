import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/categories.dart';
import '../../createProductOrCategory/bloc/blocs.dart';
import '../../createProductOrCategory/models/models.dart';
import '../../home/bloc/blocs.dart';
import '../models/options_model.dart';
import '../models/product_arragment_model.dart';
import '../widgets/widgets.dart';


class GenerateDraggableItemsOptions {
  final List<CategoryModel> categories;
  final List<ProductArragmentModel> productsArragment;
  final ShowPopupBloc showPopupBloc;
  GenerateDraggableItemsOptions({
    required this.categories,
    required this.productsArragment,
    required this.showPopupBloc,
  });
}

void onDismissed(direction, OptionsModel optionsModel) {
  final productsBloc = BlocProvider.of<ProductsBloc>(optionsModel.context);
  if (direction == DismissDirection.endToStart) {
    optionsModel.showPopupBloc.add(ShowPopupEvent(
        mustBeShowed: true,
        context: optionsModel.context,
        categoryId: '',
        productId: optionsModel.productsArragment[optionsModel.categoryIndex]
            .products[optionsModel.productIndex].productId,
        category: optionsModel.productsArragment[optionsModel.categoryIndex]
            .products[optionsModel.productIndex].category,
        categories: optionsModel.categories));
  }
  if (direction == DismissDirection.startToEnd) {
    productsBloc.add(UpdateProductsFavoriteEvent(
        categories: optionsModel.categories,
        isFavorite: !optionsModel.productsArragment[optionsModel.categoryIndex]
            .products[optionsModel.productIndex].isFavorite,
        productId: optionsModel.productsArragment[optionsModel.categoryIndex]
            .products[optionsModel.productIndex].productId));
    if (!optionsModel.productsArragment[optionsModel.categoryIndex]
        .products[optionsModel.productIndex].isFavorite) {
      productsBloc
          .add(ProductWasAddedToFavoritesEvent(context: optionsModel.context));
    } else {
      productsBloc.add(
          ProductWasDeletedFromFavoritesEvent(context: optionsModel.context));
    }
  }
}

generateDraggableItems(
    List<ProductModel> productsList, OptionsModel optionsModel) {
  return DragAndDropList(
      header: Column(
        children: <Widget>[
          DragAndDropListHeaderWidget(
            index: optionsModel.categoryIndex,
            categories: optionsModel
                .productsArragment[optionsModel.categoryIndex].category,
          ),
        ],
      ),
      children: List<DragAndDropItem>.generate(
          optionsModel.productsArragment[optionsModel.categoryIndex].products
              .length, (productIndex) {
        optionsModel.productsArragment
            .map((item) => productsList.add(item.products[productIndex]));
        return DragAndDropItem(
          child: Dismissible(
            key: UniqueKey(),
            background: CustomAddToFavoritesBackgroundWidget(
                optionsModel: optionsModel),
            secondaryBackground:
                const CustomDeleteProductFavoritesBackgroundWidget(),
            onDismissed: (direction) => onDismissed(direction, optionsModel),
            child: CustomDragAndDropItemContentWidget(
              index: productIndex,
              products: optionsModel
                  .productsArragment[optionsModel.categoryIndex].products,
              categories: optionsModel.categories,
            ),
          ),
        );
      }));
}

class CustomDeleteProductFavoritesBackgroundWidget extends StatelessWidget {
  const CustomDeleteProductFavoritesBackgroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Delete",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CustomAddToFavoritesBackgroundWidget extends StatelessWidget {
  const CustomAddToFavoritesBackgroundWidget({
    Key? key,
    required this.optionsModel,
  }) : super(key: key);

  final OptionsModel optionsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            !optionsModel.productsArragment[optionsModel.categoryIndex]
                    .products[optionsModel.productIndex].isFavorite
                ? "Add to favorites"
                : "Remove from favorites",
            textAlign: TextAlign.start,
            style: const TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

configureDraggableItemList(List<DragAndDropList> contents) {
  var itemDecorationWhileDragging = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 3,
        offset: const Offset(0, 0), // changes position of shadow
      ),
    ],
  );
  var listInnerDecoration = BoxDecoration(
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
  );
  return CustomDraggableListGeneratorWidget(
      itemDecorationWhileDragging: itemDecorationWhileDragging,
      listInnerDecoration: listInnerDecoration,
      contents: contents);
}

DragHandle customItemDragHandle() {
  return const DragHandle(
    child: Padding(
      padding: EdgeInsets.only(right: 10),
      child: Icon(
        Icons.menu,
        color: Color.fromRGBO(216, 67, 21, 1),
      ),
    ),
  );
}

DragHandle customDragHandle() {
  return const DragHandle(
    verticalAlignment: DragHandleVerticalAlignment.top,
    child: Padding(
      padding: EdgeInsets.only(right: 10),
      child: Icon(
        Icons.menu,
        color: Colors.black26,
      ),
    ),
  );
}
