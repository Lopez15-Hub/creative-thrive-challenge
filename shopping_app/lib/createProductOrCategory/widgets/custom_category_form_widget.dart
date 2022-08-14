// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shop_market/createProductOrCategory/widgets/form_widgets/custom_color_picker_widget.dart';

import 'form_widgets/widgets.dart';

class CategoryFormWidget extends StatelessWidget {
  const CategoryFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const CustomTitleWidget(title: 'Category Name', alignment: TextAlign.start),
              CustomFormFieldWidget(
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  label: 'Name of category',
                  icon: const Icon(
                    Icons.description,
                    color: Color.fromRGBO(216, 67, 21, 1),
                  ),
                  onChanged: (text)=> print("Texto: $text"),
                  fieldController: TextEditingController()),
            ],
          ),
          Column(
            children: [
              const CustomTitleWidget(
                  title: 'Color', alignment: TextAlign.start),
              ColorPickerWidget(onChangeColorPicker: (color) => print(color)),
            ],
          ),
          CustomFormButtonSubmitWidget(
              onPressed: () {}, buttonLabel: 'Submit Category')
        ],
      )),
    );
    
  }
}
