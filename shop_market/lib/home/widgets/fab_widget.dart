import 'package:flutter/material.dart';
import 'package:shop_market/createProductOrCategory/view/form_create_product_or_category_view.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const FormCreateProductOrCategoryView())),
      backgroundColor: const Color.fromRGBO(216, 67, 21, 1),
      child: const Icon(
        Icons.add_circle,
        size: 30,
      ),
    );
  }
}
