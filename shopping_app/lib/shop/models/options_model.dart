import 'package:flutter/material.dart';

import '../../categories/categories.dart';
import '../../home/bloc/blocs.dart';
import 'product_arragment_model.dart';

class OptionsModel {
  final BuildContext context;
  final int categoryIndex;
  final int productIndex;
  final ShowPopupBloc showPopupBloc;
  final List<CategoryModel> categories;
  final List<ProductArragmentModel> productsArragment;
  OptionsModel({
    required this.context,
    required this.showPopupBloc,
    required this.categoryIndex,
    required this.productIndex,
    required this.categories,
    required this.productsArragment,
  });
}
