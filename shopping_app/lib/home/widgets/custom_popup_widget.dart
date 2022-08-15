import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../categories/bloc/categories_bloc.dart';

Future<void> customPopupWidget(context, title, content, categoryId) async {
  final categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
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
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
              child: const Text('Delete item'),
              onPressed: () {
                categoriesBloc.add(DeleteCategoryEvent(
                    categoryId: categoryId, context: context));
              }),
        ],
      );
    },
  );
}
