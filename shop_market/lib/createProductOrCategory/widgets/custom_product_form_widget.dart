import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/createProductOrCategory/models/category_model.dart';
import 'package:shop_market/createProductOrCategory/models/product_model.dart';

import '../bloc/products/products_bloc.dart';
import 'form_widgets/widgets.dart';

class ProductFormWidget extends StatefulWidget {
  const ProductFormWidget({Key? key}) : super(key: key);
  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    var productModel = ProductModel(
        productName: _nameController.text,
        category: CategoryModel(
            categoryColor: '0xFF4CAF50', categoryName: 'Zapatillas'),
        isFavorite: false,
        productImage: '');
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
                  onChanged: (text) => setState(() {
                        productModel.productName = text;
                      }),
                  fieldController: _nameController),
              CustomFormFieldWidget(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  label: 'Category',
                  icon: const Icon(
                    Icons.description,
                    color: Color.fromRGBO(216, 67, 21, 1),
                  ),
                  onChanged: (text) => setState(() {
                        productModel.category.categoryName = text;
                      }),
                  fieldController: _categoryController),
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
              onPressed: () async=> productsBloc.add(CreateProductEvent(product: productModel)),
              buttonLabel: 'Submit Product')
        ],
      )),
    );
  }
}
