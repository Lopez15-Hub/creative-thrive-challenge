import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/home/widgets/custom_circular_progress_indicator_widget.dart';

import '../../../categories/models/category_model.dart';
import '../../../categories/view/bloc/categories_bloc.dart';

class CustomDropdownButtonWidget extends StatefulWidget {
  const CustomDropdownButtonWidget({Key? key, required this.onCategorySelected})
      : super(key: key);
  final void Function(CategoryModel?)? onCategorySelected;
  @override
  State<CustomDropdownButtonWidget> createState() =>
      _CustomDropdownButtonWidgetState();
}

class _CustomDropdownButtonWidgetState
    extends State<CustomDropdownButtonWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesBloc>(context)
        .add(const ListeningCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
          if (state is CategoriesRetrieved) {
            return DropdownButton<CategoryModel>(
                value: state.retrievedCategories.first,
                icon: const Icon(Icons.arrow_downward),
                isExpanded: true,
                items: state.retrievedCategories.map((category) {
                  return DropdownMenuItem<CategoryModel>(
                      value: category,
                      child: Text(
                        category.categoryName,
                        style: TextStyle(
                          color: Color(int.parse(category.categoryColor)),
                        ),
                      ));
                }).toList(),
                elevation: 3,
                hint: const Text('Select a category'),
                onChanged: widget.onCategorySelected);
          }
          return const CustomCircularProgressIndicatorWidget(
            text: "Retrieving Categories",
          );
        }),
      ),
    );
  }
}