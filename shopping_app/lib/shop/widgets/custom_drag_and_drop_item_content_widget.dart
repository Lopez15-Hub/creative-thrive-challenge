import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/categories/categories.dart';
import 'package:shopping_app/createProductOrCategory/models/product_model.dart';

import '../../createProductOrCategory/bloc/products/products_bloc.dart';
import '../../favorites/bloc/favorites_bloc.dart';
import '../../home/widgets/custom_circular_progress_indicator_widget.dart';

class CustomDragAndDropItemContentWidget extends StatelessWidget {
  const CustomDragAndDropItemContentWidget(
      {Key? key,
      required this.index,
      required this.products,
      this.isFavoriteView = false,
      required this.categories})
      : super(key: key);
  final int index;
  final bool isFavoriteView;
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  @override
  Widget build(BuildContext context) {
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    BlocProvider.of<FavoritesBloc>(context).add(
        ListeningFavoriteDateAddEvent(productId: products[index].productId));
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
              onPressed: () {
                productsBloc.add(UpdateProductsFavoriteEvent(
                    categories: categories,
                    productId: products[index].productId,
                    isFavorite: !products[index].isFavorite));
                if (!products[index].isFavorite) {
                  productsBloc
                      .add(ProductWasAddedToFavoritesEvent(context: context));
                } else {
                  productsBloc.add(
                      ProductWasDeletedFromFavoritesEvent(context: context));
                }
              },
              icon: Icon(
                  products[index].isFavorite ? Icons.star : Icons.star_border,
                  size: 30)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                products[index].productImage,
                height: 60,
                width: 60,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CustomCircularProgressIndicatorWidget();
                    
                  },
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                products[index].productName,
                style: const TextStyle(fontSize: 18),
              ),
              Visibility(
                visible: isFavoriteView,
                child: BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, state) {
                    if (state is FavoritesDateAddRetrieved) {
                      return Text(
                        "Added: ${state.favoritesList[index].dateAdded.toString().substring(0, 10)}",
                        style: const TextStyle(fontSize: 14),
                      );
                    }
                    return const CustomCircularProgressIndicatorWidget(
                      text: "Loading date",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Text(
          'USD  \$${products[index].productPrice}',
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
