import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/bloc/blocs.dart';
import '../bloc/categories_bloc.dart';

class CustomCategoryItem extends StatelessWidget {
  const CustomCategoryItem(
      {Key? key,
      required this.popupBloc,
      required this.state,
      required this.index})
      : super(key: key);

  final ShowPopupBloc popupBloc;
  final dynamic state;
  final int index;
  @override
  Widget build(BuildContext context) {
    final categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    var dangerContainer = Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Delete Category",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(),
      secondaryBackground: dangerContainer,
      onDismissed: (direction) {
        popupBloc.add(ShowPopupEvent(
            mustBeShowed: true,
            context: context,
            categoryId: state.categoryId));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
        child: ListTile(
          title: Text(
            state.categoryName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(int.parse(state.categoryColor))),
          ),
          subtitle: Text(
           !state.isOpen? "Status: closed" : "Status: open",
            style: TextStyle(fontSize: 12, color: !state.isOpen? Colors.blue: Colors.green),
          ),
          trailing: IconButton(
            icon: Icon( !state.isOpen?Icons.archive : Icons.send_and_archive,
                size: 30, semanticLabel: 'Close category'),
            onPressed: () => categoriesBloc.add(UpdateCategoriesStatusEvent(
                isOpen: !state.isOpen,
                categoryId: state.categoryId,
                context: context)),
          ),
        ),
      ),
    );
  }
}
