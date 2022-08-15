import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/categories.dart';
import 'package:shopping_app/createProductOrCategory/widgets/form_widgets/custom_color_picker_widget.dart';

import '../../categories/bloc/categories_bloc.dart';
import '../bloc/blocs.dart';
import 'form_widgets/widgets.dart';

class CategoryFormWidget extends StatefulWidget {
  const CategoryFormWidget({Key? key}) : super(key: key);

  @override
  State<CategoryFormWidget> createState() => _CategoryFormWidgetState();
}

extractColorProperty(color) =>
    color.toString().replaceAll("Color(", "").replaceAll(")", "").trim();

class _CategoryFormWidgetState extends State<CategoryFormWidget> {
  String categoryName = '';
  Color categoryColor = Colors.white;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    final formBloc = BlocProvider.of<FormValidationsBloc>(context);
    return Expanded(
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const CustomTitleWidget(
                      title: 'Category Name', alignment: TextAlign.start),
                  CustomFormFieldWidget(
                    validatorFunction: (currentValue) =>
                        currentValue!.trim().isEmpty
                            ? 'Please enter a category name'
                            : null,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    label: 'Name of category',
                    icon: const Icon(
                      Icons.description,
                      color: Color.fromRGBO(216, 67, 21, 1),
                    ),
                    onChanged: (text) => setState(() {
                      categoryName = text;
                    }),
                  ),
                ],
              ),
              Column(
                children: [
                  const CustomTitleWidget(
                      title: 'Color', alignment: TextAlign.start),
                  ColorPickerWidget(
                    onChangeColorPicker: (color) => categoryColor = color,
                  ),
                ],
              ),
              CustomFormButtonSubmitWidget(
                  onPressed: () {
                    final formIsValid = _formKey.currentState!.validate();
                    formBloc.add(FormFieldsAreValidEvent(formIsValid));
                    formBloc.add(ValidateCategoryFormEvent(
                        context: context,
                        categoryColor: extractColorProperty(categoryColor)));
                    var categoryModel = CategoryModel(
                        categoryName: categoryName.trim(),
                        categoryColor: extractColorProperty(categoryColor));
   
                    categoriesBloc.add(CreateCategoryEvent(
                        context: context, category: categoryModel));
                    _formKey.currentState!.reset();
                  },
                  buttonLabel: 'Submit Category')
            ],
          )),
    );
  }
}
