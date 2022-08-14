import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/createProductOrCategory/bloc/title_changer/title_changer_bloc.dart';

class DynamicTitleWidget extends StatelessWidget {
  const DynamicTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TitleChangerBloc, bool>(
      builder: (context, formIndex) {
        return Text(
          formIndex ? 'Add Category' : 'Add Product',
          style: const TextStyle(color: Colors.black),
        );
      },
    );
  }
}
