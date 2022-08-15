import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/models/category_model.dart';
import 'package:shopping_app/createProductOrCategory/bloc/dropdown_button/dropdown_button_bloc.dart';
import 'package:shopping_app/createProductOrCategory/models/product_model.dart';
import '../bloc/products/products_bloc.dart';
import 'form_widgets/widgets.dart';

class ProductFormWidget extends StatefulWidget {
  const ProductFormWidget({Key? key}) : super(key: key);
  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  late String productName, productPrice;
  CategoryModel productCategory =
      CategoryModel(categoryColor: '', categoryName: '');
  @override
  Widget build(BuildContext context) {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
   final dropdownButtonBloc =BlocProvider.of<DropdownButtonBloc>(context);
    return Expanded(
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomTitleWidget(
                  title: 'Product Data', alignment: TextAlign.center),
              CustomFormFieldWidget(
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

                  dropdownButtonBloc
                      .add(SelectCategory(selectedCategory: CategoryModel(categoryColor: category!.categoryColor, categoryName: category.categoryName)));

                
                },
              ),
              CustomFormFieldWidget(
                keyboardType: TextInputType.text,
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
          CustomFormButtonSubmitWidget(
              onPressed: () {
                int index = Random().nextInt(4);
                var productModel = ProductModel(
                  productName: productName,
                  productPrice: productPrice,
                  productImage: "https://picsum.photos/60/60?image=$index",
                  isFavorite: false,
                  category: dropdownButtonBloc.state,
                );
                productsBloc.add(CreateProductEvent(product: productModel));
              },
              buttonLabel: 'Submit Product')
        ],
      )),
    );
  }
}
