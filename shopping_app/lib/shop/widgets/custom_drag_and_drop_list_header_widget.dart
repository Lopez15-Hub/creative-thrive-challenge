import 'package:flutter/material.dart';
import 'package:shopping_app/categories/categories.dart';

class DragAndDropListHeaderWidget extends StatelessWidget {
  const DragAndDropListHeaderWidget(
      {Key? key, required this.categories, required this.index})
      : super(key: key);
  final CategoryModel categories;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            categories.categoryName,
            style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Color(int.parse(categories.categoryColor))),
          ),
        ),
      ],
    );
  }
}
