  import 'package:flutter/material.dart';
import 'package:shopping_app/categories/widgets/custom_category_item.dart';
import '../models/models.dart';



ReorderableListView customCategoryListviewWidget({required CategoryListViewOptionsModel listViewOptions}) {
    return ReorderableListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20),
          onReorder:listViewOptions.onReorder,
          children: listViewOptions.categories.map(
                (categories) => CustomCategoryItem(
                  key: ValueKey(categories.categoryId),
                  popupBloc: listViewOptions.showPopupBloc,
                  state: categories,
                  index: 0,
                  categories: listViewOptions.categoriesToShow,
                ),
              )
              .toList(),
        );
  }
