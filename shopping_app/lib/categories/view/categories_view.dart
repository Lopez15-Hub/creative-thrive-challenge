import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/categories.dart';
import 'package:shopping_app/categories/widgets/custom_category_item.dart';
import 'package:shopping_app/categories/widgets/custom_category_listview_widget.dart';
import 'package:shopping_app/home/bloc/blocs.dart';
import 'package:shopping_app/home/widgets/custom_circular_progress_indicator_widget.dart';

import '../../createProductOrCategory/view/form_create_product_or_category_view.dart';
import '../../createProductOrCategory/widgets/form_widgets/widgets.dart';
import '../../shop/widgets/widgets.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

@override
class _CategoriesViewState extends State<CategoriesView> {
  late final CategoriesBloc categoriesBloc;
  late final ShowPopupBloc showPopupBloc;
  late List<CategoryModel> _categories;
  @override
  void initState() {
    super.initState();
    categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    showPopupBloc = BlocProvider.of<ShowPopupBloc>(context);
    categoriesBloc.add(const CategoriesAreOnLoadingEvent(isLoading: true));
    categoriesBloc.add(const ListeningCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        List<CategoryModel> categories = [];
        if (state is CategoriesRetrieved) {
          _categories = state.retrievedCategories;
          categories.addAll(state.retrievedCategories);
          return customCategoryListviewWidget(
              listViewOptions: CategoryListViewOptionsModel(
            categories: categories,
            categoriesToShow: _categories,
            showPopupBloc: showPopupBloc,
            categoriesBloc: categoriesBloc,
            onReorder: (int oldIndex, int newIndex) => {
              setState(() {
                final List<CategoryModel> newCategoryList = [];
                if (oldIndex < newIndex) newIndex -= 1;
                final item = categories.removeAt(oldIndex);
                categories.insert(newIndex, item);
                newCategoryList.addAll(categories);
                categoriesBloc.add(UpdateCategoriesPositionEvent(
                    categoriesList: newCategoryList));
              })
            },
          ));
        }
        if (state is CategoriesRetrievedError) {
          return Center(
            child: Text(state.error.toString()),
          );
        }
        if (state is CategoriesListIsEmpty) {
          return const CustomMessageIsEmptyWidget(
            label: 'Create my first category',
            message: 'You don\'t have any products and categories yet.',
          );
        }

        if (state is CategoriesIsLoading) {
          return const CustomCircularProgressIndicatorWidget(
            text: 'Retrieving categories',
          );
        }

        return const CustomCircularProgressIndicatorWidget(
          text: "Loading Categories",
        );
      },
    );
  }
}
