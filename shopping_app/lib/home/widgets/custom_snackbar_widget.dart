import 'package:flutter/material.dart';

SnackBar customSnackbarWidget(BuildContext context,
    {Color snackbarColor = Colors.blue,
    Icon snackbarIcon = const Icon(Icons.info),
    String snackbarTitle = '',
    int snackbarDuration = 3}) {
  return SnackBar(
    backgroundColor: snackbarColor,
    elevation: 10,
    content: Row(
      children: [
        snackbarIcon,
        Text(
          snackbarTitle,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
        )
      ],
    ),
    duration: Duration(seconds: snackbarDuration),
    // action: SnackBarAction(label: 'Dismiss', onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()),
  );
}
