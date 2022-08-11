import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  late List<DragAndDropList> _contents;

  @override
  void initState() {
    super.initState();

    _contents = List.generate(2, (index) {
      return DragAndDropList(
        header: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Header $index',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          'https://picsum.photos/50/50?image=${index + 1}',
                          fit: BoxFit.fill)),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Name $index',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Category $index',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '\$ 9.99',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Colors.transparent;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: DragAndDropLists(
        children: _contents,
        onItemReorder: _onItemReorder,
        onListReorder: _onListReorder,
        listPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        itemDivider: Divider(
          thickness: 2,
          height: 2,
          color: backgroundColor,
        ),
        itemDecorationWhileDragging: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        listInnerDecoration:  BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 179, 179, 179).withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius:const BorderRadius.all(Radius.circular(8.0)),
        ),
        lastItemTargetHeight: 8,
        addLastItemTargetHeightToTop: true,
        lastListTargetSize: 40,
        listDragHandle: const DragHandle(
          verticalAlignment: DragHandleVerticalAlignment.top,
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.menu,
              color: Colors.black26,
            ),
          ),
        ),
        itemDragHandle: const DragHandle(
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.menu,
              color: Color.fromRGBO(216, 67, 21, 1),
            ),
          ),
        ),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }
}
