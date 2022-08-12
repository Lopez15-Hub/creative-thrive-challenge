// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/createProductOrCategory/models/product_model.dart';

import '../../createProductOrCategory/bloc/products/products_bloc.dart';

class DragAndDropItemContentWidget extends StatelessWidget {
  const DragAndDropItemContentWidget(
      {Key? key, required this.index, required this.products})
      : super(key: key);
  final int index;
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
              onPressed: () => productsBloc.add(UpdateProductsFavoriteEvent(
                  productId: products[index].productId,
                  isFavorite: !products[index].isFavorite)),
              icon: Icon(
                  products[index].isFavorite ? Icons.star : Icons.star_border,
                  size: 30)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(products[index].productImage,
                  height: 60, width: 60, fit: BoxFit.fill)),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                products[index].productName,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                products[index].category.categoryName,
                style: TextStyle(
                    fontSize: 12,
                    color: Color(
                        int.parse(products[index].category.categoryColor))),
              ),
            ],
          ),
        ),
        Text(
          '\$ ${products[index].productPrice}',
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
