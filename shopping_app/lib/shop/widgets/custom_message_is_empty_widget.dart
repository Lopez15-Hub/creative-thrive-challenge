import 'package:flutter/material.dart';
import '../../createProductOrCategory/create_product_or_category.dart';
import '../../createProductOrCategory/widgets/form_widgets/widgets.dart';

class CustomMessageIsEmptyWidget extends StatelessWidget {
  const CustomMessageIsEmptyWidget({
    Key? key, required this.message, required this.label,
  }) : super(key: key);
  final String message,label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         CustomTitleWidget(
            title:message,
            alignment: TextAlign.center),
        Center(
          child: CustomButtonSmallWidget(
            isEnabled: true,
            label: label,
            iconButton: Icons.plus_one,
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const FormCreateProductOrCategoryView())),
          ),
        ),
      ],
    );
  }
}
