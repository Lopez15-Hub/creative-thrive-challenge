import 'package:flutter/material.dart';

class DragAndDropItemContentWidget extends StatelessWidget {
  const DragAndDropItemContentWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
              onPressed: () => print("fav"),
              icon: const Icon(Icons.star_border, size: 30)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  'https://picsum.photos/60/60?image=${index + 1}',
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
    );
  }
}
