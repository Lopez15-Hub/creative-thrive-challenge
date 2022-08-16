import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/bloc/categories_bloc.dart';
import 'package:shopping_app/categories/models/category_model.dart';
import 'package:shopping_app/createProductOrCategory/bloc/blocs.dart';
import 'package:shopping_app/home/widgets/custom_circular_progress_indicator_widget.dart';
import 'form_widgets/widgets.dart';

class ProductFormWidget extends StatefulWidget {
  const ProductFormWidget({Key? key}) : super(key: key);
  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late ProductsBloc productsBloc;
  late CategoriesBloc categoriesBloc;
  late FormValidationsBloc formBloc;
  late DropdownButtonBloc dropdownButtonBloc;

  String productName = '', productPrice = '';
  CategoryModel productCategory =
      CategoryModel(categoryColor: '', categoryName: '', isOpen: true);
  @override
  void initState() {
    super.initState();
    productsBloc = BlocProvider.of<ProductsBloc>(context);
    dropdownButtonBloc = BlocProvider.of<DropdownButtonBloc>(context);
    formBloc = BlocProvider.of<FormValidationsBloc>(context);
    categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    categoriesBloc.add(const ListeningCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTitleWidget(
                          title: 'Product Data', alignment: TextAlign.center),
                      CustomFormFieldWidget(
                        isEnabled:
                            state is CategoriesListIsEmpty ? false : true,
                        validatorFunction: (currentValue) =>
                            currentValue!.trim().isEmpty
                                ? 'Please enter a name'
                                : null,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        label: 'Name of product',
                        icon: const Icon(
                          Icons.description,
                          color: Color.fromRGBO(216, 67, 21, 1),
                        ),
                        onChanged: (text) => {
                          setState(() => productName = text),
                        },
                      ),
                      const CustomTitleWidget(
                          title: 'Category', alignment: TextAlign.center),
                      CustomDropdownButtonWidget(
                        onCategorySelected: (category) {
                          dropdownButtonBloc.add(SelectCategory(
                              selectedCategory: CategoryModel(
                                  categoryColor: category!.categoryColor,
                                  categoryName: category.categoryName,
                                  isOpen: true)));
                        },
                      ),
                      CustomFormFieldWidget(
                        isEnabled:
                            state is CategoriesListIsEmpty ? false : true,
                        validatorFunction: (currentValue) =>
                            currentValue!.trim().isEmpty
                                ? 'Please enter a price'
                                : null,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        label: 'Price',
                        icon: const Icon(
                          Icons.monetization_on,
                          color: Color.fromRGBO(216, 67, 21, 1),
                        ),
                        onChanged: (text) => {
                          setState(() => productPrice = text),
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const CustomTitleWidget(
                          title: 'Product Image', alignment: TextAlign.center),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: CustomButtonSmallWidget(
                          label: 'Upload File',
                          onPressed: () {},
                          iconButton: Icons.upload_file,
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductIsOnSubmitedEvent) {
                        return const CustomCircularProgressIndicatorWidget(
                          text: 'Saving product',
                        );
                      }
                      return Container();
                    },
                  ),
                  CustomFormButtonSubmitWidget(
                      isEnabled: state is CategoriesListIsEmpty ? false : true,
                      onPressed: state is CategoriesListIsEmpty
                          ? () {}
                          : () => addProduct(),
                      buttonLabel: 'Submit Product'),
                ],
              ));
        },
      ),
    );
  }

  addProduct() {
    try {
      formBloc.add(FormFieldsAreValidEvent(_formKey.currentState!.validate()));
      int index = Random().nextInt(4);
      productsBloc.add(const ProductIsOnSubmitedEvent(isOnSubmit: true));
      formBloc.add(ValidateProductFormEvent(
          context: context, dropdownCategory: dropdownButtonBloc.state));

      if (formBloc.state) {
        return productsBloc.add(ProductOnSubmitedEvent(
            isFavorite: false,
            productCategory: dropdownButtonBloc.state,
            productImage: "https://picsum.photos/60/60?image=$index",
            productName: productName,
            productPrice: productPrice.toString(),
            context: context));
      }
    } catch (error) {
      return productsBloc.add(ProductFunctionHasErrorEvent(
          error: error.toString(), context: context));
    }
  }
}
