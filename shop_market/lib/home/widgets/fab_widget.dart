import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_market/createProductOrCategory/create_product_or_category.dart';
import '../bloc/bottombar_navigation/bottombar_navigation_bloc.dart';

class FabWidget extends StatelessWidget {
  const FabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottombarNavigationBloc, int>(
      builder: (context, currentIndex) {
        return Visibility(
          visible: currentIndex != 0 || currentIndex != 1 || currentIndex != 2
              ? true
              : false,
          child: FloatingActionButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const FormCreateProductOrCategoryView())),
            backgroundColor: const Color.fromRGBO(216, 67, 21, 1),
            child: const Icon(
              Icons.add_circle,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}
