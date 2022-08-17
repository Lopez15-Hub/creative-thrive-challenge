import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/createProductOrCategory/bloc/blocs.dart';
import 'package:shopping_app/home/widgets/custom_circular_progress_indicator_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      if (state is ProductsRetrieved) {
        return ListView.builder(
            itemBuilder: ((context, index) => ListTile(
                  title: Text(state.retrievedProducts[index].productName),
                  subtitle: Text(
                    state.retrievedProducts[index].category.categoryName,
                    style: TextStyle(
                        color: Color(int.parse(state
                            .retrievedProducts[index].category.categoryName))),
                  ),
                  leading: Image.network(
                      state.retrievedProducts[index].productImage),
                )));
      }
      return const CustomCircularProgressIndicatorWidget(
        text: 'Searching',
      );
    });
  }
}
