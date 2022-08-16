import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../createProductOrCategory/bloc/blocs.dart';
import 'custom_drag_and_drop_item_content_widget.dart';

 customDragAndDropItemWidget(context, products, index,categories) {
  var container = Container(
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
  var container2 = Container(
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
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
  return DragAndDropItem(
    child: Dismissible(
      key: UniqueKey(),
      background: container2,
      secondaryBackground: container,
      onDismissed: (direction) => onDismissed(direction, context, products, index,categories),
      child: DragAndDropItemContentWidget(
        index: index,
        products: products,
        categories: categories,
      ),
    ),
  );
}

void onDismissed(direction, context, products, index,categories) {
  final productsBloc = BlocProvider.of<ProductsBloc>(context);
  if (direction == DismissDirection.endToStart) {
    productsBloc.add(DeleteProductEvent(productId: products[index].productId,categories: categories));
    productsBloc.add(ProductWasDeletedEvent(context: context));
  }
  if (direction == DismissDirection.startToEnd) {
    productsBloc.add(UpdateProductsFavoriteEvent(
        isFavorite: !products[index].isFavorite,
        productId: products[index].productId));
    if (!products[index].isFavorite) {
      productsBloc.add(ProductWasAddedToFavoritesEvent(context: context));
    } else {
      productsBloc.add(ProductWasDeletedFromFavoritesEvent(context: context));
    }
  }
}
