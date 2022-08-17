import 'package:flutter/material.dart';

import '../../createProductOrCategory/bloc/blocs.dart';
import '../../createProductOrCategory/widgets/form_widgets/widgets.dart';
class CustomSearchBarWidget extends StatelessWidget {
  const CustomSearchBarWidget({
    Key? key,
    required ProductsBloc productsBloc,
  }) : _productsBloc = productsBloc, super(key: key);

  final ProductsBloc _productsBloc;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: CustomFormFieldWidget(
      label: 'Search ',
      isEnabled: true,
      keyboardType: TextInputType.text,
      obscureText: false,
      onChanged: (value) => _productsBloc
          .add(SearchProductEvent(searchTerm: value)),
      icon: const Icon(Icons.search),
    ));
  }
}