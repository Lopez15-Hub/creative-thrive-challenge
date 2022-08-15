import 'package:flutter/material.dart';

import '../../home/bloc/blocs.dart';

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
    var dangerContainer = Container(
      color: Colors.red,
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
    return SizedBox(
      
      child: Padding(
        padding: const EdgeInsets.only(left:20,right:20),
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          background: Container(),
          secondaryBackground: dangerContainer,
          onDismissed: (direction) {
              popupBloc.add(ShowPopupEvent(
                  mustBeShowed: true,
                  context: context,
                  categoryId: state.retrievedCategories[index].categoryId));
            },
          child: Card(
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20)),
              elevation: 4,
              child: ListTile(
                title: Text(
                  state.retrievedCategories[index].categoryName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(int.parse(
                          state.retrievedCategories[index].categoryColor))),
                ),
                subtitle: const Text(
                  "Status: closed",
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.archive,
                      size: 30, semanticLabel: 'Close category'),
                  onPressed: () => print("s"),
                ),
              ),
            ),
        ),
      ),
    );
  }
}
