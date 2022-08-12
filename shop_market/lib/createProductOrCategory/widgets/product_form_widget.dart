import 'package:flutter/material.dart';

import 'form_widgets/widgets.dart';

class ProductFormWidget extends StatelessWidget {
  const ProductFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        const Text("Create Product"),
        const Text("Image product"),
        CustomButtonSmallWidget(label: 'Add image', onPressed: () {}),
        CustomFormFieldWidget(
            keyboardType: TextInputType.text,
            obscureText: false,
            label: 'Name of product',
            icon: const Icon(
              Icons.description,
              color: Color.fromRGBO(216, 67, 21, 1),
            ),
            onChanged: () {},
            fieldController: TextEditingController()),
        CustomFormFieldWidget(
            keyboardType: TextInputType.text,
            obscureText: false,
            label: 'Category',
            icon: const Icon(
              Icons.description,
              color: Color.fromRGBO(216, 67, 21, 1),
            ),
            onChanged: () {},
            fieldController: TextEditingController()),
        CustomFormButtonSubmitWidget(
            onPressed: () {}, buttonLabel: 'Submit Product')
      ],
    ));
  }
}
