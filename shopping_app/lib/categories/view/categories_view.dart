import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/bloc/categories_bloc.dart';
import 'package:shopping_app/categories/widgets/custom_category_item.dart';
import 'package:shopping_app/home/bloc/blocs.dart';
import 'package:shopping_app/home/widgets/custom_circular_progress_indicator_widget.dart';

import '../../createProductOrCategory/view/form_create_product_or_category_view.dart';
import '../../createProductOrCategory/widgets/form_widgets/widgets.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    final popupBloc = BlocProvider.of<ShowPopupBloc>(context);
    categoriesBloc.add(const ListeningCategoriesEvent());
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesRetrieved) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),

            itemBuilder: (context, index) => CustomCategoryItem(
              popupBloc: popupBloc,
              state: state,
              index: index,
            ),
            itemCount: state.retrievedCategories.length,
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
