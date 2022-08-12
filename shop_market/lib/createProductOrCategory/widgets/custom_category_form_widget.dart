import 'package:flutter/material.dart';
import 'package:shop_market/createProductOrCategory/widgets/form_widgets/custom_color_picker_widget.dart';

import 'form_widgets/widgets.dart';

class CategoryFormWidget extends StatelessWidget {
  const CategoryFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        const Text("Create Category"),
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
        const Text("Define color"),
        ColorPickerWidget(onChangeColorPicker: (color)=> print(color)),
        CustomFormButtonSubmitWidget(
            onPressed: () {}, buttonLabel: 'Submit Category')
      ],
    ));
    ;
  }
}
