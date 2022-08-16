
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/bloc/categories_bloc.dart';
import 'package:shopping_app/categories/categories.dart';
import 'package:shopping_app/categories/widgets/custom_category_item.dart';
import 'package:shopping_app/home/bloc/blocs.dart';
import 'package:shopping_app/home/widgets/custom_circular_progress_indicator_widget.dart';

import '../../createProductOrCategory/view/form_create_product_or_category_view.dart';
import '../../createProductOrCategory/widgets/form_widgets/widgets.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    final categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    final popupBloc = BlocProvider.of<ShowPopupBloc>(context);
    categoriesBloc.add(const ListeningCategoriesEvent());
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        List<CategoryModel> categories = [];
        if (state is CategoriesRetrieved) {
            categories.addAll(state.retrievedCategories);
          return ReorderableListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 20, right: 20),
            onReorder: (int oldIndex, int newIndex) =>print("{oldIndex:$oldIndex, newIndex:$newIndex}"),
            children: categories
                .map(
                  (categories) => CustomCategoryItem(
                    key: ValueKey(categories.categoryId),
                    popupBloc: popupBloc,
                    state: categories,
                    index: 0,
                  ),
                )
                .toList(),
          );
        }
        if (state is CategoriesListIsEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomTitleWidget(
                  title: 'You dont have categories yet.',
                  alignment: TextAlign.center),
              Center(
                child: CustomButtonSmallWidget(
                  label: 'Add one',
                  iconButton: Icons.plus_one,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FormCreateProductOrCategoryView())),
                ),
              ),
            ],
          );
        }
        
        return const CustomCircularProgressIndicatorWidget(
          text: 'Retrieving Categories',
        );
      },
    );
  }
}
