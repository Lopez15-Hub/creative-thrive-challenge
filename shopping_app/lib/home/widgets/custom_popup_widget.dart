import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/createProductOrCategory/bloc/blocs.dart';

import '../../categories/bloc/categories_bloc.dart';

Future<void> customPopupWidget(context, title, content, categoryId,
    {required productId, required categories}) async {
  final categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
  final productsBloc = BlocProvider.of<ProductsBloc>(context);
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              categoriesBloc.add(const ListeningCategoriesEvent());
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: const Text('Delete item'),
              onPressed: () {
                if (categoryId)categoriesBloc.add(DeleteCategoryEvent( categoryId: categoryId, context: context));
                if (productId)productsBloc.add(DeleteProductEvent(productId: productId, categories: categories));
              }),
        ],
      );
    },
  );
}
