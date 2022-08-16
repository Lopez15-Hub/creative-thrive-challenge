import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/createProductOrCategory/bloc/blocs.dart';

import '../../categories/bloc/categories_bloc.dart';
import '../../categories/models/category_model.dart';

Future<void> customPopupWidget(BuildContext context,String title, String content,String categoryId,{required String productId, required  List<CategoryModel>categories}) async {
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
                if (categoryId.isNotEmpty)categoriesBloc.add(DeleteCategoryEvent( categoryId: categoryId, context: context));
                if (productId.isNotEmpty)productsBloc.add(DeleteProductEvent(productId: productId, categories: categories,context: context));
              }),
        ],
      );
    },
  );
}
