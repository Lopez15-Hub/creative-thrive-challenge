import 'package:flutter/material.dart';

import '../../createProductOrCategory/models/product_model.dart';

class DragAndDropListHeaderWidget extends StatelessWidget {
  const DragAndDropListHeaderWidget(
      {Key? key, required this.products, required this.index})
      : super(key: key);
  final List<ProductModel> products;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            products[index].category.categoryName,
            style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Color(int.parse(products[index].category.categoryColor))),
          ),
        ),
      ],
    );
  }
}
