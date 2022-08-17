import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

import '../helpers/arragment_helpers.dart';
class CustomDraggableListGeneratorWidget extends StatefulWidget {
  const CustomDraggableListGeneratorWidget({
    Key? key,
    required this.itemDecorationWhileDragging,
    required this.listInnerDecoration,
    required this.contents,
  }) : super(key: key);
  final List<DragAndDropListInterface> contents;
  final BoxDecoration itemDecorationWhileDragging;
  final BoxDecoration listInnerDecoration;

  @override
  State<CustomDraggableListGeneratorWidget> createState() => _CustomDraggableListGeneratorWidgetState();
}

class _CustomDraggableListGeneratorWidgetState extends State<CustomDraggableListGeneratorWidget> {

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = widget.contents[oldListIndex].children?.removeAt(oldItemIndex);
      widget.contents[newListIndex].children?.insert(newItemIndex, movedItem!);

    });

  }
  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return DragAndDropLists(
      contentsWhenEmpty: const Text("No products yet"),
      children: widget.contents,
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
      lastItemTargetHeight: 8,
      addLastItemTargetHeightToTop: true,
      lastListTargetSize: 40,
      listPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemDivider:const Divider(thickness: 2, height: 2, color: Colors.transparent),
      itemDecorationWhileDragging: widget.itemDecorationWhileDragging,
      listInnerDecoration: widget.listInnerDecoration,
      listDragHandle: customDragHandle(),
      itemDragHandle: customItemDragHandle(),
    );
  }
}
