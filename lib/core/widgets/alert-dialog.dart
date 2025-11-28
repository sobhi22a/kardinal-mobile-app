import 'package:flutter/material.dart';

void genericAlertDialog({
  required BuildContext context, required String title, required String text, @required function }) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: const TextStyle(color: Colors.redAccent),),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              function();
            },
            child: const Text('Oui', style: TextStyle(color: Colors.green)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Non', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      );
    },
  );
}